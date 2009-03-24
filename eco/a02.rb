f4('Bird\'s Opening') do
  self * 16573 + 35.5 - 40.0
  
  e5('From Gambit') do
    self * 1632 + 39.2 - 40.2
    
    fxe5.d6.exd6.Bxd6.Nf3 do
      g5('Lasker Variation')
      Nh6().d4('Lipke Variation')
      Nf6() | '∞'
    end
  end
  
  g5('Hobbs Gambit') * 18 + 50.0 - 27.8
  
  f5  { self * 301 + 43.9 - 27.6 | '∞' }.e4.fxe4.Nc3.Nf6.g4('Swiss Gambit')
  Nf6 { self * 2380 + 33.1 - 41.5 }.Nf3.g6.e3.Bg7.Be2.O_O | '='
  c5    * 1478 + 32.9 - 43.5
  g6    * 1220 + 28.0 - 44.4
  
  ~ e5.g4? # Fool's Mate
  ~ e5.e4  # King's Gambit
end
