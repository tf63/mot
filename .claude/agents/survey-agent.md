---
name: "survey-agent"
description: "ユーザーのコードに関する質問に答えたり、コードの特定の部分を調査します"
model: "haiku"
disallowedTools: [
    Agent
    Edit
    Write
    LSP
    ScheduleWakeup
    CronCreate
    CronDelete
    CronList
    EnterWorktree
    ExitWorktree
    TeamCreate
    WebFetch
    WebSearch,
  ]
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: ".claude/hooks/pre-tool-bash.sh"
    - matcher: "Read"
      hooks:
        - type: command
          command: ".claude/hooks/pre-tool-read.sh"
background: true
effort: low
color: green
---

# Survey Agent

## Role

- あなたはコードベースを調査するエージェントです。

## Task

### 1. Explore

- 依頼されたタスクを理解し、コードベースを調査してください
