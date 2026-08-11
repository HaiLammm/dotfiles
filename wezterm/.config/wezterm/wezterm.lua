local wezterm = require("wezterm")
local config = wezterm.config_builder()
local io = require("io")
local os = require("os")

-- 1. Khai báo biến toàn cục để lưu trạng thái hiện tại
local brightness = 0.5  -- Tăng mặc định để dễ nhìn hơn
local background_folder = wezterm.home_dir .. "/bg"
local current_bg = wezterm.home_dir .. "/.config/nvim/bg/bg.jpg"  -- Giữ nguyên, nhưng đảm bảo file tồn tại

-- 2. Hàm lấy ảnh ngẫu nhiên (Cải thiện kiểm tra lỗi)
local function pick_random_background(folder)
    -- Kiểm tra thư mục tồn tại trước
    if not os.execute('test -d "' .. folder .. '"') then
        wezterm.log_error("Thư mục không tồn tại: " .. folder)
        return nil
    end

    -- Sử dụng lệnh 'find' để lọc file ảnh
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

-- 3. Cấu hình mặc định — nền đặc một màu, không ảnh nền.
-- Ảnh nền vẫn bật lại được bất cứ lúc nào bằng CTRL+SHIFT+B bên dưới.
-- config.window_background_image = current_bg
-- config.window_background_image_hsb = {
--     brightness = brightness,
--     hue = 1.0,
--     saturation = 0.8,
-- }

-- Các thiết lập giao diện khác
config.window_background_opacity = 1.0
config.font = wezterm.font("Inconsolata Nerd Font")
config.font_size = 25
config.enable_tab_bar = false

-- ────────────────────────────────────────────────────────────────────────────
-- Bảng màu amber CRT — 16 màu ANSI ánh xạ về dải ấm nhưng vẫn phân biệt được.
-- Khớp với ~/.tmux.conf và alacritty.toml
-- ────────────────────────────────────────────────────────────────────────────
config.colors = {
    foreground = "#e8c89a",
    background = "#2b2433",

    cursor_bg = "#ffb000",
    cursor_fg = "#2b2433",
    cursor_border = "#ffb000",

    selection_fg = "#2b2433",
    selection_bg = "#cc8800",

    scrollbar_thumb = "#5a4f66",
    split = "#3a3145",

    ansi = {
        "#3a3145", -- black
        "#c05a10", -- red
        "#a08a3c", -- green
        "#cc8800", -- yellow
        "#8a6f9c", -- blue
        "#b06a7a", -- magenta
        "#9c8a6a", -- cyan
        "#e8c89a", -- white
    },
    brights = {
        "#5a4f66",
        "#e07b4a",
        "#c4a85a",
        "#ffb000",
        "#ab8dbf",
        "#d99a9a",
        "#c4b090",
        "#ffe0b0",
    },
}

-- Thêm hỗ trợ IME cho tiếng Việt (ibus-bamboo)
config.use_ime = true  -- Bật IME để nhập tiếng Việt
config.xim_im_name = 'ibus'  -- Dùng cho X11, nếu Wayland thì thử comment dòng này

-- Nếu dùng Wayland và vẫn lỗi IME, thử thêm:
-- config.enable_wayland = false

-- 4. Xử lý Phím tắt
config.keys = {
    -- Đổi hình nền ngẫu nhiên (CTRL + SHIFT + B)
    {
        key = "B",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window, pane)
            local new_bg = pick_random_background(background_folder)
            if new_bg then
                current_bg = new_bg
                window:set_config_overrides({
                    window_background_image = current_bg,
                    window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 }
                })
                wezterm.log_info("Đã đổi ảnh: " .. current_bg)
            end
        end),
    },
    -- Tăng độ sáng (CTRL + SHIFT + >)
    {
        key = ">",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window, pane)
            brightness = math.min(brightness + 0.01, 1.0)
            window:set_config_overrides({
                window_background_image = current_bg,
                window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 }
            })
        end),
    },
    -- Giảm độ sáng (CTRL + SHIFT + <)
    {
        key = "<",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window, pane)
            brightness = math.max(brightness - 0.01, 0.01)
            window:set_config_overrides({
                window_background_image = current_bg,
                window_background_image_hsb = { brightness = brightness, hue = 1.0, saturation = 0.8 }
            })
        end),
    },
}

return config
