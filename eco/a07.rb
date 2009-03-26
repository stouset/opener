Nf3().d5.g3("King's Indian Attack", :'Barcza System') do
  self * 17681 + 37.7 - 26.7
  
  c5(:"with ...c5") do
    self * 2258 + 40.2 - 29.3
    
    Bg2().Nc6.O_O.e6.d3.Nf6.Nbd2.Be7.e4.O_O.Re1(:"French Variation")
    Bg2().Nc6.O_O.e6.d3.Bd6.e4.Nge7  | '='
    Bg2().g6.O_O.Bg7.d3.Nf6.Nbd2.Nc6 | '='
    c4.Nf6.cxd5.Nxd5.Nc3.Nc6.Bg2.e6  | '='
  end
  
  g6 do
    self * 1309 + 32.2 - 27.5
    
    Bg2().Bg7.O_O.e5.d3.Ne7(:"Pachman System")
    Bg2().Bg7.O_O.Nf6.d3.O_O.Nbd2.Nc6 | '???' # http://en.wikibooks.org/wiki/Opening_theory_in_chess/1._Nf3/1...Nf6/2._g3
                                              # http://en.wikibooks.org/wiki/Opening_theory_in_chess/1._Nf3/1...d5/2._g3
  end
  
  c6  { self * 4208 + 31.5 - 26.1 }.Bg2.Bg4.O_O.Nd7.d3.e6.Nbd2.Bd6                        | '='
  Nf6 { self * 7424 + 40.4 - 24.5 }.Bg2.c6.O_O.Bg4(:"Yugoslav Variation").d3.Nbd7.Nbd2.e5 | '='
  Bg4 { self * 1773 + 31.6 - 28.9 }.Bg2.Nd7(:"Keres Variation").c4.c6.cxd5.cxd5.Nc3.Ngf6  | '='
  Nc6 { self * 1100 + 43.6 - 30.3 }.Bg2.e5.d3.Nf6.O_O.Be7.Bg5.Be6                         | '='
  
  c6.c4 # -> Nf3.d5.c4.c6.g3
end