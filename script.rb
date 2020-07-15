class Game 
  attr_reader :code

  @@available_colors = ["red", "blue", "yellow", "green", "black", "white", "orange", "pink"]

  def initialize(code)
    @code = code
  end

  def self.random_color
    random_id = rand(@@available_colors.length)
    random_color = @@available_colors[random_id]

    random_color
  end

  def self.random_code
    random_code = []
  
    4.times {random_code << Game.random_color}

    random_code
  end

  def self.available_colors
    @@available_colors
  end

  def feedback(code_guess)  
    code_instances = Hash.new(0)
    @code.each {|color| code_instances[color] += 1}

    pegged = {}
    code_guess.each {|color| pegged[color] = 0}

    occuring_colors = []
    right_place_colors = []

    4.times do |i| 
      if @code[i] == code_guess[i]
        right_place_colors << code_guess[i]
        pegged[code_guess[i]] += 1
      end
    end

    4.times do |i|
      if ( @code[i] != code_guess[i] ) && ( @code.include?(code_guess[i]) ) && 
             (pegged[code_guess[i]] != code_instances[code_guess[i]])
        occuring_colors << code_guess[i]
        pegged[code_guess[i]] += 1
      end
    end


    puts "\n In the right place: #{right_place_colors.length} color(s)"
    puts " Occuring: #{occuring_colors.length} color(s)"
  end
end

def play 
  print "Who do you wanna play as?(code-breaker, code-maker): "; choice = gets.chomp
  case choice
    when "code-breaker"
      puts "\nAvailable colors: #{Game.available_colors.join(", ")}"
      game = Game.new(Game.random_code)

      9.times do |try|
        code_guess = []
        puts; puts "(Try #{try + 1})"; puts 
    
        print "Type 4 colors (seperate with dash): "; code_guess = gets.chomp
        code_guess = code_guess.split("-")
    
        game.feedback(code_guess)
    
        if code_guess == game.code
          return ( puts "\nYou win!" )
        elsif try == 8 && code_guess != game.code
          return ( puts "\nYou lost. The code was #{game.code}" )
        end
      end
    when "code-maker"
      puts "\nAvailable colors: #{Game.available_colors.join(", ")}"
      print "\nType in your code(4 colors, seperate with dash): "; code = gets.chomp
      code = code.split("-")

      game = Game.new(code)
      final_guess = ["", "", "", ""]
      
      9.times do |try|
        puts; puts "(Try #{try + 1})"; puts 
  
        puts "I'm guessing..."

        4.times { |i| final_guess[i] = Game.random_color unless final_guess[i] == game.code[i]}

        4.times { |i| final_guess[i] = game.code[i] if final_guess[i] == game.code[i]}
        
        puts "My final guess for now:  #{final_guess}"
        
        if final_guess == game.code
          return ( puts "\nI win!" )
        elsif try == 8 && final_guess != game.code
          return ( puts "\nI lost....................................................................." )
        end
      end
    else
      puts "Wrong input."
      play 
  end
end

play