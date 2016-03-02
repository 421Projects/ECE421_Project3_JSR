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

    def precondition_block_check(block)
        tmp_array = self.clone

        raise ArgumentError, "Block doesn't accept two arguments." unless
            block.arity == 2

        tmp_array.uniq!
        acceptable_return_values = [-1,0,1]
        tmp_array.combination(2).each { |comb|
            first = comb[0]
            sec = comb[1]

            begin
                # ensure that the return values are acceptable
                raise ArgumentError unless
                    acceptable_return_values.member?(block.call(first,sec))
                raise ArgumentError unless
                    acceptable_return_values.member?(block.call(sec,first))
                raise ArgumentError unless
                    acceptable_return_values.member?(block.call(first,first))
                raise ArgumentError unless
                    acceptable_return_values.member?(block.call(sec,sec))
            rescue
                raise ArgumentError, "Block couldn't properly sort these two elements: "\
                                     "#{first} and #{sec}"
            end

        }
    end

    def block_required?
        tmp_array = self.clone
        tmp_array.uniq!
        acceptable_return_values = [-1,0,1]
        tmp_array.combination(2).each { |comb|
            first = comb[0]
            sec = comb[1]

            begin
                next if acceptable_return_values.member?(first <=> sec) and
                    acceptable_return_values.member?((sec <=> first)) and
                    acceptable_return_values.member?((first <=> first)) and
                    acceptable_return_values.member?((sec <=> sec)) and
                    ((sec <=> sec) == (first <=> first)) and
                    [first <=> sec, sec <=> first, first <=> first].uniq.size == 3

                return true
            rescue
                return true
            end

        }
        return false
    end

    Contract Contracts::Pos, Maybe[Proc] => Array
    def multithreaded_sort(duration, &block)
        raise ArgumentError, "Block required." if (block_required?) and (block_given? == false)
        precondition_block_check(block) if block_given?

        @duration = duration
        @original_array_hash = self.hash
        @original_duration_hash = @duration.hash

        # use @duration instead of duration from this point on
        # and don't change the above lines

        return []
    end

    def mergesort(q, r)

    end
end
