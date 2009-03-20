b4('Polish Opening, Sokolsky Opening') do
  self * 5622 + 37.2 - 39.1
  
  c6('Outflank Variation') * 442 + 30.8 - 40.3
  Nh6('Tuebingen Variation')
  
  e5 do
    self * 2236 + 35.7 - 40.0
     
    Bb2().Bxb4.Bxe5.Nf6 | '='
    a3.d5               | '='
    b5.d5               | '='
  end
  
  d5  { self * 1270 + 31.8 - 40.0 }.Bb2.Nf6.e3.e6 | '='
  Nf6 { self *  698 + 29.5 - 43.4 }.Bb2.e6        | '='
  e6  { self *  489 + 33.3 - 41.1 }
end

g3('Benko\'s Opening') do
  self * 16562 + 37.9 - 28.6
  
  h5('Lasker Simul Special') * 17 + 64.7 - 29.4
  
  e5 do
    self * 2626 + 37.4 - 31.7
    
    Nf3('Reversed Alekhine') * 49 + 40.8 - 34.7
    
    Bg2 { self * 1724 + 36.3 - 33.4 }
    c4  { self *  718 + 39.3 - 26.2 }
    d3  { self *   66 + 39.4 - 37.9 }
  end
  
  d5  { self * 5760 + 36.0 - 30.1 }.Bg2.Nf6.Nf3.c6.O_O.Bg4 | '='
  Nf6 { self * 2895 + 40.8 - 26.4 }.Bg2.d5
  g6  { self * 2706 + 38.0 - 25.5 }.Bg2.Bg7.e3.Nf6.Ne2.O_O.O_O.d5.d3.e5
  c5  { self * 1533 + 35.7 - 28.6 }.Bg2
  
  ~ d5.Nf3.Nf6   # -> King's Indian Attack
  ~ Nf6().Nf3.d5 # -> King's Indian Attack
  ~ Nf6().c4.e5  # -> English
  ~ Nf6().Bg2.d5 # -> d5.Bg2.Nf6
  ~ g6.c4.Bg7    # -> English
  ~ g6.Nf3.Nf6    # -> Nf3.g6.g3
end

g4('Grob\'s Attack') do
  self * 755 + 37.6 - 44.8
  
  d5 do
    self * 451 + 36.1 - 45.5
    
    Bg2().c6.g5('Spike Attack')
    Bg2().c6.h3.e5.d4.e4.c4.Bd6     | '=/+'
    Bg2().Bxg4?.c4('Fritz Gambit').d4('Romford Counter-Gambit')
    Bg2().Bxg4?.c4.c6.cxd5.cxd5.Qb3 | '+/='
  end
  
  e5 do
    self * 173 + 36.4 - 47.4
    
    d3.d5.Bg2.Nc6.h3.Nge7   | '=/+'
    f4?.Qh4('Fool\'s Mate') | '1-0'
  end
end

h3('Clemenz Opening, Mead\'s Opening, Basman\'s Opening, de Klerk\'s Opening') do
  self * 184 + 31.0 - 42.9
  
  e5 { self * 52 + 28.8 - 44.2 }.a3('Global Opening')
  d5 * 46 + 32.6 - 50.0
  c5 * 29 + 31.0 - 44.8
end

Nh3('Amar Opening, Paris Opening') do
  self * 94 + 25.5 - 44.7
  
  d5 { self * 36 + 25.0 - 41.7 }.g3.e5.f4.Bxh3.Bxh3.exf4('Amar Gambit')
  e5 { self * 25 + 28.0 - 56.0 }.g3
end

Nc3('Dunst Opening, Sleipner Opening, Heinrichsen Opening') do
  self * 7542 + 38.6 - 35.3
  
  e5.a3('Battambang Opening')
  c5.d4.cxd4.Qxd4.Nc6.Qh4('Novosibirsk Opening')
  
  d5 { self * 2669 + 36.3 - 35.7 }.e4 do
    d4   { self * 1566 + 40.2 - 40.7 }.Nce2
    dxe4 { self * 1467 + 36.5 - 34.3 }.Nxe4.Bf5.Ng3.Bg6 | '='
    
    e6    * 453 + 33.1 - 34.9
    c6    * 342 + 32.2 - 37.4
    Nf6() * 342 + 38.6 - 37.1
  end
  
  e5 { self *  892 + 50.4 - 28.6 }.Nf3.Nc6.d4.exd4.Nxd4.Nf6 | '='
  
  c5    * 1777 + 31.6 - 41.9
  Nf6() * 1016 + 45.0 - 31.2
  g6    *  470 + 37.2 - 36.6
  e6    *  302 + 38.4 - 32.8
  
  ~ d5.d4  # -> d4.d5.Nc3
  ~ d5.e4  # -> e4.d5.Nc3
  ~ c5.e4  # -> e4.c5.Nc3
  ~ c5.Nf3 # -> Nf3.c5.Nc3
  ~ e5.e4  # -> e4.e5.Nc3
end