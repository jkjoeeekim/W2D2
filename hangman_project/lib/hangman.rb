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
end
