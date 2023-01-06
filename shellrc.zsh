export PROMPT='%B%{$fg[cyan]%}%c%{$reset_color%}%b $(git_prompt_info)$ '
export EXA_COLORS='di=36;;01'

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

sd() {
    cd ${"$(fd --type d --exclude node_modules | fzf)":-"."}
}

movies() {
    m="$(fd --type file '.*.(mp4|mkv)' ~/Downloads/movies/ | fzf)"
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
    f="$(fd --type file --exclude node_modules --exclude venv . --search-path ~/workspace/ | fzf --preview 'bat --style=numbers --color=always {}')"
    if [[ $f != "" ]]; then
        vi $f
    fi
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

songs() {
    m="$(fd --type file '.*.mp3' ~/songs/ | fzf --layout=reverse )"
    if [[ -n "$m" ]]; then
        cmus-remote -f "$m"
        songs
    fi
}

alias lspath='echo $PATH | tr ":" "\n"'
alias q='exit'
alias vimrc="vi ~/.vimrc"
alias zshrc="vi ~/.zshrc"
alias cat=bat
alias ls="exa"
alias tree="exa --tree"
alias serve="python3 -m http.server"
