local note_dir = vim.fn.expand("~/Documents/git/scratch")
local sync_script = vim.fn.expand("~/bin/todo_sync.py")
local todo_file = note_dir .. "/TODO.md"

local tracked_files = {
  todo_file,
  note_dir .. "/OSAKA.md",
  note_dir .. "/DANANGNAVI.md",
}

local sync_group = vim.api.nvim_create_augroup("todo-sync", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = sync_group,
  pattern = tracked_files,
  callback = function(args)
    local mode = args.file == todo_file and "push" or "sync"
    local output = vim.fn.system({ "python3", sync_script, mode })

    if vim.v.shell_error ~= 0 then
      vim.schedule(function()
        vim.notify(output, vim.log.levels.ERROR)
      end)
      return
    end

    vim.schedule(function()
      vim.cmd("silent! checktime")
    end)
  end,
})
