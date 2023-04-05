export PROMPT='%B%{$fg[cyan]%}%c%{$reset_color%}%b $(git_prompt_info)$ '
export EXA_COLORS='di=36;;01:*.mp3=37;;01:*.pdf=33'

# edit long commands in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

mkcd() { mkdir -p "$@" && cd "$@"; }

mktouch() {
    if [ $# -lt 1 ]; then
        echo "Missing argument";
        return 1;
    fi
    for f in "$@"; do
        mkdir -p -- "$(dirname -- "$f")"
        touch -- "$f"
    done
}

jd() {
    if [[ "$1" = "-u" ]]; then
        cd ${"$(fd --type d --exclude node_modules --exclude __pycache__ --exclude venv . --search-path ~/workspace/ --search-path ~/Downloads | tee ~/.all_dirs | fzf --layout=reverse)":-"."}
    else
        cd ${"$(cat ~/.all_dirs | fzf --layout=reverse)":-"."}
    fi
}

notes() {
    n="$(fd --type file . ~/notes | fzf --layout=reverse --preview 'bat --style=numbers --color=always {}')"
    if [[ $n != "" ]]; then
        vi $n
    fi
}

movies() {
    m="$(fd --type file '.*.(mp4|mkv)' ~/Downloads/movies/ | fzf --layout=reverse)"
    if [[ $m != "" ]]; then
        open $m
    fi
}

pdfs() {
    p="$(fd --type file '.*.pdf' ~/Downloads/ | fzf -m --layout=reverse)"
    if [[ $p != "" ]]; then
        while IFS= read -r pdf; do
            open "$pdf"
        done <<< "$p"
    fi
}

fv() {
    if [[ "$1" = "-u" ]]; then
        f="$(fd --type file --exclude node_modules --exclude __pycache__ --exclude venv . --search-path ~/workspace/ | tee ~/.all_files | fzf --layout=reverse )"
        if [[ $f != "" ]]; then
            vi $f
        fi
    else
        f="$(cat ~/.all_files | fzf --layout=reverse )"
        if [[ $f != "" ]]; then
            vi $f
        fi
    fi
}

copy() {
    cat $1 | pbcopy
}

yt2mp3() {
    yt-dlp -x --audio-format mp3 $1
}

ytd() {
    if [[ "$1" = "" ]]; then
        return
    fi
    url="$(yt-dlp "ytsearch10: $1" -J | jq -r '.entries[] | "\(.webpage_url)\t\(.title)\t\(.upload_date)"' | fzf | cut -f 1)"
    if [[ -n "$url" ]]; then
        yt2mp3 "$url"
    fi
}

ytplay() {
    if [[ "$1" = "" ]]; then
        return
    fi
    url="$(yt-dlp "ytsearch10: $1" -J | jq -r '.entries[] | "\(.webpage_url)\t\(.title)\t\(.upload_date)"' | fzf | cut -f 1)"
    if [[ -n "$url" ]]; then
        mpv "$url"
    fi
}

ytdlist() {
    yt-dlp -x --audio-format mp3 --audio-quality 0 -a "$1"
}

songs() {
    m="$(fd --type file '.*.mp3' ~/songs/ | fzf --layout=reverse )"
    if [[ -n "$m" ]]; then
        cmus-remote -f "$m"
        songs
    fi
}

nepalidate() {
  curl -s https://www.hamropatro.com/widgets/calender-small.php | pup 'select.month option[selected], ul.dates li.active span.nep text{}' | tr '\n' ' '
  echo ""
}

tss() {
    SESSION=$(tmux list-sessions -F \#S | fzf --layout=reverse)
    if [[ -n $SESSION ]]; then
        tmux switch-client -t $SESSION || tmux attach -t $SESSION
    fi
}

gistv() {
    code=$(gh gist list | fzf --layout=reverse | awk '{print $1}')
    if [[ -n "$code" ]]; then
        gh gist view "$code"
    fi
}

giste() {
    code=$(gh gist list | fzf --layout=reverse | awk '{print $1}')
    if [[ -n "$code" ]]; then
        gh gist edit "$code"
    fi
}

alias ts="tmux new -s "
alias tac="tail -r"
alias lspath='echo $PATH | tr ":" "\n"'
alias q='exit'
alias work="cd ~/workspace"
alias vimrc="vi ~/.vimrc"
alias zshrc="vi ~/.zshrc"
alias sz="source ~/.zshrc"
alias cat="bat -p"
alias ls="exa"
alias tree="exa --tree"
alias serve="python3 -m http.server"
alias cr="cmus-remote"
alias trim="awk '{\$1=\$1;print}'"
