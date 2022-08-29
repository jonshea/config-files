if [ "$(uname)" = "Darwin" ]; then
    # I used to run `$(brew --prefix APP_NAME)`, but that is super slow, so I
    # am going to hard code this. Doubtless it will fail mysteriously on me
    # some day.
    export BREW_PREFIX="/usr/local"

    # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
    if type brew &>/dev/null; then
    #    fpath=($BREW_PREFIX/share/zsh-completions $BREW_PREFIX/share/zsh/site-functions $fpath)
        fpath=($BREW_PREFIX/share/zsh-completions $fpath)
        path+=('/Users/jonshea/bin')
    fi

    test_and_source $BREW_PREFIX/opt/asdf/libexec/asdf.sh

    function ij {
        FILENAME=$(echo "$1" | cut -d":" -f1)
        LINE_NUMBER=$(echo "$1" | cut -d":" -s -f2)
        if [ -z "${LINE_NUMBER}" ]; then
            /usr/local/bin/idea $FILENAME
        else
            /usr/local/bin/idea --line $LINE_NUMBER $FILENAME
        fi
    }

    path+=('/Applications/Visual Studio Code.app/Contents/Resources/app/bin')
    # PATH="$PATH:/Users/jonshea/Library/Application Support/Coursier/bin"

    ## Homebrew’s paths
    path=(/usr/local/bin /usr/local/sbin $path)

    alias ls='ls -GFah --color=auto'
    alias code='code --goto'
fi;
