if status is-interactive
    if test (uname) = "Darwin"
        fish_add_path /usr/local/bin
    end

    if test -d $HOME/.local/bin
        fish_add_path $HOME/.local/bin
    end

    if test -d $HOME/.cargo/bin
        fish_add_path $HOME/.cargo/bin
    end

    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end

    if test -d /opt/homebrew/sbin
        fish_add_path /opt/homebrew/sbin
    end

    if test -d $HOME/.pyenv
        set -Ux PYENV_ROOT $HOME/.pyenv

        # NOTE: disable pyenv prompt
        # see https://github.com/pyenv/pyenv-virtualenv/issues/385
        set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
        pyenv init - | source
        pyenv virtualenv-init - | source
    end

    set go_path (go env GOPATH)
    set -Ux GOPATH $go_path
    if test -d "$GOPATH"/bin
        fish_add_path -g $GOPATH/bin
    end
end

# delete welcome message of fish shell
set fish_greeting ""
set -Ux fish_prompt_pwd_dir_length 0

set -Ux LC_ALL "en_US.UTF-8"
set -Ux CLICOLOR 1
set -Ux GREP_COLOR "1;31"

# setup homebrew mirror
set -Ux HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"

# customize colors for commands output
set -Ux LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -Ux LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -Ux LESS_TERMCAP_me \e'[0m'           # end mode
set -Ux LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -Ux LESS_TERMCAP_so \e'[38;5;016m\E[48;5;220m'    # begin standout-mode - info box
set -Ux LESS_TERMCAP_ue \e'[0m'           # end underline
set -Ux LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# setup with zoxide
zoxide init fish | source
