class Card
  attr_accessor :rank, :suit

  def initialize rank, suit 
    if rank.is_a? Fixnum or rank.length == 1
      h = Hash[ "1" => "one", "2" => "two", "3" => "three", "4" => "four", "5" => "five", "6" => "six", "7" => "seven", "8" => "eight", "9" => "nine", "10" => "ten" ]
      @rank = h[rank.to_s].capitalize
    elsif rank.is_a? String
      @rank = rank.to_s.capitalize
    end

    @suit = suit.downcase.sub(/s$/,'').capitalize
  end

  def == another_card
    rank == another_card.rank && suit == another_card.suit
  end
  
  def > another_card
    numeric_value > another_card.numeric_value
  end
  
  def < another_card
    numeric_value < another_card.numeric_value
  end
  
  def equals? another_card
    numeric_value == another_card.numeric_value
  end 
  
  def numeric_value
    convert = Hash[
      'Two'   => 2,
      'Three' => 3,
      'Four'  => 4,
      'Five'  => 5,
      'Six'   => 6,
      'Seven' => 7,
      'Eight' => 8,
      'Nine'  => 9,
      'Ten'   => 10,
      'Jack'  => 11,
      'Queen' => 12,
      'King'  => 13,
      'Ace'   => 14,
    ]
    convert[rank]
  end

  def name
    "#{ rank } of #{ suit }s"
  end
  
  def inspect
    "<Card: \"#{ name }\">"
  end
  
  alias to_s name
  
  def self.parse name
    #r=/^([0-9]{1,2}|[A-Za-z]+) ?[Oo]f ?([Cc]lub|[Dd]iamond|[Hh]eart|[Ss]pade)s?$/
    r=/^(           # semi-pathological optimal regular set of expressions
      [0-9]{1,2}|   # Matches numeric limiting two place anchor OR
         [A-Za-z]+  # Matches greedy alpha case
    )[[:blank:]]?   # Optional single whitespace
    [Oo]f\s?(       # Filters optional spaced possesive preposition
      [Cc]lub|      # Matches cased alpha class card type
      [Dd]iamond|   # Optional plural or singular
      [Hh]eart|     # Classically composed by Stu and Darren
      [Ss]pade      # For the Lu1z!
    )*s?$/x
      r =~ name.to_s.sub(/^the()?/i, '').strip
    Card.new $1, $2
  end

  class << self
    alias [] parse
  end
end


=begin
    re=/ 
      ^([Tt]he|) ?(      # semi-pathological optimal regular set of expressions
         [0-9]{1,2}|     # Matches numeric limiting two place anchor OR
           [A-Za-z]+     # Matches greedy alpha case 
        ) ?[Oo]f ?(      # Filters optional spaced possesive preposition
     [Cc]lub|            # Matches cased alpha class card type
     [Dd]iamond|         # Optional plural or singular
     [Hh]eart|           # Optimised Regular Expressoion
     [Ss]pade*           # Classically composed by Stu and Darren
     )s?$                # For the Lu1z!
       /x
=end
