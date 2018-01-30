require'./railtrack.rb'

class Rails

	def initialize filename
		@stack = [0]
		@named_stack = {}
		@track = Railtrack.new filename
	end
	
	
	
	def run
		p "test"
		x = @track.move_train
		p x
		while !x.is_a? String
			p "1"
			case x[0]
				when :print
					p @stack.pop()
				
			
			end
			
			x=@track.move_train
		
		end
		
		
	end

end

r = Rails.new $*[0]
r.run