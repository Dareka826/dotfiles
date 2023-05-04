#!/usr/bin/env lua

local function read_num(prompt)
    while true do
        io.write(prompt) io.flush()
        local ret = tonumber(io.read("l"))
        if ret ~= nil then
            return ret
        end
    end
end

local function round2(num)
    return math.floor(num * 100) / 100
end

DISC_SIZE = 50000000000

local data_size = read_num("Data size (in bytes): ")

local disc_recv_percent = read_num("How much percent redundancy: ")
local data_size_rec = data_size * (1 + (disc_recv_percent / 100))

local num_discs = data_size_rec / DISC_SIZE
print("Min number of discs: " .. round2(num_discs) .. " -> " .. math.ceil(num_discs))
num_discs = math.ceil(num_discs)

local bkp_discs = read_num("How many extra discs: ")
local final_discs = num_discs + bkp_discs
local final_recv_percent = ((num_discs * DISC_SIZE) / data_size) - 1

print("Final num of discs/parts: " .. final_discs)
print("Final redundancy: " .. round2(final_recv_percent * 100) .. "%")
