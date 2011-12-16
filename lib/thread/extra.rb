#--
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'thread'

class RecursiveMutex < Mutex
	def initialize
		@recursive = Hash.new { |h, k| h[k] = 0 }

		super
	end

	def lock
		@recursive[Thread.current] += 1

		if @recursive[Thread.current] == 1
			super
		end
	end

	def unlock
		@recursive[Thread.current] -= 1

		if @recursive[Thread.current] == 0
			@recursive.delete(Thread.current)

			super
		end
	end
end
