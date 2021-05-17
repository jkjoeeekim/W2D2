class Hangman
	DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
	
	def self.random_word
		DICTIONARY.sample
	end

	attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

	def initialize
		@secret_word = Hangman.random_word
		@guess_word = Array.new(@secret_word.length, '_')
		@attempted_chars = Array.new
		@remaining_incorrect_guesses = 5
	end

	def already_attempted?(char)
		attempted_chars.include?(char)
	end

	def get_matching_indices(char)
		indices = []
		@secret_word.chars.each.with_index { |ele, idx| indices << idx if ele == char }
		indices
	end

	def fill_indices(char, indices)
		indices.each { |idx| @guess_word[idx] = char }
	end

	def try_guess(char)
		if already_attempted?(char)
			print "that has already been attempted"
			return false
		else
			@attempted_chars << char
		end
		indices = get_matching_indices(char)
		if indices.empty?
			@remaining_incorrect_guesses -= 1
		else
			fill_indices(char, indices)
		end
		true
	end

	def ask_user_for_guess
		print "Enter a char:"
		char = gets.chomp
		try_guess(char)
	end

	def win?
		print 'WIN' if @secret_word.chars == guess_word
		@secret_word.chars == guess_word
	end

	def lose?
		print 'LOSE' if remaining_incorrect_guesses == 0
		remaining_incorrect_guesses == 0
	end

	def game_over?
		print "#{@secret_word}" if win? || lose?
		win? || lose?
	end
end
