require 'contracts'

class Array
    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants
    @original_array_hash = 0

    invariant(self) {self.hash == @original_array_hash}

    Contract Num => Array
    def multithreaded_sort(duration)
        @original_array_hash = self.hash

        #self[0] = 10

        return []
    end

    def mergesort(q, r)

    end
end
