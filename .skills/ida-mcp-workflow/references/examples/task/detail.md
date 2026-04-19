# detail.md

## 全体像

ログイン応答の ticket blob は、`NetworkClient::OnLoginResponse (0x18008C5D0)` から `TicketManager::ApplyLoginResponse (0x1800F3A20)` に渡り、そこで最低長チェックを通過した後、`sub_180245910 (0x180245910)` に引き渡される

`sub_180245910` は response 先頭 16 byte を IV とし、`SessionContext + 0x40` にある 32 byte を鍵として残りの block を復号する 復号後平文は `sub_1803A7120 (0x1803A7120)` で `SessionTicket` へ変換され、`SessionStore::SaveTicket (0x1801C8D40)` で保存される

header の確定レイアウトは [header.md](./header.md) を参照 caller を含む関数単位の詳細は `functions/*.md` に分けて持つ

## 入口

- `TicketManager::ApplyLoginResponse` は `response->max_length < 0x30` の場合に即 return する
- 長さが十分な場合、`this+0x28` の `SessionContext*` を取り出し、response buffer と length を `sub_180245910` へ渡す
- `sub_180245910` の戻り値が false の場合、`"login ticket decrypt failed"` のエラーログを出して終了する

この時点で、ログイン ticket 処理は `ApplyLoginResponse -> sub_180245910` の直列経路であると確定できる

## 復号処理

`sub_180245910` の処理は次の順序で進む

1. response 先頭 16 byte を stack 上の local buffer へコピーする
2. `SessionContext + 0x40` から 32 byte の鍵を読む
3. `sub_180118B20` を呼び、key と IV から 0xF0 byte の work buffer を作る
4. `response + 0x10` から末尾までを 16 byte 単位で loop する
5. 各 block 復号後に 1 つ前の ciphertext block と XOR する
6. 最後の 1 byte を `pad_len` として読み、末尾 `pad_len` byte を全件照合する
7. padding を除いた長さで `sub_1803A7120` を呼ぶ

上記 5 と 6 があるため、復号方式は AES-CBC、padding は PKCS#7 と判断できる

## 鍵と IV

- key: `SessionContext + 0x40` の 32 byte
  - 根拠: `sub_180245910` 冒頭で `ctx + 0x40` を読み、そのまま `sub_180118B20` へ渡す
- IV: response 先頭 16 byte
  - 根拠: `sub_180245910` 冒頭で `response[0x00..0x0F]` を local buffer へコピーし、loop 直前まで保持する
- ciphertext: response `+0x10` 以降
  - 根拠: block loop の開始ポインタが `response + 0x10`

## 保存処理

- `sub_1803A7120` は [header.md](./header.md) のレイアウトに従って `SessionTicket` を組み立てる
- `payload_size` と実際の平文長が一致した場合のみ `SessionStore::SaveTicket` を呼ぶ
- `SaveTicket` 呼び出し後、`ApplyLoginResponse` 側は success path に戻る

## 最終結論

- 受信 blob の先頭 16 byte は IV
- 復号鍵は `SessionContext + 0x40`
- 復号方式は AES-256-CBC + PKCS#7
- 復号本体は `sub_180245910`
- 平文 parse 本体は `sub_1803A7120`
- 保存先は `SessionStore::SaveTicket`
