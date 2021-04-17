local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- bootstrap packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local packer = nil
local function init()
    if packer == nil then
        packer = require("packer")
        packer.init({disable_commands = true})
    end

    local use = packer.use
    packer.reset()

    use {"wbthomason/packer.nvim", opt = true}
    -- theme
    use "glepnir/galaxyline.nvim" -- statusbar
    use "romgrk/barbar.nvim" -- bufferline
    use "norcalli/nvim-colorizer.lua" -- colors hex
    use "ryanoasis/vim-devicons" -- devicons
    use "Dave-Elec/gruvbox" -- colorscheme
    use "kyazdani42/nvim-web-devicons" -- more icons
    -- language
    use {"rust-lang/rust.vim", ft = {"rust", "rs"}} -- rust language tools
    use {"simrat39/rust-tools.nvim", ft = {"rust", "rs"}} -- rust language tools
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        ft = {"markdown", "md"},
        cmd = "MarkdownPreview"
    } -- markdown previewer
    use {"metakirby5/codi.vim", ft = {"js", "ts", "lua", "typescript", "javascript"}} -- code playground in buffer executed
    use "nvim-treesitter/nvim-treesitter" -- syntax highlight indent etc
    use {"windwp/nvim-ts-autotag", ft = {"tsx", "jsx", "html"}} -- autotag <>
    use {"shuntaka9576/preview-swagger.nvim", run = "yarn install", ft = {"yaml", "yml"}, cmd = "SwaggerPreview"} -- openapi preview
    -- snip
    use "norcalli/snippets.nvim" -- snippets
    use "SirVer/ultisnips" -- snippets
    use "hrsh7th/vim-vsnip" -- snippets
    -- completion
    use "nvim-lua/lsp-status.nvim" -- lsp status
    use "glepnir/lspsaga.nvim" -- fancy popups lsp
    use "onsails/lspkind-nvim" -- lsp extensions stuff
    use "nvim-lua/lsp_extensions.nvim" -- lsp extensions inlay hints etc
    use "neovim/nvim-lspconfig" -- default configs for lsp and setup lsp
    use "hrsh7th/nvim-compe" -- completion engine
    -- navigation
    use "nvim-telescope/telescope-github.nvim" -- github telescope
    use "nvim-telescope/telescope-project.nvim" -- project manager
    use "nvim-telescope/telescope.nvim" -- fuzzy finder
    use "nvim-telescope/telescope-media-files.nvim" -- media files showing
    use "kyazdani42/nvim-tree.lua" -- Drawboard style like nerdtree
    -- movement
    use "adelarsq/vim-matchit" -- matchit % jump
    use "justinmk/vim-sneak" -- movement plugin
    use "unblevable/quick-scope" -- f F t T improved highlight
    -- quality of life
    use "liuchengxu/vim-which-key" -- show key/map functionality for map chain
    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'},
    }
    use "preservim/nerdcommenter" -- commenting
    use "junegunn/vim-slash" -- better search
    use "windwp/nvim-autopairs" -- autopairs "" {}
    use "alvan/vim-closetag" -- close <> tag for xhtml ... maybe remove because of TS tag
    use "tpope/vim-surround" -- surround "" ''
    -- misc
    use "glepnir/dashboard-nvim" -- dashboard
    use {
        "lukas-reineke/indent-blankline.nvim",
        branch = "lua"
    } -- show indentation
    use {"dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 10]]} -- show startup time
    -- git
    use "ruifm/gitlinker.nvim" -- get repo file on remote as url
    use "lewis6991/gitsigns.nvim" -- like gitgutter shows hunks etc on sign column
    use "tpope/vim-fugitive" -- git integration
    use {"tpope/vim-rhubarb", cmd = "GBrowse"} -- GBrowse for gh
    use "APZelos/blamer.nvim" -- line blamer on cursor hold
    -- testing
    use "vim-test/vim-test" -- vim testing
    use "tpope/vim-dispatch" -- different building and run solution
    use "neomake/neomake" -- same as dispatch but async
    -- debug
    use {"puremourning/vimspector", disable = true} -- debugger
    -- lib
    use "norcalli/nvim_utils" -- utils
    use "nvim-lua/popup.nvim" -- LIB
    use "nvim-lua/plenary.nvim" -- LIB
end

local plugins =
    setmetatable(
    {},
    {
        __index = function(_, key)
            init()
            return packer[key]
        end
    }
)

cmd [[command! PackerInstall packadd packer.nvim | lua require('packer-config').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('packer-config').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('packer-config').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('packer-config').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('packer-config').compile()]]

return plugins