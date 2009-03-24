b3('Nimzovich-Larsen Attack') do
  self * 10296 + 36.2 - 34.9
  
  e5('Modern Variation') do
    self * 4212 + 36.3 - 35.9
    
    Bb2 do
      self * 4070 + 36.8 - 35.3
      
      Nc6() { self * 2941 + 36.8 - 36.0 }.e3.Nf6.Bb5.Bd6.Ne2.a6.Bxc6.dxc6.d3.O_O.c4.Be6 | '='
      d6    { self * 1065 + 36.9 - 32.8 }.e3
    end
  end
  
  d5('Classical Variation') do
    self * 2757 + 34.1 - 36.5
    
    Bb2 do
      self * 2298 + 34.5 - 35.9
      
      c5 { self * 572 + 35.3 - 38.1 }.e3.Nc6.Bb5.Qc7.f4.a6.Bxc6.Qxc6.Nf3.Nf6.O_O.g6 | '='
      
      Nf6() * 606 + 35.0 - 33.7
      Bg4() * 408 + 27.7 - 40.0
      Bf5() * 265 + 35.1 - 37.4
      e6    * 161 + 34.8 - 36.0
    end
  end
  
  Nf6('Indian Variation') do
    self * 1729 + 36.3 - 33.2
    
    Bb2 do
      self * 1645 + 36.4 - 33.3
      
      g6 * 703 + 33.9 - 33.1
      e6 * 385 + 39.0 - 29.4
      d6 * 131 + 31.3 - 36.6
      d5 * 286
    end
  end
  
  f5('Dutch Variation') { self * 155 + 32.9 - 40.6 }.Nf3
  b5('Polish Variation')       *  18 + 38.9 - 38.9
  b6('Symmetrical Variation')  * 232 + 36.6 - 24.1
  c5('English Variation')      * 546 + 40.7 - 33.7
  
  ~ e5.c4        # c4.e5.b3
  ~ d5.Nf3       # Reti Opening
  ~ Nf6().Bb2.d5 # d5.Bb2.Nf6
end
