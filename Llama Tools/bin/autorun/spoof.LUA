local function obfuscateCaption(c)
  if not c.Caption then return end

  local homoglyphs = {
    ["a"] = "а",
    ["b"] = "Ь",
    ["c"] = "с",
    ["d"] = "ԁ",
    ["e"] = "е",
    ["f"] = "f",
    ["g"] = "ɡ",
    ["h"] = "һ",
    ["i"] = "і",
    ["j"] = "ј",
    ["k"] = "к",
    ["l"] = "ӏ",
    ["m"] = "m",
    ["n"] = "п",
    ["o"] = "о",
    ["p"] = "р",
    ["q"] = "ԛ",
    ["r"] = "г",
    ["s"] = "ѕ",
    ["t"] = "т",
    ["u"] = "ц",
    ["v"] = "ѵ",
    ["w"] = "w",
    ["x"] = "х",
    ["y"] = "у",
    ["z"] = "z",
    ["A"] = "А",
    ["B"] = "В",
    ["C"] = "С",
    ["D"] = "D",
    ["E"] = "Е",
    ["F"] = "Ϝ",
    ["G"] = "Ԍ",
    ["H"] = "Н",
    ["I"] = "І",
    ["J"] = "Ј",
    ["K"] = "К",
    ["L"] = "Լ",
    ["M"] = "М",
    ["N"] = "Ν",
    ["O"] = "О",
    ["P"] = "Р",
    ["Q"] = "Q",
    ["R"] = "R",
    ["S"] = "Ѕ",
    ["T"] = "Т",
    ["U"] = "U",
    ["V"] = "Ѵ",
    ["W"] = "W",
    ["X"] = "Х",
    ["Y"] = "Υ",
    ["Z"] = "Z"
  }

  local obfuscatedCaption = ""
  for i = 1, #c.Caption do
    local char = c.Caption:sub(i, i)
    obfuscatedCaption = obfuscatedCaption .. (homoglyphs[char] or char)
  end

  c.Caption = obfuscatedCaption
end

local function applyObfuscationToComponents(c)
  if c.Component then
    for i = 0, c.ComponentCount - 1 do
      applyObfuscationToComponents(c.Component[i])
    end
  end

  obfuscateCaption(c)
end

for i = 0, getFormCount() - 1 do
  local form = getForm(i)
  applyObfuscationToComponents(form)
end

registerFormAddNotification(function(f)
  f.registerCreateCallback(applyObfuscationToComponents)
end)

