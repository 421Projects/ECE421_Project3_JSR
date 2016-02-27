require 'contracts'

class Array
    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    # invariant stuff
    @original_array_hash = 0
    @original_duration_hash = 0
    @duration = 0

    invariant(self) {self.hash == @original_array_hash}
    invariant(@duration) {@duration.hash == @original_duration_hash}

    def precondition_block_check(&block)
        raise ArgumentError, "Block doesn't accept two arguments." unless
            block.arity == 2
        b = Proc.new do
            #|x,y| x<=>y
            |x,y|
            block.call(x,y)
        end

        # ensure that the return values are acceptable
        acceptable_return_values = [-1,0,1]
        raise ArgumentError, "Block return value incorrect." unless
            acceptable_return_values.member?(b.call(1,1))
        raise ArgumentError, "Block return value incorrect." unless
            acceptable_return_values.member?(b.call(2,1))
        raise ArgumentError, "Block return value incorrect." unless
            acceptable_return_values.member?(b.call(1,2))

        # ensure that each of the three different cases
        # returns a different value
        raise ArgumentError, "Block return value incorrect." unless
            [b.call(1,1), b.call(2,1), b.call(1,2)].uniq.size == 3
    end

    Contract Contracts::Pos, Maybe[Proc] => Array
    def multithreaded_sort(duration, &block)
        precondition_block_check(&block) if block != nil
        @duration = duration
        @original_array_hash = self.hash
        @original_duration_hash = @duration.hash

        # use @duration instead of duration from this point on
        # and don't change the above lines

        #self[0] = 10
        #@duration = 1

        return []
    end

    def mergesort(q, r)

    end
end
