-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
	vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local vim = vim
local Plug = vim.fn['plug#']
--local cmp = require("cmp")

vim.g.start_time = vim.fn.reltime()
vim.call('plug#begin')

-- LSP

Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("L3MON4D3/LuaSnip")

Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) --colorscheme
Plug('ellisonleao/gruvbox.nvim', { ['as'] = 'gruvbox' }) --colorscheme 2
Plug('uZer/pywal16.nvim', { [ 'as' ] = 'pywal16' }) --or, pywal colorscheme
Plug('nvim-lualine/lualine.nvim') --statusline
Plug('nvim-tree/nvim-web-devicons') --pretty icons
Plug('folke/which-key.nvim') --mappings popup
Plug('romgrk/barbar.nvim') --bufferline
Plug('goolord/alpha-nvim') --pretty startup
Plug('nvim-treesitter/nvim-treesitter') --improved syntax
Plug('mfussenegger/nvim-lint') --async linter
Plug('nvim-tree/nvim-tree.lua') --file explorer
Plug('windwp/nvim-autopairs') --autopairs 
Plug('lewis6991/gitsigns.nvim') --git
Plug('numToStr/Comment.nvim') --easier comments
Plug('norcalli/nvim-colorizer.lua') --color highlight
Plug('ibhagwan/fzf-lua') --fuzzy finder and grep
Plug('numToStr/FTerm.nvim') --floating terminal
Plug('ron-rs/ron.vim') --ron syntax highlighting
Plug('MeanderingProgrammer/render-markdown.nvim') --render md inline
Plug('emmanueltouzery/decisive.nvim') --view csv files
Plug('folke/twilight.nvim') --surrounding dim

vim.call('plug#end')

-- LSP
--require("mason").setup()
--[[require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "lua_ls", "html", "clangd" }
})

local capabilities = {}
local cmp_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_status then
	capabilities = cmp_nvim_lsp.default_capabilities()
end

if vim.lsp.config then
	vim.lsp.config("clangd", {
		capabilities = capabilities,
		cmd = {"clangd", "--background-index", "--clang-tidy"},
	})
	vim.lsp.enable("clangd")
else
	local lsp_status, lspconfig = pcall(require, "lspconfig")
	if lsp_status then
		lspconfig.clangd.setup({capabilities = capabilities})
	end
end--]]

local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if mason_ok and mason_lsp_ok then
    mason.setup()
    mason_lsp.setup({
        ensure_installed = { "lua_ls" }
    })
end

-- 2. Autocompletion Engine (nvim-cmp)
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")

if cmp_ok and luasnip_ok then
    cmp.setup({
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        })
    })
end

-- 3. LSP Configuration (Using the modern 0.11 style from nvim-lspconfig)
local caps = {}
local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_ok then
    caps = cmp_nvim_lsp.default_capabilities()
end

-- We use vim.lsp.enable if available (NVIM 0.11+), otherwise fallback to setup()
local function setup_server(server_name, config)
    config = vim.tbl_deep_extend("force", { capabilities = caps }, config or {})
    
    if vim.lsp.config then
        -- New 0.11 API
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    else
        -- Traditional API (nvim-lspconfig)
        local lsp_ok, lspconfig = pcall(require, "lspconfig")
        if lsp_ok then
            lspconfig[server_name].setup(config)
        end
    end
end

-- Enable your servers
setup_server("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy" }
})
setup_server("lua_ls")
setup_server("ts_ls")
setup_server("html")

--[[cmp.setup({
	snippet = {
		expand = function(args) require("luasnip").lsp_expand(args.body) end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({select = true}),
	}),
	sources = cmp.config.sources({
		{name = "nvim_lsp"},
	})
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").clangd.setup({
	capabilities = capabilities
})--]]

vim.loader.enable() --  SPEEEEEEEEEEED 

-- move config and plugin config to alternate files
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")

require("plugins.alpha")
require("plugins.autopairs")
require("plugins.barbar")
require("plugins.colorizer")
require("plugins.colorscheme")
require("plugins.comment")
require("plugins.fterm")
require("plugins.fzf-lua")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-lint")
require("plugins.nvim-tree")
require("plugins.render-markdown")
--require("plugins.treesitter")
require("plugins.twilight")
require("plugins.which-key")

vim.defer_fn(function() 
	--defer non-essential configs,
	--purely for experimental purposes:
	--this only makes a difference of +-10ms on initial startup
	require("plugins.autopairs")
	require("plugins.fterm")
	require("plugins.fzf-lua")
	require("plugins.nvim-tree")
	require("plugins.treesitter")
	require("plugins.twilight")
	require("plugins.which-key")
end, 100)

load_theme()
