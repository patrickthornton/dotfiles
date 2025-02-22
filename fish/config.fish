if status is-interactive
    # commands to run in interactive sessions can go here
end

if status is-login
    # commands to run in login sessions can go here
end

# file listing
abbr -a l eza -1 -l -a --total-size --no-user --no-permissions --icons=always
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
abbr -a cb cd ..

# config editing
abbr -a cf zed ~/dotfiles/fish
abbr -a cn zed ~/dotfiles/nushell
abbr -a ca zed ~/dotfiles/alacritty
abbr -a cs zed ~/dotfiles/starship
abbr -a ch zed ~/dotfiles/helix
abbr -a cz zed ~/dotfiles/zellij
abbr -a cg zed ~/dotfiles/gdb/.gdbinit

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

abbr -a op open .

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
abbr -a zh 'zed .'

# line counter
abbr -a tk tokei

function u
    brew upgrade
end

abbr -a ui uv init
abbr -a ua uv add
abbr -a ur uv remove
abbr -a us uv sync

abbr -a b2 /usr/local/bin/brew

abbr -a abcdefghijklmnopqrstuvwxyz echo yay!!

zoxide init fish | source
starship init fish | source
