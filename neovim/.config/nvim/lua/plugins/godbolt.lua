local function scope_function()
	local n = vim.treesitter.get_node()
	while n do
		local t = n:type()
		if t:find("function") or t:find("method") or t == "function_item" then
			break
		end
		n = n:parent()
	end
	if not n then
		return nil, nil
	end
	local sr, _, er, _ = n:range()
	return sr + 1, er + 1
end

local function scope_visual()
	local l1 = vim.fn.getpos("'<")[2]
	local l2 = vim.fn.getpos("'>")[2]
	if l1 == 0 or l2 == 0 then
		return nil, nil
	end
	if l1 > l2 then
		l1, l2 = l2, l1
	end
	return l1, l2
end

local function scope_buffer()
	return nil, nil -- wrapper treats this as “whole buffer”
end

local function ce_compile_live(line1, line2, args)
	local range = (line1 and line2) and ("%d,%d"):format(line1, line2) or "%"
	vim.cmd(("%sCECompile %s"):format(range, args or ""))
end

local function pick_arch(scope_fn)
	local compiler = ""

	if vim.bo.filetype == "rust" then
		local out = vim.fn.system("rustc --version")
		local v = out:match("^rustc%s+([0-9]+%.[0-9]+%.[0-9]+)")
		compiler = v and ("compiler=r" .. v:gsub("%.", "")) or ""
	end

	local items = {
		{ text = "x86_64 linux -O2", args = "flags=--target\\ x86_64-unknown-linux-gnu" },
		{ text = "aarch64 linux -O2", args = "flags=--target\\ aarch64-unknown-linux-gnu" },
		{ text = "aarch64 darwin -O2", args = "flags=--target\\ aarch64-apple-darwin" },
	}

	require("snacks").picker({
		title = "CE target/arch",
		items = items,
		format = "text",
		confirm = function(picker, item)
			picker:close()
			if not item then
				return
			end
			local l1, l2 = scope_fn()
			local args = compiler .. " " .. (item.args or "")
			ce_compile_live(l1, l2, args)
		end,
	})
end

return {
	"krady21/compiler-explorer.nvim",
	config = function()
		require("compiler-explorer").setup({
			url = "https://godbolt.org",
			line_match = {
				highlight = true,
				jump = true,
			},
		})
	end,
	keys = {
		{
			"<leader>xfa",
			function()
				pick_arch(scope_function)
			end,
			desc = "Godbolt arch: function",
		},
        -- {"K", ":CE
	},
}
