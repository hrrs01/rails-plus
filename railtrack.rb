class Railtrack

	RAILS={
		'|'=>:north,
		'-'=>:east,
		'/'=>:northeast,
		'\\'=>:northwest
	}
	
	FUNCTIONS={
		'o'=>[:print],
		'i'=>[:input],
		'0'=>[:digit, 0],'1'=>[:digit, 1],'2'=>[:digit, 2],'3'=>[:digit, 3],'4'=>[:digit, 4],'5'=>[:digit, 5],'6'=>[:digit, 6],'7'=>[:digit, 7],'8'=>[:digit, 8],'9'=>[:digit, 9],
		'e'=>[:base]
		
	}
	
	def initialize filename
		@code = []
		@px = -1
		@py = -1
		@direction = :se
		code_to_array filename
		@char = ""
	
	end
	
	def code_to_array filename
		@code = File.readlines(filename)
		@code=@code.map{|x|x.chomp.chars}
		
		
	end
	
	
	
	def move_train
		case @direction
			when :se
				@px += 1
				@py += 1
			when :sw
				@px -= 1
				@py += 1
			when :ne
				@px += 1
				@py -= 1
			when :nw
				@py -= 1
				@px -= 1
			when :w
				@px -= 1
			when :e
				@px += 1
			when :n
				@py -= 1
			when :s
				@py += 1
		end
		
		begin
			@char = @code[@py][@px]
			p @char
			if @char==nil || @char==""
				return "Your train fell off a cliff."
			end
			if @char == " "
				return "Your train slipped of the rails!"
			elsif RAILS.include? @char
				return change_movement
			elsif FUNCTIONS.include? @char
				return FUNCTIONS[@char]
			else
				return "Unknown Character!"
			end
		rescue IndexError
			return "Your train fell off a cliff."
		end
	end
	
	def change_movement
		case RAILS[@char]
			when :north
				if @direction.to_s.include? "s"
					@direction=:s
				elsif @direction.to_s.include? "n"
					@direction=:n
				elsif @direction==:e || @direction==:e
					return "You suddenly stopped, because of rails."
				end
				return [:pass]
			when :east
				if @direction.to_s.include? "e"
					@direction=:e
				elsif @direction.to_s.include? "w"
					@direction=:w
				elsif @direction==:s || @direction == :n
					return "You suddenly stopped, because of rails."
				end
				return [:pass]
			when :northwest
				if @direction==:w || @direction==:n
					@direction=:nw
				elsif @direction==:e || @direction==:s
					@direction=:se
				elsif @direction==:ne || @direction==:sw
					return "You suddenly stopped, because of rails."
				end
				return [:pass]
			when :northeast
				if @direction==:e || @direction==:n
					@direction=:ne
				elsif @direction==:s || @direction==:w
					@direction=:sw
				elsif @direction==:se || @direction==:nw
					return "You suddenly stopped, because of rails."
				end
				return [:pass]
		end
	end
	
	def return_drawing
		
	end
	
	
end

r = Railtrack.new $*[0]
x=r.move_train
while !x.is_a?(String)
	p x
	x=r.move_train
end
p x