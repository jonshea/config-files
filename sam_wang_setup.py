#!/usr/bin/python

import json
import os

from subprocess import check_call, check_output, CalledProcessError

brew_packages_to_install = [
    "fzf",
    "git",
    "mosh",
    "python",
    "ripgrep",
    "tmux",
    "neovim",
    "zsh",
]

brew_cask_packages_to_install = [
    "divvy",
    # "dropbox",
    # "google-chrome",
    "istat-menus",
    # "slack",
    # "spotify",
    # "steam",
    # "vlc",
]

pip_packages_to_install = [
    "virtualenv",
    "ipython",
]

npm_packages_to_install = [
    "pure-prompt",
]

def brew_install(package, is_cask):
    cmd = "brew cask" if is_cask else "brew"

    installed_list = check_output('%s list' % cmd, shell=True).split('\n')
    if type(package) == tuple:
        flags = " " + package[1]
        package = package[0]
    else:
        flags = ""

    if package in installed_list:
        print("package '%s' already found" % package)
    else:
        print("installing package '%s'" % package)
        check_call('%s install %s%s' % (cmd, package, flags), shell=True)
        print("installed package '%s'" % package)


def pip_install(package):
    installed_list = json.loads(check_output(
        'pip3 list --format=json', shell=True))
    if type(package) == tuple:
        version = package[1]
        package = package[0]
    else:
        version = None

    elem = [x for x in installed_list if x['name'] == package]

    if not elem or (version and elem[0]['version'] != version):
        print("installing package '%s'" % package)
        if version:
            check_call("pip3 install '%s==%s'" % (
                package, version), shell=True)
        else:
            check_call("pip3 install %s" % package, shell=True)
        print("installed package '%s'" % package)
    else:
        print("package '%s' already found" % package)


def npm_install(package):
    print("installing package '%s'" % package)
    check_call("npm install --global %s" % package, shell=True)
    print("installed package '%s'" % package)


def setup_oh_my_zsh():
    if not os.path.exists(os.path.expanduser("~/.oh-my-zsh")):
        check_call('sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"', shell=True)
    else:
        print("oh my zsh already installed")


def install_brew():
    try:
        check_call("which brew", shell=True)
        print("already found brew")
    except CalledProcessError:
        print("installing brew")
        check_call('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"', shell=True),

    check_call('brew update', shell=True),


def main():
    install_brew()
    [brew_install(x, is_cask=True) for x in brew_cask_packages_to_install]
    [brew_install(x, is_cask=False) for x in brew_packages_to_install]
    [pip_install(x) for x in pip_packages_to_install]
    setup_oh_my_zsh()
    [npm_install(x) for x in npm_packages_to_install]


if __name__ == "__main__":
    main()