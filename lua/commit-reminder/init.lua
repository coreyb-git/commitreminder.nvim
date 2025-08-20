local config = require("commit-reminder.config")

local M = {}

local function handle_callback(Returned)
	vim.schedule(function()
		local notifyopts = { title = "Commit Reminder", timeout = 2000 }
		vim.notify(Returned.stdout, vim.log.levels.INFO, notifyopts)
	end)
end

function M.setup(opts)
	for i, v in pairs(opts) do
		config[i] = v
	end

	if config.enabled then
		local format = "--format=%s%n%n%cr"
		vim.system({ "git", "log", "-1", format }, {}, handle_callback)
	end
end

return M
