# wsl2-git-bash-prompt

WSL2 の bash プロンプトを Git Bash 風に表示する設定。

## 表示例

```
teni2@DellTower ~/apps/qiita (main *)
$
```

| 要素 | 色 |
|------|----|
| `ユーザー名@ホスト名` | 緑 |
| `パス` | 黄色 |
| `(ブランチ名)` | 青 |

## 設定内容

[.bashrc](.bashrc) に以下を追記する。

```bash
# git-prompt 読み込み
source /usr/lib/git-core/git-sh-prompt 2>/dev/null || source /etc/bash_completion.d/git-prompt 2>/dev/null

# Git 状態表示
GIT_PS1_SHOWDIRTYSTATE=1      # 変更あり: * / ステージ済み: +
GIT_PS1_SHOWUNTRACKEDFILES=1  # 未追跡ファイルあり: %

# Git Bash 風プロンプト（ユーザー名@ホスト名: 緑、パス: 黄色、ブランチ: 青）
export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]$(__git_ps1 " \[\e[34m\](%s)\[\e[0m\]")\n\$ '
```

## 設定の反映

```bash
source ~/.bashrc
```

## ブランチ状態の記号

| 記号 | 意味 |
|------|------|
| `*`  | 未コミットの変更あり |
| `+`  | ステージ済みの変更あり |
| `%`  | 未追跡ファイルあり |
