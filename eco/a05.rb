Nf3().Nf6 do
  self * 85267 + 36.8 - 25.5
  
  g3('King\'s Indian Attack') do
    self * 24810 + 35.2 - 27.9
    
    b5(:'Spassky\'s Variation') * 996 + 29.6 - 32.7
    
    g6 do
      self * 12173 + 35.6 - 26.8
      
      b4(:'Réti-Smyslov Variation')
    end
    
    b6 * 2519 + 33.6 - 25.5
    c5 * 1245 + 36.6 - 27.8
  end
  
  b3 * 3934 + 35.2 - 31.8 | '='
  e3 *  508 + 35.0 - 32.7 | '='
  
  ~ d4    * 11056 # -> Indian Defence
  ~ c4    * 43799 # -> English Opening
  ~ g3.d5 * 6279  # -> Nf3.d5.g3.Nf6
  ~ g3.g6.d4      # -> d4.Nf6.Nf3.g6.g3
  ~ g3.g6.c4      # -> c4.Nf6.Nf3.g6.g3
end
