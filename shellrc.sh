mkcd() { mkdir -p "$@" && cd "$@"; }
mktouch() {
    mkdir -p "$(dirname "$1")"
    touch "$1"
}
yt2mp3() {
    youtube-dl -x --audio-format mp3 $1 --no-check-certificate
}

alias lspath='echo $PATH | tr ":" "\n"'
alias q='exit'
alias vimrc="vi ~/.vimrc"
alias zshrc="vi ~/.zshrc"
alias sd="cd \$(fd --type d --exclude node_modules | fzf)"
alias cat=bat
