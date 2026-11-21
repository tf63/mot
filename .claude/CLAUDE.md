# Project Guidelines

## Prohibited Actions

- **推測で実装・説明することは固く禁止されています**
- **推測で実装・説明することは固く禁止されています**
- **推測で実装・説明することは固く禁止されています**
- **失敗を隠蔽することは固く禁止されています**
- **失敗を隠蔽することは固く禁止されています**
- **失敗を隠蔽することは固く禁止されています**

## Constraints

- **ユーザーへの返答は必ず日本語にしなさい**
- **ユーザーへの返答は必ず日本語にしなさい**
- **ユーザーへの返答は必ず日本語にしなさい**
- **Skillを呼ぶべきケースでは、どんな内容であっても必ずSkillを実行してください**
- **Skillを呼ぶべきケースでは、どんな内容であっても必ずSkillを実行してください**
- **Skillを呼ぶべきケースでは、どんな内容であっても必ずSkillを実行してください**

## Tools

### ファイルの検索

- 最優先: `rg --heading -l`, `find`, `ls`
- 禁止: `grep`

### シンボル検索

- 最優先: `rg --heading -n`, `rg --heading -l`
- 禁止: `grep`

- `rg` は `--heading` をつけて実行しなさい

### ファイルの読み込み

- 最優先: `rg --heading -n`, `head`, `tail`
- 最終手段: `Read` ツール
- 禁止: `grep` コマンド

- シンボル検索で調査対象のファイルを特定したあと、ファイルを読むようにしなさい
- できる限りファイル全体を読まないようにしなさい

### ファイルの新規作成

- 最優先: `Write` ツール
- 禁止: Bashコマンド、Shellのリダイレクト

### ファイルの編集･修正

- 最優先: `Edit` ツール
- 禁止: `Write` ツール, Bashコマンド

### ファイルの削除

- 最優先: `trash` コマンド
- 禁止: `rm` コマンド

### ユーザーへの質問

- 最優先: `AskUserQuetion`

- 質問の選択肢は2つ以上用意してください
- 質問の選択肢が1つの場合、Yes/No の質問に言い換えてください

## Allowed Commands

- `Bash` コマンドは以下のものだけ許可されています

```bash
# Read-only Operations
ls
tree
find
grep
rg
xargs grep
xargs rg
head
tail
pwd
wc -l

# File & Directory Modifications
touch
mkdir
mv
cp -n
trash

# Git Operations
git add
git commit
git status
git diff
git show
git log
git branch -a
git push
gh pr view
gh pr diff
gh pr list
gh pr create
gh api -X POST repos/tf63/mot/*

# Go Commands
golangci-lint
go doc
go test
go build
```

## Denied Commands

- 禁止されているコマンドのうち、あなたがよく使おうとするコマンドです。これらのコマンドの実行は禁止されています

```bash
cd
cat
bash
echo
```
