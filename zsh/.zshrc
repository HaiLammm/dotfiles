# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
[ -x /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Input method — ibus trên Mint; máy Arch (X1) dùng fcitx5, khai báo ở /etc/environment
if command -v ibus-daemon >/dev/null; then
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
fi
export OLLAMA_KEEP_ALIVE=-1

# ==============================================================
# Oh My Zsh
# ZSH_THEME rỗng: prompt được tự định nghĩa bên dưới
# ==============================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)

# Nạp module complist TRƯỚC compinit (oh-my-zsh gọi compinit bên trong)
zmodload zsh/complist
autoload -U colors && colors

source $ZSH/oh-my-zsh.sh

# ==============================================================
# Completion — phần chính của video (đặt SAU oh-my-zsh để ghi đè)
# ==============================================================
zstyle ':completion:*' menu select                              # Tab mở menu chọn
zstyle ':completion:*' special-dirs true                        # hiện . và .. trong menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33  # tô màu menu
zstyle ':completion:*' squeeze-slashes false                    # cho phép expand /*/

# Di chuyển trong menu bằng hjkl (chế độ menuselect)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ==============================================================
# Options
# ==============================================================
setopt append_history inc_append_history share_history  # history dùng chung mọi session
setopt auto_menu menu_complete                          # tự chọn match đầu tiên
setopt autocd                                           # gõ tên thư mục để cd
setopt auto_param_slash                                 # thêm / sau khi complete thư mục
setopt no_case_glob no_case_match                       # completion không phân biệt hoa/thường
setopt globdots                                         # bao gồm file ẩn
setopt extended_glob                                    # hỗ trợ ~ # ^
setopt interactive_comments                             # cho phép comment trong shell
unsetopt prompt_sp                                      # không tự xoá dòng trống
stty stop undef                                         # vô hiệu hoá Ctrl-S
stty -ixon

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# ==============================================================
# fzf
# ==============================================================
source <(fzf --zsh)

# ==============================================================
# Keybindings
# ==============================================================
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^H" backward-kill-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget

# ==============================================================
# Aliases
# ==============================================================
alias zshrc="nvim ~/.zshrc"
alias note="nvim ~/Projects/note/"
# alias wezterm='flatpak run org.wezfurlong.wezterm'  # tắt: đã cài wezterm-nightly native (/usr/bin/wezterm) sửa lỗi IME tiếng Việt

# ==============================================================
# Conda
# ==============================================================
__conda_setup="$('/home/luonghailam/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/luonghailam/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/luonghailam/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/luonghailam/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# ==============================================================
# Prompt — Nord theme (đặt sau conda để không bị chèn "(base) ")
# ==============================================================
NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}%D{%_I:%M%P} %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ "

# Dòng chào khi mở terminal
echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m"

# ==============================================================
# Tools
# ==============================================================
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="/home/luonghailam/.opencode/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Khoá API — giữ trong file riêng, không commit
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Claude Code — ghim UUID vào dòng lệnh để tmux-resurrect khôi phục đúng phiên.
# Không có UUID trong `ps`, resurrect chỉ lưu được `claude` trần và restore ra
# hội thoại trắng. Xem luật `@resurrect-processes` trong ~/.tmux.conf.
claude() {
  case "$1" in
    -r|--resume|-c|--continue) command claude "$@" ;;
    *) command claude --session-id "$(uuidgen)" "$@" ;;
  esac
}

# ssh-agent của systemd user (Arch: ssh-agent.socket). environment.d không tới được
# terminal/tmux nên phải export ở đây; Mint không có socket này nên bỏ qua.
if [ -z "$SSH_AUTH_SOCK" ] && [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# ==============================================================
# Plugins — syntax-highlighting phải nằm CUỐI CÙNG
# ==============================================================
# linuxbrew trên Mint, /usr/share/zsh/plugins trên Arch
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  for d in /home/linuxbrew/.linuxbrew/share /usr/share/zsh/plugins; do
    [ -f $d/$p/$p.zsh ] && { source $d/$p/$p.zsh; break; }
  done
done
