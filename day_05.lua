--

local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_05\input.txt]]
--^ input stuff

local function day_05(part_b)
  local cnt, stacks, re_crate, do_move, to_move  = 0, {}, '[%[%s](.)[%]%s]%s?'
  for l in io.lines(input)do
    cnt = cnt + 1
    if not l:find'%S'then
       do_move = true
       for i=1,#stacks do
         stacks[i] = stacks[i]:reverse()
       end
    elseif not do_move and l:find(re_crate)then
      local nstack = 0
      l:gsub(re_crate, function(c)
        nstack = nstack + 1
        if not stacks[nstack] then stacks[nstack] = '' end
        if c~=' ' and not c:find'%d'then
          stacks[nstack] = stacks[nstack] .. c
        end
      end)
    elseif l:find('move',1,true)then
      local n, from, to = l:lower():match'move%s*(%d+)%s*from%s*(%d+)%s*to%s*(%d+)'
      if not n then
        print('invalid:', l, cnt)
      end
      n, from, to = tonumber(n), tonumber(from), tonumber(to)
      if n > #stacks[from]then
        print('not enough to move:', n, from, to, cnt)
      elseif not stacks[from] or not stacks[to] then
        print('invalid stacks to move from or to:', n, from, to, cnt)
      elseif n>0 then
        to_move= part_b and stacks[from]:sub(-n) or
          stacks[from]:sub(-n):reverse()
        stacks[from] = stacks[from]:sub(1, -n-1)
        stacks[to] = stacks[to] .. to_move
      end
    end
  end
  local answer={}
  for i=1,#stacks do
    local s = stacks[i]
    answer[1+#answer] = s:sub(#s,#s)
  end
  return table.concat(answer)
end
local now = os.clock()
print('day 05a:',cnt, day_05())
print(os.clock()-now)

now = os.clock()
print('day 05b:',cnt, day_05(true))
print(os.clock()-now)
