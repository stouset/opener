Nf3('Réti Opening') do
  self * 194560 + 37.4 - 27.0
  
  f5('Réti v Dutch') do
    self * 6545 + 40.8 - 29.0
    
    e4(:'Pirc-Lisitsin Gambit') { self * 589 + 44.8 - 33.1 }.fxe4.Ng5.Nf6 | '='
    
    d3 { self * 569 + 43.6 - 27.1 }.Nf6.e4(:'Lisitsin Gambit Deferred')
    
    g3 * 2168 + 41.1 - 25.4
    d4 * 1614 + 38.0 - 31.2
    c4 * 1039 + 41.2 - 29.4
  end
  
  c5 do
    self * 22701 + 34.3 - 29.8
    
    g3 { self *  5924 + 33.7 - 34.0 | '=' }.Nc6.Bg2.g6
    b3        *  1247 + 32.7 - 33.5 | '='
    d4        *   217 + 28.1 - 47.0 | '='
    c4        * 11956 + 34.6 - 26.1
    e4        *  2244
  end
  
  d6 do
    self * 6436 + 38.1 - 30.0
    
    e4.Bg4(:'Wade Defense')
    d4.Bg4 | '='
  end
  
  g5(:'Herrstroem Gambit') * 13 + 46.2 - 46.2
  
  g6 * 10823 + 35.4 - 30.9
  e6 *  4504 + 43.6 - 26.8
  
  ~ c5.c4    # -> English Opening - Symmetrical Variation
  ~ c5.e4    # -> Sicilian Defence
  ~ g6.d4    # -> King's Indian
  ~ g6.c4    # -> English
  ~ g6.e4    # -> Sicilian
  ~ g6.g3    # -> King's Indian Attack
  ~ f5.d4    # -> Dutch Defence
  ~ f5.e4.e5 # -> Latvian Gambit
end
