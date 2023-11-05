export PROMPT='%B%{$fg[cyan]%}%c%{$reset_color%}%b $(git_prompt_info)$ '
export EXA_COLORS='di=36;;01:*.mp3=37;;01:*.pdf=33'
export FZF_DEFAULT_OPTS="--layout=reverse"

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
        cd ${"$(fd --type d --exclude node_modules --exclude __pycache__ --exclude venv . --search-path ~/workspace/ --search-path ~/Downloads | tee ~/.all_dirs | fzf)":-"."}
    else
        cd ${"$(cat ~/.all_dirs | fzf)":-"."}
    fi
}

notes() {
    n="$(fd --type file . ~/notes | fzf --bind 'ctrl-y:execute(cat {} | pbcopy)+abort' --preview 'bat --style=numbers --color=always {}')"
    if [[ $n != "" ]]; then
        vi $n
    fi
}

movies() {
    m="$(fd --type file '.*.(mp4|mkv)' ~/Downloads/movies/ | fzf)"
    if [[ $m != "" ]]; then
        open $m
    fi
}

pdfs() {
    p="$(fd --type file '.*.pdf' ~/Downloads/ | fzf -m)"
    if [[ $p != "" ]]; then
        while IFS= read -r pdf; do
            open "$pdf"
        done <<< "$p"
    fi
}

fv() {
    if [[ "$1" = "-u" ]]; then
        f="$(fd --type file --exclude node_modules --exclude __pycache__ --exclude venv . --search-path ~/workspace/ | tee ~/.all_files | fzf)"
        if [[ $f != "" ]]; then
            vi $f
        fi
    else
        f="$(cat ~/.all_files | fzf --bind 'ctrl-k:toggle-preview' --bind 'ctrl-y:execute(cat {} | pbcopy)' --preview 'bat --style=numbers --color=always {}')"
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
    m="$(fd --type file '.*.mp3' ~/songs/ | fzf)"
    if [[ -n "$m" ]]; then
        cmus-remote -f "$m"
        songs
    fi
}

nepalidate() {
  curl -s https://www.hamropatro.com/widgets/calender-small.php | \
      pup 'select.year option[selected], select.month option[selected], ul.dates li.active span.nep text{}' | \
      tr '\n' ' '
  echo ""
}

tsp() {
    p=$(tmux list-panes -a -F "#S:#I.#P #W" | fzf | cut -f 1 -d ' ')
    if [[ -n $p ]]; then
        tmux -u switch-client -t "$p" || tmux -u attach -t "$p"
    fi
}

gistm() {
    local code="$(gh gist list | \
        fzf \
        --preview-window=hidden \
        --bind="ctrl-\:toggle-preview" \
        --bind="ctrl-y:execute-silent(gh gist view {1} | pbcopy)" \
        --preview 'gh gist view {1}' \
        --header-first \
        --header="C-\ to toggle preview :: ENTER to edit gist :: C-y to copy gist to clipboard" | \
    awk '{print $1}')"
    if [[ -n "$code" ]]; then
        gh gist edit "$code"
    fi
}

# gistv() {
#     code=$(gh gist list | fzf --layout=reverse | awk '{print $1}')
#     if [[ -n "$code" ]]; then
#         gh gist view "$code"
#     fi
# }

# giste() {
#     code=$(gh gist list | fzf --layout=reverse | awk '{print $1}')
#     if [[ -n "$code" ]]; then
#         gh gist edit "$code"
#     fi
# }

networkscan() {
    port=$1
    if [[ -n "$port" ]]; then
        port=":$port"
    fi
    hostport=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk -v port="$port" '{print "http://" $2 port}')
    echo $hostport
    echo $hostport | qrencode -t ANSI
}

killapp() {
    FZF_DEFAULT_COMMAND="ps -ax" fzf --bind "change:reload:ps -ax || true" --bind "enter:execute(kill -9 {1})+abort"
}

doc() {
    go doc $@ | bat -l go -n --style plain
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
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
