-- Function to switch to the last buffer
local function switch_to_last_buffer()
    local last_buffer = vim.fn.bufnr("#")
    if vim.fn.buflisted(last_buffer) == 1 then
        vim.cmd("buffer " .. last_buffer)
    end
end

-- Auto command to switch to the last buffer when the current buffer is deleted
vim.cmd("autocmd BufDelete * lua switch_to_last_buffer()")
