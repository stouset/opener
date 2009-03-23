require 'pstore'
require 'memoize'

extend Memoizable

def pgn2epd(pgn)
  %x{echo "#{pgn}" | ./bin/pgn2epd 2>/dev/null}.tap do |epd|
    raise "Invalid move: #{pgn}" if epd =~ %r{\n.*\n}
    epd.chomp!
    epd.sub!(/(\w\d)$/, '-')
  end
end

memoize :pgn2epd, Memoizable::PStore.new('.epd.pstore')