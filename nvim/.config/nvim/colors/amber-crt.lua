-- amber-crt — chữ hổ phách trên nền xám tối trung tính.
-- Các màu nền/bề mặt (bg, bg_alt, sel) lấy theo nền gnome-terminal đang dùng
-- (use-theme-colors, GTK vẽ #222226) và khớp với .tmux.conf + lualine.lua,
-- nên nvim, terminal và tmux nhìn như một hệ thống duy nhất.
--
-- Đổi màu ở bảng `c` bên dưới là đổi toàn bộ nvim; nhớ đổi khớp ở hai file kia.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "amber-crt"

local c = {
	bg = "#222226", -- nền (= nền gnome-terminal)
	bg_alt = "#2d2d34", -- nổi: dòng hiện tại, popup, statusline
	sel = "#4a4a54", -- vùng chọn, viền
	dim = "#8a7a6a", -- ghi chú, toán tử, dấu câu
	fg_dim = "#ab9370", -- chữ phụ
	fg = "#e8c89a", -- chữ chính, biến
	fg_brt = "#ffe0b0", -- nhấn mạnh

	amber = "#ffb000", -- hàm, tiêu đề
	amber_d = "#cc8800", -- hàm dựng sẵn
	rust = "#c05a10", -- lỗi
	orange = "#e07b4a", -- số, hằng
	olive = "#a08a3c",
	olive_l = "#c4a85a", -- chuỗi
	sand = "#c4b090", -- thuộc tính, field
	mauve = "#b06a7a",
	mauve_l = "#d99a9a", -- từ khoá
	violet = "#8a6f9c",
	violet_l = "#ab8dbf", -- kiểu dữ liệu
}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- ── giao diện chung ─────────────────────────────────────────────────────────
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg_alt })
hl("FloatBorder", { fg = c.sel, bg = c.bg_alt })
hl("FloatTitle", { fg = c.amber, bg = c.bg_alt, bold = true })
hl("EndOfBuffer", { fg = c.bg })
hl("Cursor", { fg = c.bg, bg = c.amber })
hl("lCursor", { fg = c.bg, bg = c.amber })
hl("CursorLine", { bg = c.bg_alt })
hl("CursorColumn", { bg = c.bg_alt })
hl("ColorColumn", { bg = c.bg_alt })
hl("CursorLineNr", { fg = c.amber, bold = true })
hl("LineNr", { fg = c.sel })
hl("SignColumn", { bg = c.bg })
hl("FoldColumn", { fg = c.sel, bg = c.bg })
hl("Folded", { fg = c.dim, bg = c.bg_alt, italic = true })
hl("WinSeparator", { fg = c.bg_alt })
hl("VertSplit", { fg = c.bg_alt })
hl("NonText", { fg = c.sel })
hl("SpecialKey", { fg = c.sel })
hl("Whitespace", { fg = c.sel })
hl("Conceal", { fg = c.dim })
hl("Directory", { fg = c.amber, bold = true })
hl("Title", { fg = c.amber, bold = true })

hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
hl("StatusLineNC", { fg = c.dim, bg = c.bg_alt })
hl("TabLine", { fg = c.dim, bg = c.bg_alt })
hl("TabLineFill", { bg = c.bg })
hl("TabLineSel", { fg = c.amber, bg = c.bg, bold = true })
hl("WinBar", { fg = c.fg_dim, bg = c.bg })
hl("WinBarNC", { fg = c.dim, bg = c.bg })

hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
hl("PmenuSel", { fg = c.bg, bg = c.amber, bold = true })
hl("PmenuSbar", { bg = c.bg_alt })
hl("PmenuThumb", { bg = c.sel })
hl("WildMenu", { fg = c.bg, bg = c.amber })

hl("Visual", { bg = c.sel })
hl("VisualNOS", { bg = c.sel })
hl("Search", { fg = c.bg, bg = c.amber_d })
hl("IncSearch", { fg = c.bg, bg = c.amber, bold = true })
hl("CurSearch", { fg = c.bg, bg = c.amber, bold = true })
hl("Substitute", { fg = c.bg, bg = c.orange })
hl("MatchParen", { fg = c.amber, bold = true, underline = true })
hl("QuickFixLine", { bg = c.bg_alt, bold = true })

hl("ErrorMsg", { fg = c.rust, bold = true })
hl("WarningMsg", { fg = c.orange })
hl("MoreMsg", { fg = c.amber })
hl("ModeMsg", { fg = c.fg, bold = true })
hl("Question", { fg = c.amber })
hl("MsgArea", { fg = c.fg })

-- ── cú pháp cơ bản ──────────────────────────────────────────────────────────
hl("Comment", { fg = c.dim, italic = true })

hl("Constant", { fg = c.orange })
hl("String", { fg = c.olive_l })
hl("Character", { fg = c.olive_l })
hl("Number", { fg = c.orange })
hl("Float", { fg = c.orange })
hl("Boolean", { fg = c.orange, bold = true })

hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.amber })

hl("Statement", { fg = c.mauve_l })
hl("Conditional", { fg = c.mauve_l })
hl("Repeat", { fg = c.mauve_l })
hl("Label", { fg = c.mauve_l })
hl("Operator", { fg = c.dim })
hl("Keyword", { fg = c.mauve_l })
hl("Exception", { fg = c.rust })

hl("PreProc", { fg = c.violet_l })
hl("Include", { fg = c.mauve_l })
hl("Define", { fg = c.violet_l })
hl("Macro", { fg = c.violet_l })
hl("PreCondit", { fg = c.violet_l })

hl("Type", { fg = c.violet_l })
hl("StorageClass", { fg = c.mauve_l })
hl("Structure", { fg = c.violet_l })
hl("Typedef", { fg = c.violet_l })

hl("Special", { fg = c.sand })
hl("SpecialChar", { fg = c.orange })
hl("Tag", { fg = c.mauve_l })
hl("Delimiter", { fg = c.dim })
hl("SpecialComment", { fg = c.fg_dim, italic = true })
hl("Debug", { fg = c.rust })

hl("Underlined", { underline = true })
hl("Ignore", { fg = c.sel })
hl("Error", { fg = c.rust, bold = true })
hl("Todo", { fg = c.bg, bg = c.amber, bold = true })

-- ── treesitter ──────────────────────────────────────────────────────────────
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.mauve, italic = true })
hl("@variable.parameter", { fg = c.fg_dim, italic = true })
hl("@variable.member", { fg = c.sand })

hl("@constant", { fg = c.orange })
hl("@constant.builtin", { fg = c.orange, bold = true })
hl("@constant.macro", { fg = c.violet_l })

hl("@module", { fg = c.violet_l })
hl("@label", { fg = c.mauve_l })

hl("@string", { fg = c.olive_l })
hl("@string.escape", { fg = c.orange, bold = true })
hl("@string.special", { fg = c.sand })
hl("@string.regexp", { fg = c.sand })
hl("@character", { fg = c.olive_l })
hl("@number", { fg = c.orange })
hl("@boolean", { fg = c.orange, bold = true })

hl("@function", { fg = c.amber })
hl("@function.builtin", { fg = c.amber_d })
hl("@function.call", { fg = c.amber })
hl("@function.method", { fg = c.amber })
hl("@constructor", { fg = c.violet_l })
hl("@operator", { fg = c.dim })

hl("@keyword", { fg = c.mauve_l })
hl("@keyword.function", { fg = c.mauve_l })
hl("@keyword.operator", { fg = c.mauve_l })
hl("@keyword.return", { fg = c.rust })
hl("@keyword.import", { fg = c.mauve_l })
hl("@keyword.exception", { fg = c.rust })

hl("@type", { fg = c.violet_l })
hl("@type.builtin", { fg = c.violet_l, italic = true })
hl("@type.definition", { fg = c.violet_l })
hl("@attribute", { fg = c.sand })
hl("@property", { fg = c.sand })
hl("@field", { fg = c.sand })

hl("@punctuation.delimiter", { fg = c.dim })
hl("@punctuation.bracket", { fg = c.dim })
hl("@punctuation.special", { fg = c.orange })

hl("@comment", { fg = c.dim, italic = true })
hl("@comment.error", { fg = c.bg, bg = c.rust, bold = true })
hl("@comment.warning", { fg = c.bg, bg = c.orange, bold = true })
hl("@comment.todo", { fg = c.bg, bg = c.amber, bold = true })
hl("@comment.note", { fg = c.bg, bg = c.sand, bold = true })

hl("@tag", { fg = c.mauve_l })
hl("@tag.attribute", { fg = c.sand })
hl("@tag.delimiter", { fg = c.dim })

hl("@markup.heading", { fg = c.amber, bold = true })
hl("@markup.strong", { fg = c.fg_brt, bold = true })
hl("@markup.italic", { fg = c.fg, italic = true })
hl("@markup.strikethrough", { fg = c.dim, strikethrough = true })
hl("@markup.link", { fg = c.amber_d, underline = true })
hl("@markup.link.url", { fg = c.olive_l, underline = true })
hl("@markup.raw", { fg = c.olive_l })
hl("@markup.list", { fg = c.orange })
hl("@markup.quote", { fg = c.dim, italic = true })

hl("@diff.plus", { fg = c.olive })
hl("@diff.minus", { fg = c.rust })
hl("@diff.delta", { fg = c.amber_d })

-- ── LSP ─────────────────────────────────────────────────────────────────────
hl("@lsp.type.namespace", { link = "@module" })
hl("@lsp.type.class", { link = "@type" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.interface", { link = "@type" })
hl("@lsp.type.struct", { link = "@type" })
hl("@lsp.type.parameter", { link = "@variable.parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.function", { link = "@function" })
hl("@lsp.type.method", { link = "@function.method" })
hl("@lsp.type.macro", { link = "@constant.macro" })
hl("@lsp.type.decorator", { link = "@attribute" })

hl("LspReferenceText", { bg = c.bg_alt })
hl("LspReferenceRead", { bg = c.bg_alt })
hl("LspReferenceWrite", { bg = c.bg_alt, underline = true })
hl("LspInlayHint", { fg = c.sel, bg = c.bg_alt, italic = true })
hl("LspSignatureActiveParameter", { fg = c.amber, bold = true })
hl("LspCodeLens", { fg = c.dim, italic = true })

hl("DiagnosticError", { fg = c.rust })
hl("DiagnosticWarn", { fg = c.orange })
hl("DiagnosticInfo", { fg = c.sand })
hl("DiagnosticHint", { fg = c.dim })
hl("DiagnosticOk", { fg = c.olive })
hl("DiagnosticUnderlineError", { sp = c.rust, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = c.orange, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = c.sand, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = c.dim, undercurl = true })
hl("DiagnosticVirtualTextError", { fg = c.rust, bg = c.bg_alt })
hl("DiagnosticVirtualTextWarn", { fg = c.orange, bg = c.bg_alt })
hl("DiagnosticVirtualTextInfo", { fg = c.sand, bg = c.bg_alt })
hl("DiagnosticVirtualTextHint", { fg = c.dim, bg = c.bg_alt })

-- ── diff & git ──────────────────────────────────────────────────────────────
-- nền diff = nền xám tối trộn với màu tương ứng, đủ nổi mà không chói
hl("DiffAdd", { fg = c.olive_l, bg = "#3b372a" })
hl("DiffChange", { fg = c.amber_d, bg = "#44361e" })
hl("DiffDelete", { fg = c.rust, bg = "#422d22" })
hl("DiffText", { fg = c.amber, bg = "#644d1b", bold = true })
hl("Added", { fg = c.olive })
hl("Changed", { fg = c.amber_d })
hl("Removed", { fg = c.rust })

hl("GitSignsAdd", { fg = c.olive })
hl("GitSignsChange", { fg = c.amber_d })
hl("GitSignsDelete", { fg = c.rust })
hl("GitSignsCurrentLineBlame", { fg = c.sel, italic = true })

hl("gitcommitSummary", { fg = c.fg })
hl("gitcommitComment", { fg = c.dim, italic = true })

-- ── telescope ───────────────────────────────────────────────────────────────
hl("TelescopeNormal", { fg = c.fg, bg = c.bg })
hl("TelescopeBorder", { fg = c.sel, bg = c.bg })
hl("TelescopeTitle", { fg = c.bg, bg = c.amber, bold = true })
hl("TelescopePromptNormal", { fg = c.fg, bg = c.bg_alt })
hl("TelescopePromptBorder", { fg = c.bg_alt, bg = c.bg_alt })
hl("TelescopePromptTitle", { fg = c.bg, bg = c.amber, bold = true })
hl("TelescopePromptPrefix", { fg = c.amber })
hl("TelescopeSelection", { fg = c.fg_brt, bg = c.bg_alt, bold = true })
hl("TelescopeSelectionCaret", { fg = c.amber, bg = c.bg_alt })
hl("TelescopeMatching", { fg = c.amber, bold = true })

-- ── fzf-lua ─────────────────────────────────────────────────────────────────
hl("FzfLuaNormal", { fg = c.fg, bg = c.bg })
hl("FzfLuaBorder", { fg = c.sel, bg = c.bg })
hl("FzfLuaTitle", { fg = c.bg, bg = c.amber, bold = true })
hl("FzfLuaPreviewNormal", { fg = c.fg, bg = c.bg })
hl("FzfLuaPreviewBorder", { fg = c.sel, bg = c.bg })
hl("FzfLuaPreviewTitle", { fg = c.bg, bg = c.amber, bold = true })
hl("FzfLuaCursorLine", { bg = c.bg_alt, bold = true })

-- ── neo-tree ────────────────────────────────────────────────────────────────
-- bg = "NONE" để cây file trong suốt như phần buffer, ăn theo nền terminal.
-- Chỉ CursorLine và TitleBar giữ nền, nếu không sẽ không thấy dòng đang chọn.
hl("NeoTreeNormal", { fg = c.fg, bg = "NONE" })
hl("NeoTreeNormalNC", { fg = c.fg, bg = "NONE" })
hl("NeoTreeEndOfBuffer", { fg = c.bg, bg = "NONE" })
hl("NeoTreeWinSeparator", { fg = c.bg_alt, bg = "NONE" })
hl("NeoTreeFloatNormal", { fg = c.fg, bg = "NONE" })
hl("NeoTreeFloatBorder", { fg = c.sel, bg = "NONE" })
hl("NeoTreeFloatTitle", { fg = c.amber, bg = "NONE", bold = true })
hl("NeoTreeTabInactive", { fg = c.dim, bg = "NONE" })
hl("NeoTreeTabActive", { fg = c.amber, bg = "NONE", bold = true })
hl("NeoTreeTabSeparatorInactive", { fg = c.bg_alt, bg = "NONE" })
hl("NeoTreeTabSeparatorActive", { fg = c.amber, bg = "NONE" })
hl("NeoTreeDirectoryName", { fg = c.amber })
hl("NeoTreeDirectoryIcon", { fg = c.amber_d })
hl("NeoTreeRootName", { fg = c.amber, bold = true })
hl("NeoTreeFileName", { fg = c.fg })
hl("NeoTreeFileNameOpened", { fg = c.fg_brt, bold = true })
hl("NeoTreeIndentMarker", { fg = c.sel })
hl("NeoTreeGitAdded", { fg = c.olive })
hl("NeoTreeGitModified", { fg = c.amber_d })
hl("NeoTreeGitDeleted", { fg = c.rust })
hl("NeoTreeGitUntracked", { fg = c.dim, italic = true })
hl("NeoTreeCursorLine", { bg = c.bg_alt })
hl("NeoTreeTitleBar", { fg = c.bg, bg = c.amber, bold = true })

-- ── nvim-cmp / blink ────────────────────────────────────────────────────────
hl("CmpItemAbbr", { fg = c.fg })
hl("CmpItemAbbrDeprecated", { fg = c.dim, strikethrough = true })
hl("CmpItemAbbrMatch", { fg = c.amber, bold = true })
hl("CmpItemAbbrMatchFuzzy", { fg = c.amber_d, bold = true })
hl("CmpItemKind", { fg = c.violet_l })
hl("CmpItemMenu", { fg = c.dim, italic = true })

-- ── terminal của nvim: đúng 16 màu ANSI của alacritty/wezterm ───────────────
vim.g.terminal_color_0 = c.bg_alt
vim.g.terminal_color_1 = c.rust
vim.g.terminal_color_2 = c.olive
vim.g.terminal_color_3 = c.amber_d
vim.g.terminal_color_4 = c.violet
vim.g.terminal_color_5 = c.mauve
vim.g.terminal_color_6 = "#9c8a6a"
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.sel
vim.g.terminal_color_9 = c.orange
vim.g.terminal_color_10 = c.olive_l
vim.g.terminal_color_11 = c.amber
vim.g.terminal_color_12 = c.violet_l
vim.g.terminal_color_13 = c.mauve_l
vim.g.terminal_color_14 = c.sand
vim.g.terminal_color_15 = c.fg_brt
