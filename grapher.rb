require 'date'

# █████████████████████████
# █ ███ █     █  ████  ████
# █ ███ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █     █     █     █     █
# █████████████████████████

# 
# 
# 
# 
# 
# 
# 


# PATTERN = <<-EOF.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# X   XXX   XXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX
# XXX  X  XXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX
# XXXX   XXXXX     XXX      XX     XX     X      X
# XXX  X  XXXX  X  XX  XXX  X  XX  X    XXX   XXXX
# X   XXX   XX      X  XXX  X      XX     X   XXXX
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# EOF
#
#
# For some reason its easier for me to work with the X's
# than to work with the negative space
# X   X XXXX X   X X   X XXXX XXXXX X  X
# X  X  X    XX  X XX  X X      X   X  X
# XXX   XXXX X X X X X X XXXX   X   XXXX
# X  X  X    X  XX X  XX X      X   X  X
# X   X XXXX X   X X   X XXXX   X   X  X

# Converted to negative with 
# cat grapher.rb | tr "X" "Z" | tr " " "X" | tr "Z" " " 

PATTERN = <<-EOF.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
X XXX X    X XXX X XXX X    X     X XX X
X XX XX XXXX  XX X  XX X XXXXXX XXX XX X
X   XXX    X X X X X X X    XXX XXX    X
X XX XX XXXX XX  X XX  X XXXXXX XXX XX X
X XXX X    X XXX X XXX X    XXX XXX XX X
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EOF

MASK = PATTERN.split(//).map{|c| c == 'X'}

DAYSTART = Date.new(2019,05,19)
raise unless DAYSTART.wday == 0 # gotta be sunday
DAYEND   = DAYSTART + (PATTERN.size*13)
puts DAYEND
# uncomment the "return" if u want to check the end date.
#return
# def test_pattern
#   (0..6).map{|n| (PATTERN.split(//)*3).each_with_index{|c,i| print c if i%7==n}; print "\n"}
# end

dates = DAYSTART.upto( DAYEND ).to_a

def on?(date)
  delta = (date - DAYSTART).to_i
  MASK[ delta % MASK.size ]
end

commit_dates = []
dates.each do |date|
  if on?(date)
    19.times{|i| commit_dates << date.to_time + i*3600}
  end
end

str_commit_dates = commit_dates.map(&:to_s)

commit_dates.each do |date|
  puts date
  File.open('random_list_of_dates', 'w') { |f| f << str_commit_dates.shuffle.first(12).join("\n") }
  `GIT_AUTHOR_NAME="kxing28" GIT_AUTHOR_EMAIL="69891140+kxing28@users.noreply.github.com" GIT_AUTHOR_DATE="#{date}" GIT_COMMITTER_DATE="#{date}" git commit -am "#{date}"`
end
