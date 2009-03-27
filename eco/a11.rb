c4.c6(:"Caro-Kann Defensive System") do
  self * 11284 + 36.0 - 26.6
  
  e4  { self * 2654 + 42.3 - 20.2       }.d5
  d4  { self * 2273 + 34.0 - 25.9       }.d5
  Nc3 { self * 1797 + 32.7 - 36.2 | '=' }.d5
  g3  { self *  940 + 33.6 - 34.5       }.d5
  b3  { self *  293 + 34.8 - 27.3       }.d5
  
  ~ d4 # -> d4.c6.c4
  ~ e4 # -> e4.c6.c4
end