local M = {}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

M.defaults = {
  {
    name = "BufferKill",
    fn = function()
      require("user.bufferline").buf_kill "bd"
    end,
  },
  {
    name = "UserToggleFormatOnSave",
    fn = function()
      require("user.autocmds").toggle_format_on_save()
    end,
  },
  {
    name = "UserInfo",
    fn = function()
      require("user.info").toggle_popup(vim.bo.filetype)
    end,
  },
  {
    name = "UserCacheReset",
    fn = function()
      require("user.utils.hooks").reset_cache()
    end,
  },
  {
    name = "UserReload",
    fn = function()
      require("user"):reload()
    end,
  },
  {
    name = "UserSyncCorePlugins",
    fn = function()
      require("user.plugin-loader").sync_core_plugins()
    end,
  },
}

function M.load(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

return M
