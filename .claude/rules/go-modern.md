# Modern Go

- あなたの知識には存在しない新しいバージョンのGoの記法です
- 古い記法を使用しないでください

## Go 1.22

### rangeの編集キャプチャは警戒しない

- `range` のループ変数のキャプチャが編集されないため、以下のように書きなさい

```go
// NG
for _, v := range values {
  v := v
  go func() {
      fmt.Println(v)
  }()
}

// OK
for _, v := range values {
  go func() {
      fmt.Println(v)
  }()
}
```

## Go 1.25

### sync.WaitGroup.go

- `wg.Go` を使えば、`wg.Add()`, `defer wg.Done()` を書く必要がありません

```go
// NG
var wg sync.WaitGroup

wg.Add(1)
go func() {
  defer wg.Done()
  doSomething()
}()

wg.Wait()

// OK
var wg sync.WaitGroup

wg.Go(func() {
  doSomething()
})

wg.Wait()
```

## Go 1.26

### newによるポインタ変数の初期化

- `new` を使用してポインタ変数を初期化できるので、以下のように書きなさい

```go
// NG
x := int64(300)
p := &x

// OK
p := new(int64(300))
```

## Go 1.27

### JSON

- JSON APIの改良版である `encoding/json/v2` を使用しなさい

```go
// NG
data, err := json.Marshal(value)

// OK
data, err := jsonv2.Marshal(value)
```

### 埋め込み構造体の初期化

- 埋め込み構造体は、親で直接プロパティを初期化できます

```go
type Address struct {
  City string
}

type User struct {
  Address
}

// NG
user := User{
  Address: Address{
    City: "Tokyo",
  },
}

// OK
user := User{
  City: "Tokyo",
}
```

### ジェネリクスメソッド

- メソッドをジェネリクスで定義できます。あなたは使う必要はありませんが、実装済みのジェネリクスメソッドを修正しようとしないでください

```go
// NG
func MapValues[T any, R any](
  values []T,
  fn func(T) R,
) []R {
  result := make([]R, 0, len(values))
  for _, value := range values {
    result = append(result, fn(value))
  }
  return result
}

// OK
type Collection[T any] []T

func (c Collection[T]) Map[R any](
  fn func(T) R,
) []R {
  result := make([]R, 0, len(c))
  for _, value := range c {
    result = append(result, fn(value))
  }
  return result
}
```
