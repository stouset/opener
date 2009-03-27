c4("English Opening") do
  self * 161516 + 37.7 - 29.5
  
  g6 do
    self * 12331 + 33.2 - 32.9
    
    Nc3 { self * 6164 + 31.8 - 35.2 }.Bg7
    g3  { self * 2896 + 32.1 - 33.3 }.Bg7
    d4  { self * 1633 + 40.2 - 27.3 }.Bg7
    Nf3 { self *  855 + 30.5 - 33.7 }.Bg7
    e4  { self *  726 + 37.2 - 22.6 }.Bg7
    
    e4.e5(:"Adorjan Defense").d4.Nf6.dxe5.Nxe4.Bd3.Nc5 | '∞'
  end
  
  f5(:"Anglo-Dutch Defense") * 6235 + 38.6 - 31.8
  b5(:"Jaenisch Gambit")     *   47 + 38.3 - 46.8
  d5                         *  420 + 58.6 - 26.2
  g5                         *  102 + 43.1 - 37.3
  
  f5.Nf3.Nf6.g3.g6.Bg2.Bg7.O_O.O_O | '∞'
  d5.cxd5.Qxd5.Nc3.Qa5             | '+/='
  b5.cxb5.a6.bxa6.Bxa6             | '+/='
  g5.d4.Bg7.Nc3.h6.e4              | '+/='
end