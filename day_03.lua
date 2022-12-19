--

local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_03\input.txt]]
--^ input stuff

local item2Priority = setmetatable({},{__index=function(me, c)-- quick memoize
  local n
  if c>='a' and c<='z'then
    n = c:byte()-('a'):byte()+1
  elseif c>='A' and c<='Z'then
    n = c:byte()-('A'):byte()+27
  end
  if n then
    me[c] = n
    return n
  end
end})

local cnt, sum, valid = 0, 0
-- part a
for l in io.lines(input)do
  cnt, valid = cnt + 1, l:match'%w+'
  if not valid or (#valid & 1) ~=0 then
    print('invalid', cnt, l)
  end
  local half_len, miss_placed = #valid >> 1
  local lhs, rhs = valid:sub(1,half_len), valid:sub(half_len+1)
  for c in lhs:gmatch'.'do
    if rhs:find(c,1,true)--[[plain text]]then
      miss_placed = c
      break
    end
  end
  if not miss_placed then
    print('Some line has no miss placed:', cnt )
  else
    sum = sum + item2Priority[miss_placed]
  end
end
print('day 03a:',cnt, sum)
--- part b
cnt, sum = 0,0
local thisGroup = {}
for l in io.lines(input)do
  cnt, thisGroup[1+#thisGroup] = cnt + 1, l:match'%w+'
  if #thisGroup==3 then
    local seen, badge = {}
    for c in thisGroup[1]:gmatch'.'do
      if not seen[c] and thisGroup[2]:find(c,1,true) and thisGroup[3]:find(c,1,true)then
        badge = c
        break
      else
        seen[c] = true
      end
    end
    if not badge then
      for c in thisGroup[2]:gmatch'.'do
        if not seen[c] and thisGroup[1]:find(c,1,true) and thisGroup[3]:find(c,1,true)then
          badge = c
          break
        else
          seen[c] = true
        end
      end
    end
    -- no need for 3rd group
    if not badge then
      print('no badge found for group:', (cnt//3), cnt)
    else
      sum = sum + item2Priority[badge]
    end
    thisGroup = {}
  end
end
if #thisGroup~=0 then
  print(#thisGroup..' elves is left in a grouping')
end
print('day 03b:',cnt, sum)
