{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Interpreters/Compilers
    go
    rustc
    nodePackages_latest.nodejs
    luajit
    dotnet-sdk_8

    # LSPs
    nodePackages_latest.bash-language-server
    biome
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
    prettierd
    stylua
    yamllint

    # Tools
    pnpm
    sqlite
    luarocks
  ];
}
