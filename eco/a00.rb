b4('Polish (Sokolsky) Opening') do
  * 5622 + 37.2 - 39.1
  
  c6('Outflank Variation') { * 442 + 30.8 - 40.3 }
  Nh6('Tuebingen Variation')
  
  e5 do
    * 2236 + 35.7 - 40.0 | 24.3
     
    Bb2().Bxb4.Bxe5.Nf6 | '='
    a3.d5               | '='
    b5.d5               | '='
  end
  
  d5  { * 1270 + 31.8 - 40.0 }.Bb2.Nf6.e3.e6 | '='
  Nf6 { *  698 + 29.5 - 43.4 }.Bb2.e6        | '='
  e6  { *  489 + 33.3 - 41.1 }
end

g3('Benko\'s Opening') do
  * 16562 + 37.9 - 28.6
  
  h5('Lasker simul special')  { * 17 + 64.7 - 29.4 }
  
  e5 do
    * 2626 + 37.4 - 31.7
    
    Nf3('Reversed Alekhine') { * 49 + 40.8 - 34.7 }
    
    Bg2 { * 1724 + 36.3 - 33.4 }
    c4  { *  718 + 39.3 - 26.2 }
    d3  { *   66 + 39.4 - 37.9 }
  end
  
  d5  { * 5760 + 36.0 - 30.1 }.Bg2.Nf6.Nf3.c6.O_O.Bg4 | '='
  Nf6 { * 2895 + 40.8 - 26.4 }.Bg2.d5
  g6  { * 2706 + 38.0 - 25.5 }.Bg2.Bg7.e3.Nf6.Ne2.O_O.O_O.d5.d3.e5
  c5  { * 1533 + 35.7 - 28.6 }.Bg2
  
  ~ d5.Nf3.Nf6   # -> King's Indian Attack
  ~ Nf6().Nf3.d5 # -> King's Indian Attack
  ~ Nf6().c4.e5  # -> English
  ~ Nf6().Bg2.d5 # -> d5.Bg2.Nf6
  ~ g6.c4.Bg7    # -> English
  ~ Nf3().Nf6    # -> Nf3.g6.g3
end