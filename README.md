これ実装できますか？

Wsl2でgit bashみたいな感じで表示する

git bashみたいな感じで

teni2@DellTower MINGW64 /c/apps/qiita (main)

()の中に現在のブランチを作成する。

はい、できます。
WSL2 の bash / zsh のプロンプト を変えれば、かなり Git Bash っぽくできます。

たとえば bash なら、.bashrc にこんな感じを入れます。

# git-prompt 読み込み
source /usr/lib/git-core/git-sh-prompt 2>/dev/null || source /etc/bash_completion.d/git-prompt 2>/dev/null

# Git Bash風プロンプト
export PS1='\u@\h \[\e[32m\]WSL2\[\e[0m\] \w$(__git_ps1 " (%s)")\n\$ '

これでこんな表示になります。

teni2@DellTower WSL2 ~/apps/qiita (main)
$

ポイントはこれです。

\u → ユーザー名

\h → ホスト名

\w → 現在ディレクトリ

__git_ps1 " (%s)" → 現在ブランチ名を (main) のように表示

Git Bash の MINGW64 を完全再現したいなら、WSL2 の部分を MINGW64 に変えれば見た目は近づきます。

export PS1='\u@\h \[\e[32m\]MINGW64\[\e[0m\] \w$(__git_ps1 " (%s)")\n\$ '

ただし、WSL2 は Linux なので、パスは普通は /c/apps/qiita ではなく

/mnt/c/apps/qiita

になります。
見た目だけ /c/... に寄せることもできますが、まずは上の設定が簡単です。

必要なら次に
「WSL2で /mnt/c/... を /c/... っぽく見せる設定」 までまとめます。

これどこのファイルを修正した感じでしょうか？

.bashrc です。

場所はこれ👇

~/.bashrc

編集手順：

vim ~/.bashrc
# または
nano ~/.bashrc

末尾にさっきの設定を追記して保存。

反映はこれ：

source ~/.bashrc

補足：

bash使ってる → .bashrc

zsh使ってる → .zshrc

WSL2のデフォルトは基本 bash → .bashrc です。


このプロンプト問題ないでしょうか？

プロンプトが貼られていないので判断できません。

そのまま貼ってもらえれば、

意図通り動くか

曖昧さ・抜け漏れ

改善ポイント（具体修正案）

まで見ます。

# git-prompt 読み込み
source /usr/lib/git-core/git-sh-prompt 2>/dev/null || source /etc/bash_completion.d/git-prompt 2>/dev/null

# Git Bash風プロンプト
export PS1='\u@\h \[\e[32m\]WSL2\[\e[0m\] \w$(__git_ps1 " (%s)")\n\$ '

問題ありません。普通に動く構成です 👍

ただ少しだけ改善ポイントあります。

👍 良い点

__git_ps1 でブランチ表示できている

fallback (|| source ...) も書いていて安全

色リセットも入っている

⚠️ 改善ポイント
① 改行は好み（Git Bash風ならOK）
\n\$ 

→ Git BashっぽいのでOKですが、
1行にしたいなら削除

② 色付けをもう少し寄せると「それっぽい」

今：

\u@\h [WSL2] \w (branch)

Git Bash風に寄せるなら：

export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]$(__git_ps1 " (%s)")\n\$ '

user@host → 緑

path → 黄色

branch → デフォルト（gitが色つける場合あり）

③ __git_ps1 の強化（おすすめ）

ブランチ状態も出すなら：

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

これで：

* 変更あり

+ ステージあり

が出ます

最終おすすめ
source /usr/lib/git-core/git-sh-prompt 2>/dev/null || source /etc/bash_completion.d/git-prompt 2>/dev/null

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]$(__git_ps1 " (%s)")\n\$ '
まとめ

今のままでもOK（動く）

見た目を寄せるなら色調整＋Git状態表示追加がおすすめ

もし「完全にGit Bashと同じ見た目」にしたいならそこも再現できます。

ブランチ名も青色で表示できますか？

できます 👍

__git_ps1 のフォーマット文字列に色を仕込めばOKです。

修正例（ブランチを青色）
export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\[\e[34m\]$(__git_ps1 " (%s)")\[\e[0m\]\n\$ '
ポイント

\[\e[34m\] → 青色開始

\[\e[0m\] → リセット

__git_ps1 の前後を囲むのがコツ

補足（より安全な書き方）

__git_ps1 の中に直接入れる方法もあります👇

export PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]$(__git_ps1 " \[\e[34m\](%s)\[\e[0m\]")\n\$ '

👉 こっちの方が「ブランチ部分だけ確実に青」になります

結論

可能

__git_ps1 の中 or 外で色付けできる

中に書く方が安全でおすすめ