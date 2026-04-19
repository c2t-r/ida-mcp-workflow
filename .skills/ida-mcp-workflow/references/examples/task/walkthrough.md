# walkthrough.md

## 2026-04-19 10:05

- `resources/il2cpp.cs` を検索し、`TicketManager::ApplyLoginResponse(byte[] response)` を確認
- 同ファイル周辺に `CryptoContext`, `SessionTicket`, `TicketHeader` の型名を発見
- この時点では、`ApplyLoginResponse` を入口として IDA 側の実装対応を追う方針を確定

## 2026-04-19 10:18

- `TicketManager::ApplyLoginResponse (0x1800F3A20)` を特定
- この関数は `response->max_length < 0x30` を弾いた後、`this+0x28` にある `SessionContext*` と `response->_items` を `sub_180245910` へ渡す
- この時点で、blob 処理の直下関数は `sub_180245910 (0x180245910)` と確定

## 2026-04-19 10:31

- `sub_180245910` 冒頭で response 先頭 16 byte を stack buffer へコピーしている
- 同関数は `SessionContext + 0x40` から 32 byte を読み、`sub_180118B20 (0x180118B20)` に渡して key schedule を生成する
- その後、`response + 0x10` から末尾までを 16 byte 単位で処理する loop に入る
- loop 完了後の平文バッファを `sub_1803A7120 (0x1803A7120)` へ渡す

## 2026-04-19 10:46

- `sub_180245910` の block loop は、各 block の復号後に直前 ciphertext block と XOR する
- 末尾では最後の 1 byte を `pad_len` として読み、`1 <= pad_len <= 16` を確認したうえで末尾 `pad_len` byte 全体を照合する
- このため、復号方式は AES-CBC で padding は PKCS#7 と判断できる

## 2026-04-19 11:02

- `sub_1803A7120` は平文先頭から `u32 version`, `u32 payload_size`, `u32 flags`, `u32 key_id` を読む
- `+0x10` から 16 byte を `SessionTicket.session_id` へコピーし、`+0x20` の `u64 account_id` と `+0x28` の `u64 expire_at_ms` を格納する
- `payload_size` は `plain_len - 0x30` と比較され、一致時のみ `SessionStore::SaveTicket` を呼ぶ
- ここまでで「受信 blob -> 復号 -> header parse -> 保存」の主要経路をすべて確定
