if status is-interactive
    # commands to run in interactive sessions can go here
end

if status is-login
    # commands to run in login sessions can go here
end

# file listing
abbr -a l eza -1 -l -a --no-user --no-permissions --icons=always
abbr -a ll eza -1 -l -a --total-size --no-user --no-permissions --icons=always
abbr -a lt eza -T -l -a --total-size --no-user --no-permissions --icons=always

abbr -a a aerospace
abbr -a aj aerospace join-with
abbr -a ajl aerospace join-with left
abbr -a ajr aerospace join-with right
abbr -a aju aerospace join-with up
abbr -a ajd aerospace join-with down
abbr -a af aerospace flatten-workspace-tree
abbr -a ar aerospace reload-config

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
abbr -a cgh zed-preview ~/dotfiles/ghostty
abbr -a cs zed-preview ~/dotfiles/starship
abbr -a ch zed-preview ~/dotfiles/helix
abbr -a cz zed-preview ~/dotfiles/zellij
abbr -a cg zed-preview ~/dotfiles/gdb/.gdbinit
abbr -a ce zed-preview ~/dotfiles/aerospace
# localizing config files
abbr -a cpg cp ~/dotfiles/.gitignore .gitignore
abbr -a cpp cp ~/dotfiles/pyright/pyrightconfig.json pyrightconfig.json

abbr -a cl clang
abbr -a g git
abbr -a gc gh repo clone

abbr -a f fzf

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

abbr -a d claude

abbr -a m pnpm
abbr -a mi pnpm i
abbr -a mt pnpm t
abbr -a mit pnpm it
abbr -a mu pnpm test:update
abbr -a mb pnpm build
abbr -a ms miniserve
abbr -a mr make run

abbr -a nn bun
abbr -a na bun add
abbr -a nc bun create
abbr -a ncs bun create svelte@latest
abbr -a ni bun install
abbr -a nv bun remove
abbr -a nr bun --bun run dev
abbr -a nb bun --bun run build
abbr -a nn bun run

abbr -a nf fastfetch

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
abbr -a py python
abbr -a ps ~/.venv/bin/python
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
function sc
    scc --no-cocomo -s complexity
end

function u
    brew upgrade
end

abbr -a ui uv init
abbr -a ua uv add
abbr -a ur uv run
abbr -a us uv sync
abbr -a um uv run mypy .
abbr -a up uv run pytest -rP .
abbr -a ut 'uv run mypy . && uv run pytest -rP .'

abbr -a x clear

abbr -a y yarn
abbr -a yt yarn test
abbr -a ytc yarn test --coverage

abbr -a b2 /usr/local/bin/brew

abbr -a abcdefghijklmnopqrstuvwxyz echo yay!!

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path /Users/Patrick/.bun/bin
set fish_greeting

set -x -g SHELL /opt/homebrew/bin/fish
set -x -g EDITOR /opt/homebrew/bin/zed-preview
set -x -g N_PREFIX ~/.n
# Node's bundled CA store doesn't trust some roots macOS does (e.g. GTS Root R4),
# breaking HTTPS in Node CLIs like fern. Point Node at the system CA bundle.
set -x -g NODE_EXTRA_CA_CERTS /etc/ssl/cert.pem

abbr -a r source ~/.config/fish/config.fish

zoxide init fish | source
starship init fish | source

# fern
function fgen
    argparse 'f/local-fern' 'd/dev' 'n/no-prev' 'g/local-gen' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd generate --group $argv[1]-sdk --preview --log-level debug
    if set -ql _flag_n || set -ql _flag_g
        set cmd (string replace --all -- '--preview' '' $cmd)
    end
    if set -ql _flag_g
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function fge
    argparse 'f/local-fern' 'd/dev' 'n/no-prev' 'g/local-gen' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd generate --group $argv[1] --preview --log-level debug
    if set -ql _flag_n || set -ql _flag_g
        set cmd (string replace --all -- '--preview' '' $cmd)
    end
    if set -ql _flag_g
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function fdef
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd write-definition
    echo $cmd
    eval $cmd
end

function fcheck
    argparse 'f/local-fern' 'd/dev' 'w/warnings' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd check
    if set -ql _flag_w
        set cmd $cmd --warnings
    end

    echo $cmd
    eval $cmd
end

function fdocs
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd docs dev --log-level debug
    echo $cmd
    eval $cmd
end

function fir
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd ir ir --log-level debug
    echo $cmd
    eval $cmd
end

function fir
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd ir ir --log-level debug
    echo $cmd
    eval $cmd
end

function fopen
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd openapi-ir openapi-ir --log-level debug
    echo $cmd
    eval $cmd
end

function fdir
    argparse 'f/local-fern' 'd/dev' -- $argv
    or return

    set -l ferncmd fern
    if set -ql _flag_f
        set ferncmd 'FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs'
    end
    if set -ql _flag_d
        set ferncmd fern-dev
    end

    set -l cmd $ferncmd dynamic-ir --language $argv[1] --log-level debug ir.json
    echo $cmd
    eval $cmd
end

function sgen
    argparse 's/scripts' 'r/remote' -- $argv
    or return

    set -l cmd pnpm seed run --generator $argv[1]-sdk --path ~/configs/$argv[2]-fern-config/fern --log-level debug --skipScripts --output-path ~/.seed/$argv[2]-$argv[1]
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    if not set -ql _flag_r
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function sge
    argparse 's/scripts' 'r/remote' -- $argv
    or return

    set -l cmd pnpm seed run --generator $argv[1] --path ~/configs/$argv[2]-fern-config/fern --log-level debug --skipScripts --output-path ~/.seed/$argv[2]-$argv[1]
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    if not set -ql _flag_r
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function sgennonce
    argparse 's/scripts' 'r/remote' -- $argv
    or return

    set -l cmd pnpm seed run --generator $argv[1]-sdk --path ~/nonce-configs/$argv[2]-fern-config/fern --log-level debug --skipScripts --output-path ~/.seed/$argv[2]-$argv[1]
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    if not set -ql _flag_r
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function stest
    argparse 's/scripts' 'r/remote' -- $argv
    or return

    set -l cmd pnpm seed test --generator $argv[1]-sdk --fixture $argv[2] --outputFolder $argv[3] --log-level debug --skipScripts
    if set -ql _flag_s
        set cmd (string replace --all -- '--skipScripts' '' $cmd)
    end
    if not set -ql _flag_r
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function stestall
    argparse 'r/remote' -- $argv
    or return

    set -l cmd pnpm seed test --generator $argv[1]-sdk
    if not set -ql _flag_r
        set cmd $cmd --local
    end

    echo $cmd
    eval $cmd
end

function gd
    git diff --no-index $argv[1] $argv[2]
end

function gu
    set -l lockfile (git rev-parse --git-dir 2>/dev/null)/index.lock
    if test -f $lockfile
        rm $lockfile
        echo "Removed $lockfile"
    else
        echo "No lock file found"
    end
end

function javaver
    set -x -g JAVA_HOME (/usr/libexec/java_home -v $argv[1])
end
abbr -a gw './gradlew'

abbr -a fbuild 'pnpm install && pnpm fern:build'
abbr -a sbuild 'pnpm install && pnpm seed:build'
abbr -a build 'pnpm install && pnpm fern:build && pnpm seed:build'
abbr -a lfern FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs

abbr -a ghs gh auth switch

set -x -g PNPM_HOME /Users/Patrick/Library/pnpm
set -x -g DOTNET_ROOT /usr/local/share/dotnet

fish_add_path /Users/Patrick/Library/pnpm
fish_add_path /Users/Patrick/.n/bin

abbr -a obliterate git clean -fdx

abbr -a frond pnpm frond
abbr -a ctestall pnpm test:update --continue=always
abbr -a ctest pnpm test:update --continue=always --filter @fern-api/openapi-ir-to-fern-tests

abbr -a cbd 'cd .. && cd -'

abbr -a ftoken fern token
abbr -a ftokenset set -x -g FERN_TOKEN
abbr -a ftokenclear set -e FERN_TOKEN

function hf-cache-test
    set -l cmd hyperfine --warmup 1 --runs 5 --export-markdown benchmark.md -u second -i
    set cmd $cmd \"fern wrong-command-entirely\"
    # set cmd $cmd \"FERN_NO_VERSION_REDIRECTION=true node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs wrong-command-entirely\"
    set cmd $cmd \"node ~/fern/fern/packages/cli/cli/dist/prod/cli.cjs wrong-command-entirely\"

    echo $cmd
    eval $cmd
end

abbr -a fu 'fern upgrade && fern generator upgrade --include-major'

function gou
    set -l PROJECT_NAME "wiremock-"(basename (dirname (pwd)) | tr -d ".")
    if test -f wiremock/docker-compose.test.yml
        docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml down
        docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml up -d
        set -gx WIREMOCK_PORT (docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml port wiremock 8080 | cut -d: -f2)
        echo "WIREMOCK_PORT=$WIREMOCK_PORT"
    end
end

function god
    set -l PROJECT_NAME "wiremock-"(basename (dirname (pwd)) | tr -d ".")
    docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml down
end

function got
    go test ./...
end

function testp
    echo "=========== poetry env use 3.13 =========="
    poetry env use 3.13
    echo
    echo "=========== poetry install =========="
    poetry install
    echo
    echo "=========== poetry run mypy . =========="
    poetry run mypy .
    echo
    echo "=========== poetry run pytest -rP . =========="
    poetry run pytest -rP .
end

function testc
    echo "=========== dotnet test =========="
    dotnet test
end

function testj
    echo "=========== ./gradlew clean =========="
    ./gradlew clean
    echo
    echo "=========== ./gradlew spotlessCheck =========="
    ./gradlew spotlessCheck
    echo
    echo "=========== ./gradlew build =========="
    ./gradlew build
end

function testg
    echo "=========== golangci-lint =========="
    printf 'version: "2"\nlinters:\n  exclusions:\n    paths:\n      - dynamic-snippets\n' > .golangci.yml
    golangci-lint run --timeout=5m --allow-parallel-runners
    or return 1
    echo

    set -l PROJECT_NAME "wiremock-"(basename (dirname (pwd)) | tr -d ".")
    if test -f wiremock/docker-compose.test.yml
        echo "=========== wiremock up =========="
        docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml down
        docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml up -d
        set -lx WIREMOCK_URL "http://localhost:"(docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml port wiremock 8080 | cut -d: -f2)
        echo "WIREMOCK_URL=$WIREMOCK_URL"
        echo
    end

    echo "=========== CGO_ENABLED=0 go test ./... =========="
    CGO_ENABLED=0 go test ./...
    set -l TEST_EXIT_CODE $status

    if test -f wiremock/docker-compose.test.yml
        echo
        echo "=========== wiremock down =========="
        docker compose -p $PROJECT_NAME -f wiremock/docker-compose.test.yml down
    end

    return $TEST_EXIT_CODE
end

function testh
    echo "=========== composer install =========="
    composer install
    echo
    echo "=========== composer build =========="
    composer build
    echo
    echo "=========== composer test =========="
    composer test
end

function testr
    echo "=========== bundle install =========="
    bundle install
    echo

    echo "=========== bundle exec rubocop =========="
    bundle exec rubocop
    echo

    echo "=========== docker compose -f wiremock/docker-compose.test.yml up -d --wait =========="
    docker compose -f wiremock/docker-compose.test.yml up -d --wait
    echo

    echo "=========== RUN_WIRE_TESTS=true bundle exec rake test =========="
    RUN_WIRE_TESTS=true bundle exec rake test
    echo

    echo "=========== docker compose -f wiremock/docker-compose.test.yml down =========="
    docker compose -f wiremock/docker-compose.test.yml down
end

abbr -a ferniec 'pnpm dist:cli:dev && pnpm dist:bin:local'
function fernie
    /Users/Patrick/fern/fern-cli-1/packages/cli/cli-v2/dist/bin/fern-darwin-arm64 $argv
end

# Added by `rbenv init` on Fri Feb 13 11:29:54 EST 2026
status --is-interactive; and rbenv init - --no-rehash fish | source
