# Coding Guide for Go

## Coding Style

- エラーは必ず返すようにしてください。エラーを無視することは禁止されています
- 変数名は端的で意味のある名前を使用してください

## Type

- 可能な限り型推論を使用してください。明示的に型を書くのは最小限にしなさい
- `interface{}` ではなく `any` を使用してください

## Typed nil

- typed nilを使わないでください
- interfaceに格納された nil ポインタ `((*T)(nil))` は nil ではないため、nil 判定のバグを招く
- interfaceを返す場合は明示的に nil を返すこと

```go
 // NG
var err *MyError = nil
return err

// OK
return nil // OK
```

## strings

```go
// 存在確認
strings.Contains(s, target)

// 前方一致
strings.HasPrefix(s, prefix)

// 後方一致
strings.HasSuffix(s, suffix)

// 文字列の分割
parts := strings.Split(s, ",")

// 文字列の結合
joined := strings.Join(parts, ",")

// 文字列の繰り返し
repeated := strings.Repeat(s, 3)
```

## slices

- スライスの操作には `slices` パッケージを使用してください

```go
// 比較
slices.Equal(a, b)

// 存在確認
slices.Contains(users, "alice")

// 検索
idx := slices.Index(items, target)

```

## maps

- マップの操作には `maps` パッケージを使用してください

```go

// コピー
cloned := maps.Clone(src)

// 全要素のコピー
maps.Copy(dst, src)

// 比較
maps.Equal(a, b)

// キー一覧の取得
keys := slices.Collect(maps.Keys(m))

// 値一覧の取得
values := slices.Collect(maps.Values(m))
```

## error

- errorをラップする場合は `%w` でラップしなさい
- 複数のerrorは `erros.Join` で結合しなさい
- エラーの比較や型判定には、エラーのラップを考慮できる errors.Is と errors.As を使用しなさい。

```go
// NG
return fmt.Errorf("failed to execute: %v", err)

// OK
return fmt.Errorf("failed to execute: %w", err)

// NG
return fmt.Errorf("%v; %v", err1, err2)

// OK
return errors.Join(err1, err2)

// NG
if err == ErrNotFound {
    // ...
}

// OK
if errors.Is(err, ErrNotFound) {
    // ...
}

// NG
if e, ok := err.(*MyError); ok {
    fmt.Println(e.Code)
}

// OK
var e *MyError
if errors.As(err, &e) {
    fmt.Println(e.Code)
}
```

## goroutine

- 複数の goroutine の実行・待機には `errgroup` を使用してください
- `sync.WaitGroup` はエラー伝搬が不要な場合のみ使用してください
- `context.Context` と組み合わせて利用してください

```go
var wg sync.WaitGroup

wg.Go(func() {
    taskA(ctx)
})

wg.Go(func() {
    taskB(ctx)
})

wg.Wait()
```

```go
g, ctx := errgroup.WithContext(ctx)

g.Go(func() error {
    return taskA(ctx)
})

g.Go(func() error {
    return taskB(ctx)
})

if err := g.Wait(); err != nil {
    return err
}
```

## slog

- logよりもslogを使用しなさい

```go
// NG
log.Printf("user_id=%s action=%s", userID, action)

// OK
slog.Info(
    "user action",
    "user_id", userID,
    "action", action,
)
```

## utility

```go
// 最小･最大
min(a, b)
max(a, b)

// sliceやmapを初期化
clear(values)
```
