if status is-interactive
    # commands to run in interactive sessions can go here
end

if status is-login
    # commands to run in login sessions can go here
end

# file listing
abbr -a l eza -1 -l -a --no-user --no-permissions --icons=always
abbr -a lg eza -G -l -a --total-size --no-user --no-permissions --icons=always
abbr -a lt eza -T -l -a --total-size --no-user --no-permissions --icons=always

# brew
abbr -a b brew
abbr -a bi 'brew install'
abbr -a bu 'brew uninstall'
abbr -a bl 'brew list'
abbr -a bd 'brew doctor'

# system
abbr -a bt btop

# chdir
abbr -a c cd
abbr -a cb cd .. # cd back
abbr -a cr cd - # cd return

# config editing
abbr -a cf zed-preview ~/dotfiles/fish
abbr -a cn zed-preview ~/dotfiles/nushell
abbr -a ca zed-preview ~/dotfiles/alacritty
abbr -a cs zed-preview ~/dotfiles/starship
abbr -a ch zed-preview ~/dotfiles/helix
abbr -a cz zed-preview ~/dotfiles/zellij
abbr -a cg zed-preview ~/dotfiles/gdb/.gdbinit

# localizing config files
abbr -a cpg cp ~/dotfiles/.gitignore .gitignore
abbr -a cpp cp ~/dotfiles/pyright/pyrightconfig.json pyrightconfig.json

abbr -a cl clang
abbr -a g git
abbr -a gc gh repo clone

function gi
    git init
    gh repo create
end

abbr -a gv gh repo view -w
abbr -a gdb /usr/local/bin/gdb -x ~/dotfiles/gdb/.gdbinit
abbr -a h hx

abbr -a hf hyperfine
abbr -a hff hyperfine --warmup 3 --runs 10 --export-markdown benchmark.md -u second

abbr -a ht http
abbr -a j zellij
abbr -a jl jless
abbr -a lg lazygit
abbr -a m miniserve
abbr -a mr make run

abbr -a n bun
abbr -a na bun add
abbr -a nc bun create
abbr -a ncs bun create svelte@latest
abbr -a ni bun install
abbr -a nv bun remove
abbr -a nr bun --bun run dev
abbr -a nb bun --bun run build

abbr -a nf neofetch

abbr -a o cargo
abbr -a oa cargo add
abbr -a on cargo new
abbr -a onn cargo new --vcs none
abbr -a onl cargo new --lib
abbr -a onnl cargo new --vcs none --lib
abbr -a ob cargo build
abbr -a obr cargo build --release
abbr -a or cargo run
abbr -a orr cargo run --release
abbr -a oc cargo check
abbr -a odc cargo doc
abbr -a ot cargo test
abbr -a otn cargo test -- --nocapture
abbr -a otr cargo test --release
abbr -a otrn cargo test --release -- --nocapture
abbr -a oy cargo clippy

abbr -a op open
abbr -a oh open .

# Directory creation and navigation function
function md
    mkdir $argv[1]
    cd $argv[1]
end

# Python environment abbreviations
abbr -a p python
abbr -a ps ~/.venv/bin/python
abbr -a pip uv pip
abbr -a pi uv pip install
abbr -a pe uv pip install -e .
abbr -a pu uv pip uninstall
abbr -a pc uv pip sync
abbr -a pl uv pip list

abbr -a q exit

abbr -a rd rm -rf
abbr -a s starship
abbr -a zp zed-preview
abbr -a zh zed-preview .

# line counter
abbr -a tk tokei

function u
    brew upgrade
end

abbr -a ui uv init
abbr -a ua uv add
abbr -a ur uv remove
abbr -a us uv sync

abbr -a y yarn
abbr -a yt yarn test
abbr -a ytc yarn test --coverage

abbr -a b2 /usr/local/bin/brew

abbr -a abcdefghijklmnopqrstuvwxyz echo yay!!

fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin
set fish_greeting

abbr -a r source ~/.config/fish/config.fish

zoxide init fish | source
starship init fish | source

# fern
function fgen
    argparse 'n/no-prev' 'l/local' -- $argv
    or return

    set -l cmd fern generate --group $argv[1]-sdk --preview --log-level debug
    if set -ql _flag_n
        set cmd (string replace --all -- '--preview' '' $cmd)
    end
    if set -ql _flag_l
        set cmd (string replace --all -- 'fern' 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs' $cmd)
    end
    eval $cmd
end

function fdef
    argparse 'l/local' -- $argv
    or return

    set -l cmd fern write-definition
    if set -ql _flag_l
        set cmd (string replace --all -- 'fern' 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs' $cmd)
    end
    eval $cmd
end

function javaver
    set -x -g JAVA_HOME (/usr/libexec/java_home -v $argv[1])
end
abbr -a gw './gradlew'

function seedgen
    argparse 'o/output-to-seed' 's/scripts' -- $argv
    or return

    set -l cmd pnpm seed run --generator $argv[1]-sdk --path ~/sdks/$argv[2]-fern-config/fern --log-level debug --skipScripts
    if set -ql _flag_o
        set cmd $cmd --output-path ~/.seed/$argv[2]-$argv[1]
    end
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    eval $cmd
end

function seedtest
    argparse 's/scripts' -- $argv
    or return

    set -l cmd pnpm seed test --generator $argv[1]-sdk --fixture $argv[2] --outputFolder $argv[3] --log-level debug --skipScripts
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    eval $cmd
end

abbr -a fbuild 'pnpm install && pnpm fern:build'
abbr -a sbuild 'pnpm install && pnpm seed:build'
abbr -a build 'pnpm install && pnpm fern:build && pnpm seed:build'
abbr -a lfern FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs

abbr -a ghs gh auth switch

set -x -g PNPM_HOME /Users/Patrick/Library/pnpm

fish_add_path /Users/Patrick/Library/pnpm

abbr -a obliterate git clean -fdx

abbr -a frond pnpm frond
abbr -a shotsnap pnpm test:update --continue=always
