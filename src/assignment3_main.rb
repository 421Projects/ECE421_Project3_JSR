require 'contracts'

class Array
		include Contracts::Core
  		include Contracts::Builtin

  		@old_hash

		Contract Num => Array
		def multithreaded_sort(duration)
			@old_hash = self.hash()

			self[0] = 10

			puts self
		end

		def mergesort(q, r)

		end
end
