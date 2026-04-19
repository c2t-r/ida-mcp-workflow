# header.md

## TicketHeader 確定レイアウト

`sub_1803A7120` で展開される平文 header の確定内容を整理する

## フィールド一覧

| offset | size | field | evidence |
| --- | --- | --- | --- |
| `0x00` | 4 | `version` | `2` と `3` 以外で即失敗 return |
| `0x04` | 4 | `payload_size` | `plain_len - 0x30` と比較される |
| `0x08` | 4 | `flags` | `SessionTicket.flags` へそのまま格納 |
| `0x0C` | 4 | `key_id` | `SessionTicket.key_id` へそのまま格納 |
| `0x10` | 16 | `session_id` | 16 byte memcpy で `SessionTicket.session_id` へコピー |
| `0x20` | 8 | `account_id` | 8 byte load 後に `SessionTicket.account_id` へ格納 |
| `0x28` | 8 | `expire_at_ms` | 8 byte load 後に `SessionTicket.expire_at_ms` へ格納 |
| `0x30` | `payload_size` | `payload` | 別領域へ copy 後に ticket object へ保持 |

## 根拠

- `sub_1803A7120` 冒頭で `+0x00`, `+0x04`, `+0x08`, `+0x0C` を連続で読む
- `+0x10` から 16 byte memcpy があり、コピー先が `SessionTicket.session_id`
- `+0x20` と `+0x28` は 8 byte load 後に ticket object 内へ store
- `+0x30` 以降は `payload_size` を長さとして別バッファへコピーする
