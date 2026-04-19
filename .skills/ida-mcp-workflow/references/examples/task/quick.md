# quick.md

## 結論

ログイン ticket の復号本体は `sub_180245910 (0x180245910)`
この関数は response 先頭 16 byte を IV、`SessionContext + 0x40` の 32 byte を AES key として使い、残りの payload を AES-256-CBC + PKCS#7 で復号する
復号後の平文は `sub_1803A7120 (0x1803A7120)` で `SessionTicket` 構造体へ変換され、最後に `SessionStore::SaveTicket` へ渡される

## 根拠

- `TicketManager::ApplyLoginResponse (0x1800F3A20)` が `this+0x28` の `SessionContext*` と response buffer を `sub_180245910` へ渡す
- `sub_180245910` 冒頭で response 先頭 16 byte を退避し、`SessionContext + 0x40` から 32 byte を読む
- block loop 後に padding byte 全体を検査してから `sub_1803A7120` を呼ぶ
- `sub_1803A7120` は version, payload_size, flags, key_id, session_id, account_id, expire_at_ms を構造体へ詰めて `SessionStore::SaveTicket` を呼ぶ

## 平文レイアウト

- `+0x00`: `u32 version`
- `+0x04`: `u32 payload_size`
- `+0x08`: `u32 flags`
- `+0x0C`: `u32 key_id`
- `+0x10`: `u8 session_id[16]`
- `+0x20`: `u64 account_id`
- `+0x28`: `u64 expire_at_ms`
- `+0x30`: payload
