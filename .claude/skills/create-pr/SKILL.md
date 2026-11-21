---
name: create-pr
description: GitHub Pull Requestを作成する。変更内容を分析し、適切なタイトルと本文を生成してghコマンドでPRを作成する
disable-model-invocation: true
---

# Create PR Skill

- このSkillは GitHub Pull Request を作成するためのものです
- Claude CodeのgitStatusの情報は無視しなさい
- PRはタイトル･本文ともに英語で作成してください

## Procedure

### 1. ベースブランチの確認

- 必ずユーザーからベースブランチを確認する。ベースブランチは `main` や `development` とは限らない
- ベースブランチが確認できない場合、この先に進んではならない
- 指定されたベースブランチは、`git branch -a | grep <branch_name>` で実際に存在するか確認する

### 2. ヘッドブランチの確認

- `git status -b --short` で、ヘッドブランチがリモートにpushされているか確認する
- pushされていない場合、この先に進んではならない

### 3. コミット済みの変更とベースブランチとの差分を確認

- 差分を確認する
- コミットされていない変更は無視しなさい。必ずコミット済みのdiffを確認してください

```bash
git diff origin/<ベースブランチ>...HEAD
git log --oneline origin/<ベースブランチ>..HEAD
```

### 4. 変更内容を分析し、以下を作成

- PRタイトル
- 変更概要
- 変更理由
- テスト内容
- レビュー観点

### 5. PR本文の作成

```md
## Summary

(summary of changes)

## Changes

- xxx
- xxx

## Verification Steps

1. (Setup instructions or commands)
2. (Steps to reproduce or verify the behavior)
3. (Expected results)

## Testing

- Unit Test
  - [ ] xxx
- Manual Test
  - [ ] yyy

## Notes

(Any additional notes)
```

### 5. ghコマンドでPR作成

```bash
gh pr create \
  --title "<生成したタイトル>" \
  --base <ベースブランチ>
  --body "<PR本文>"
```

### 6. 作成されたPR URLをユーザーに通知

```bash
gh pr view --json url -q .url
```

## PRタイトルルール

- タイトルは50文字以内に収めてください
- タイトルには `[XXX]: ` を先頭につける必要があります。以下のいずれかを使用してください
  - `[Feature]: New feature`
  - `[Fix]: Bug fix`
  - `[Refactor]: Code refactoring`
  - `[Docs]: Documentation`
  - `[Chore]: Maintenance tasks`
