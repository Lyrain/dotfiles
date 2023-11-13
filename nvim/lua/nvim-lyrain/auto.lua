-- Trailing Whitespace

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    desc = "Trim whitespace from the end of the line for all filetypes",
    command = [[%s/\s\+$//e]],
})

-- File Types

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'make', 'go'},
    desc = "Makefiles & Go files require actual tab characters.",
    callback = function()
        vim.opt.expandtab = false
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'javascript', 'typescript'},
    desc = "Set indent to 2 spaces for JavaScript & TypeScript",
    callback = function()
        vim.opt.tabstop = 2
    end,
})

-- Markdown

local markdown_group = vim.api.nvim_create_augroup('markdownGroup',
{ clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
{
    pattern = '*.Rmd',
    group = markdown_group,
    desc = "RMarkdown files should use the markdown filetype",
    callback = function()
        vim.opt.filetype = "markdown"
    end,
})

local enable_spell = function()
    vim.opt.spell = true
end

vim.api.nvim_create_autocmd('FileType',
{
    pattern = 'markdown',
    group = markdown_group,
    desc = "Markdown files should have spell enabled",
    callback = enable_spell,
})

-- TODO: iabbr

-- LaTex & Tex

vim.g.tex_flavor = "latex"
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    desc = "LaTex and Tex files should have spell enabled",
    callback = enable_spell,
})

