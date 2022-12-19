local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_01\input.txt]]
--^ input stuff
local cnt, nth_elf, sorted = 0, 1, {{1,0}}
for l in io.lines(input)do
  local num = tonumber(l)
  if not num then
    nth_elf = nth_elf + 1
    sorted[nth_elf] = {nth_elf, 0}
  else
    local t = sorted[nth_elf]
    t[1+#t] = num
    t[2] = t[2] + num
  end
end
table.sort(sorted,function(a, b)return a[2]>b[2]end)
for i=1,20 do
  local e = sorted[i]
  print(i, table.unpack(e))
end
print('day 1a:',sorted[1][2])
print('day 1b:',sorted[1][2]+sorted[2][2]+sorted[3][2])
