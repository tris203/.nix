{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    direnv
    wakatime-cli

    copilot-language-server

    roslyn-ls
    rzls

    gcc

    # Interpreters/Compilers
    # go
    rustc
    nodePackages_latest.nodejs
    luajit
    dotnet-sdk_9
    gnumake

    # LSPs
    nodePackages_latest.bash-language-server
    # biome
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    vscode-langservers-extracted
    htmx-lsp
    lua-language-server
    markdownlint-cli2
    nil
    rust-analyzer
    tailwindcss-language-server
    templ
    nodePackages_latest.typescript-language-server

    # Linter/Formatter
    eslint_d
    luajitPackages.luacheck
    nixpkgs-fmt
    nixd
    prettierd
    stylua
    yamllint
    proselint

    # GoTools
    # gofumpt
    # golines
    # golangci-lint
    # gotools
    # gomodifytags
    # gotests
    # iferr
    # impl
    # reftools
    # ginkgo
    # richgo
    # gotestsum
    # mockgen
    # govulncheck
    # templ
    # air

    # Protobuf
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # Tools
    pnpm
    sqlite
    luarocks
    scc
  ];

  programs.direnv.enable = true;

  environment.variables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
  };

}
