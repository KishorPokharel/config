mkcd() { mkdir -p "$@" && cd "$@"; }

mktouch() {
    mkdir -p "$(dirname "$1")"
    touch "$1"
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
    p="$(fd --type file '.*.pdf' ~/Downloads/ | fzf)"
    if [[ $p != "" ]]; then
        open $p
    fi
}

fv() {
    f="$(fd --type file --exclude node_modules --exclude venv . --search-path ~/workspace/ | fzf --preview 'bat --style=numbers --color=always {}')"
    if [[ $f != "" ]]; then
        vi $f
    fi
}

yt2mp3() {
    youtube-dl -x --audio-format mp3 $1 --no-check-certificate
}

alias lspath='echo $PATH | tr ":" "\n"'
alias q='exit'
alias vimrc="vi ~/.vimrc"
alias zshrc="vi ~/.zshrc"
alias cat=bat
