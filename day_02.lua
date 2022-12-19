local cloud_dir = os.getenv'CLOUD_DIR'
local input = cloud_dir..[[\celua\aoc2022\day_02\input.txt]]
--^ input stuff
-- part a
local round, total, scores, score, others, mine = 0, 0, {
  X = 1, Y=2, Z=3, -- score for my choice
  A = { X= 3, Y = 6, Z=0}, -- score for draw/win/lose
  B = { X= 0, Y = 3, Z=6},
  C = { X= 6, Y = 0, Z=3},
}
local function calcScore(others, mine)
  local score_choice = scores[mine]
  local score_winlose= scores[others] and scores[others][mine]
  if score_choice and score_winlose then
    return score_choice + score_winlose
  end
end
for l in io.lines(input)do
  round, others, mine = round+1, l:match'(%w)%s*(%w)'
  if others then
    round, score = round +1, calcScore(others, mine)
    if not score then
      print('invalid line:', round, l)
    end
    total = total + score
  end
end
print('day 2a:', total, round)
-- part b
local choices = {
A = {x='Z', y = 'X', z='Y'},
B = {x='X', y = 'Y', z='Z'},
C = {x='Y', y = 'Z', z='X'},
}
round, total = 0, 0
for l in io.lines(input)do
  round, others, mine = round+1, l:match'(%w)%s*(%w)'
  if others then
    local my_chioce = choices[others]
    my_chioce = my_chioce and my_chioce[mine:lower()]
    round, score = round +1, calcScore(others, my_chioce)
    if not score then
      print('invalid line:', round, l)
    end
    total = total + score
  end
end
print('day 2b:', total, round)
