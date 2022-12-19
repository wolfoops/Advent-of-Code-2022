--
local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_06\input.txt]]
--^ input stuff

-- note: buffer is a zero-based array, we don't need #buffer anyway
local function search(dcneed, buffer, bp, s, sp )
  if sp > #s then return 'no marker found'end --
  local shift, last
  for i=0, dcneed-1 do
    ep = (bp - i + dcneed) % dcneed
    last = buffer[ep]
    for j=i+1, dcneed-1 do
      ep = (bp - j + dcneed)% dcneed
      if i~=j and buffer[ep]==last then
        shift = dcneed - j - i
        if shift <1 then shift=1 end
        break
      end
    end
    if shift then break end
  end
  if not shift then return sp, s:sub(sp-dcneed+1, sp) end -- all distinct
  for j=1,shift do
    ep = (bp + j) % dcneed
    buffer[ep] = s:byte(sp+j)
  end
  bp = (bp + shift) % dcneed
  return search(dcneed, buffer, bp, s, sp+shift)
end

local function day_06(part_b)
  local dcneed = part_b and 14 or 4
  local s = io.open(input,'rb')
  s = s and s:read'*a', s and s:close()
  if #s<dcneed then print('too short to have a marker:'..#s) return end
  local buffer = {[0]=s:byte(1)}
  for i=1,dcneed-1 do buffer[i] = s:byte(i+1)end
  return search(dcneed, buffer, dcneed-1, s, dcneed)
end

local now = os.clock()
print('day 06a:',cnt, day_06())
print(os.clock()-now)

now = os.clock()
print('day 06b:',cnt, day_06(true))
print(os.clock()-now)



