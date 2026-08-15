-- File config WezTerm DUY NHẤT.
-- WezTerm tìm config theo thứ tự: $WEZTERM_CONFIG_FILE → $HOME/.wezterm.lua
-- → $XDG_CONFIG_HOME/wezterm/wezterm.lua → $HOME/.config/wezterm/wezterm.lua
-- File này đứng thứ hai nên luôn thắng. Trước đây còn một bản thứ hai ở
-- .config/wezterm/wezterm.lua không bao giờ được đọc — đã xoá để khỏi sửa nhầm.

local wezterm = require("wezterm")
local config = wezterm.config_builder()
local io = require("io")
local os = require("os")

local brightness = 0.03
local background_folder = wezterm.home_dir .. "/bg"
local bg_image = wezterm.home_dir .. "/bg/bg.jpg"

-- Lấy ảnh ngẫu nhiên trong background_folder, chỉ nhận file ảnh thật
local function pick_random_background(folder)
    if not os.execute('test -d "' .. folder .. '"') then
        wezterm.log_error("Thư mục không tồn tại: " .. folder)
        return nil
    end

    local cmd = 'find "' .. folder .. '" -type f | grep -E "\\.(jpg|jpeg|png|webp)$"'
    local handle = io.popen(cmd)
    if handle ~= nil then
        local files = handle:read("*a")
        handle:close()
        local images = {}
        for file in string.gmatch(files, "[^\n]+") do
            table.insert(images, file)
        end
        if #images > 0 then
            return images[math.random(#images)]
        else
            wezterm.log_error("Không tìm thấy ảnh hợp lệ trong: " .. folder)
        end
    end
    return nil
end

config.window_background_image_hsb = {
    brightness = brightness,
    hue = 1.0,
    saturation = 0.8,
}

-- Mặc định nền màu đặc, không ảnh.
-- CTRL+SHIFT+B bật ảnh nền ngẫu nhiên, CTRL+SHIFT+X tắt về nền màu.
-- config.window_background_image = bg_image

-- window
config.window_background_opacity = 1
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_frame = {
    -- border_left_width = "0.18cell",
    -- border_right_width = "0.18cell",
    -- border_bottom_height = "0.08cell",
    -- border_top_height = "0.08cell",
}

-- ────────────────────────────────────────────────────────────────────────────
-- Chữ amber CRT trên nền xám tối trung tính — 16 màu ANSI ánh xạ về dải ấm
-- nhưng vẫn phân biệt được. Nền/bề mặt (#222226…) khớp nền gnome-terminal
-- (GTK theme), ~/.tmux.conf, alacritty.toml và nvim colors/amber-crt.lua
-- ────────────────────────────────────────────────────────────────────────────
config.colors = {
    foreground = "#e8c89a",
    background = "#222226",

    cursor_bg = "#ffb000",
    cursor_fg = "#222226",
    cursor_border = "#ffb000",

    selection_fg = "#222226",
    selection_bg = "#cc8800",

    scrollbar_thumb = "#4a4a54",
    split = "#2d2d34",

    ansi = {
        "#2d2d34", -- black
        "#c05a10", -- red
        "#a08a3c", -- green
        "#cc8800", -- yellow
        "#8a6f9c", -- blue
        "#b06a7a", -- magenta
        "#9c8a6a", -- cyan
        "#e8c89a", -- white
    },
    brights = {
        "#4a4a54",
        "#e07b4a",
        "#c4a85a",
        "#ffb000",
        "#ab8dbf",
        "#d99a9a",
        "#c4b090",
        "#ffe0b0",
    },
}

config.font = wezterm.font("Inconsolata Nerd Font Mono", { weight = "Medium", stretch = "Expanded" })
config.font_size = 20

-- IME cho tiếng Việt (ibus-bamboo)
config.use_ime = true
config.xim_im_name = "ibus" -- dùng cho X11; nếu chạy Wayland mà lỗi IME thì comment dòng này

-- keys
config.keys = {
    -- Đổi ảnh nền ngẫu nhiên
    {
        key = "b",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window)
            local new_bg = pick_random_background(background_folder)
            if new_bg then
                bg_image = new_bg
                window:set_config_overrides({
                    window_background_image = bg_image,
                    window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 },
                })
                wezterm.log_info("Đã đổi ảnh nền: " .. bg_image)
            else
                wezterm.log_error("Không tìm được ảnh nền")
            end
        end),
    },
    -- Xoá ảnh nền, quay về nền màu đặc.
    -- Cần binding này vì set_config_overrides đè lên config file: reload config
    -- (CTRL+SHIFT+R) KHÔNG xoá được ảnh nền đã đặt bằng CTRL+SHIFT+B.
    {
        key = "X",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window)
            window:set_config_overrides({})
            wezterm.log_info("Đã xoá ảnh nền, quay về nền màu đặc")
        end),
    },
    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
    {
        key = "M",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ToggleFullScreen,
    },
    -- Tăng độ sáng ảnh nền
    {
        key = ">",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window)
            brightness = math.min(brightness + 0.01, 1.0)
            window:set_config_overrides({
                window_background_image = bg_image,
                window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 },
            })
        end),
    },
    -- Giảm độ sáng ảnh nền
    {
        key = "<",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window)
            brightness = math.max(brightness - 0.01, 0.01)
            window:set_config_overrides({
                window_background_image = bg_image,
                window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 },
            })
        end),
    },
}

-- others
config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.max_fps = 120

return config
