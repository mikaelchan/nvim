local cmp = require('cmp')
local luasnip = require('luasnip')
local kind_icons = {
  Array = '',
  Boolean = '',
  Key = '',
  Keyword = '',
  Namespace = '',
  Null = 'ﳠ',
  Number = '',
  Object = '',
  Package = '',
  String = '',
  Variable = '',
  Class = '',
  Color = '',
  Constant = '',
  Constructor = '',
  Default = '',
  Enum = '練',
  EnumMember = '',
  Event = '',
  Field = 'ﰠ',
  File = '',
  Folder = '',
  Function = '',
  Interface = '',
  Method = '',
  Module = '',
  Operator = '',
  Property = ' ',
  Reference = '',
  Snippet = ' ',
  Struct = 'פּ',
  Text = '',
  TypeParameter = '',
  Unit = '塞',
  Value = ' ',
}
local source_names = {
  nvim_lsp = '(LSP)',
  emoji = '(Emoji)',
  path = '(Path)',
  calc = '(Calc)',
  vsnip = '(Snippet)',
  luasnip = '(Snippet)',
  buffer = '(Buffer)',
  tmux = '(TMUX)',
  copilot = '(Copilot)',
  treesitter = '(TreeSitter)',
  ['vim-dadbod-completion'] = '(DadBod)',
}
local duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 0,
  luasnip = 1,
}
local cmp_border = {
  { '╭', 'CmpBorder' },
  { '─', 'CmpBorder' },
  { '╮', 'CmpBorder' },
  { '│', 'CmpBorder' },
  { '╯', 'CmpBorder' },
  { '─', 'CmpBorder' },
  { '╰', 'CmpBorder' },
  { '│', 'CmpBorder' },
}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  completion = {
    keyword_length = 1,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },

    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]

      if entry.source.name == 'copilot' then
        vim_item.kind = ''
        vim_item.kind_hl_group = 'CmpItemKindCopilot'
      end

      if entry.source.name == 'crates' then
        vim_item.kind = ''
        vim_item.kind_hl_group = 'CmpItemKindCrate'
      end

      if entry.source.name == 'emoji' then
        vim_item.kind = ''
        vim_item.kind_hl_group = 'CmpItemKindEmoji'
      end

      vim_item.menu = source_names[entry.source.name]
      vim_item.dup = duplicates[entry.source.name] or 0
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      border = cmp_border,
    },
    documentation = {
      border = cmp_border,
    },
  },
  sources = {
    {
      name = 'copilot',
      max_item_count = 3,
    },
    {
      name = 'nvim_lsp',
      entry_filter = function(entry, ctx)
        local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
        if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
          return false
        end
        if kind == 'Text' then
          return false
        end
        return true
      end,
    },

    { name = 'path' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'treesitter' },
    { name = 'crates' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
      end
    end, { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        } -- avoid mutating the original opts below
        local is_insert_mode = function()
          return vim.api.nvim_get_mode().mode:sub(1, 1) == 'i'
        end
        if is_insert_mode() then -- prevent overwriting brackets
          confirm_opts.behavior = cmp.ConfirmBehavior.Insert
        end
        if cmp.confirm(confirm_opts) then
          return -- success, exit early
        end
      end
      fallback() -- if not exited early, always fallback
    end),
  }),
  cmdline = {
    enable = true,
    options = {
      {
        type = ':',
        sources = {
          { name = 'path' },
          { name = 'cmdline' },
        },
      },
      {
        type = { '/', '?' },
        sources = {
          { name = 'buffer' },
        },
      },
    },
  },
})

local cmdline_opts = {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = {
    {
      name = 'cmdline',
    },
    {
      name = 'path',
    },
  },
}
cmdline_opts.window = {
  completion = {
    border = cmp_border,
    winhighlight = 'Search:None',
  },
}
cmp.setup.cmdline(':', cmdline_opts)
