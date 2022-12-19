--

local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_04\input.txt]]
--^ input stuff

local cnt, sum1, sum2 = 0, 0, 0
-- part a
for l in io.lines(input)do
  cnt = cnt + 1
  local ll,lr, rl,rr = l:match'(%d+)%D+(%d+)%D+(%d+)%D+(%d+)'
  if not ll then
    print('Some line invalid:', l,  cnt)
  end
  ll, lr, rl, rr = tonumber(ll), tonumber(lr), tonumber(rl), tonumber(rr)
  if ll<=rl and lr>=rr or ll>=rl and lr<=rr then
    sum1 = sum1 + 1
    sum2 = sum2 + 1
  elseif lr>=rl and ll <= rr or rr>=ll and rl<=lr then
    sum2 = sum2 + 1
  end
end
print('day 03a:',cnt, sum1)
--- part b
print('day 03b:',cnt, sum2)
