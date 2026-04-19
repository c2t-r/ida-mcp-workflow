# AccountSession_EqualsHandle

`AccountSession` に保持している handle と入力 handle が同じ値かを確認する関数

namespace: `AccountSession`
mangled: ``
demangled: `AccountSession_EqualsHandle`
address: `0x1802B6E40`

## caller

- `GmsClient_getAccount`
- `AccountSession_IsCurrentHandle`

## detail

`session_handle` 側に保持している `System.IntPtr` と、`input_handle` 側の `IntPtr` 値が一致するかを確認する

- 引数
  - `session_handle`: 比較対象の `AccountSession*`
  - `input_handle`: 比較元の `System.IntPtr`
  - `init_arg`: `System.IntPtr` の型情報初期化時にだけ使う補助引数
- 戻り値
  - `true`: `session_handle->handle` が `System.IntPtr` として有効で、保持している pointer 値が `input_handle` と一致する
  - `false`: 型比較に失敗するか、保持している pointer 値が `input_handle` と一致しない
- `session_handle + 2` にある `System.IntPtr` を比較対象として使う
- 初回だけ `InitializeSystemIntPtrType(...)` を呼び、`System.IntPtr` の型情報を初期化する
- `GetSystemIntPtrTypeObject()` で取得した型オブジェクトを使って `IntPtrEquals(...)` を呼ぶ
- 型一致確認後に pointer 値を比較する
- `init_arg` は通常経路では使わず、型情報未初期化時にだけ下流へ渡す

## code

```cs
bool AccountSession_EqualsHandle(session_handle, input_handle, init_arg)
{
  session_value = session_handle.handle

  if (!SystemIntPtrTypeIsInitialized) {
    InitializeSystemIntPtrType(input_handle, init_arg)
    SystemIntPtrTypeIsInitialized = true
  }

  intptr_type_object = GetSystemIntPtrTypeObject()

  return IntPtrEquals(session_value, intptr_type_object)
      && session_value.value == input_handle.value
}
```

## link

- [InitializeSystemIntPtrType](./InitializeSystemIntPtrType.md)
- [GetSystemIntPtrTypeObject](./GetSystemIntPtrTypeObject.md)
