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

        if tmp_array.uniq.empty?
            return
        elsif tmp_array.uniq.size >= 2
            raise ArgumentError, "Block doesn't accept two arguments." unless
                block.arity == 2

            tmp_array.uniq!
            acceptable_return_values = [-1,0,1]
            tmp_array.combination(2).each { |comb|
                first = comb[0]
                sec = comb[1]

                begin
                    # ensure that the return values are acceptable
                    raise ArgumentError, "Block return value incorrect." unless
                        acceptable_return_values.member?(block.call(first,sec))
                    raise ArgumentError, "Block return value incorrect." unless
                        acceptable_return_values.member?(block.call(sec,first))
                    raise ArgumentError, "Block return value incorrect." unless
                        acceptable_return_values.member?(block.call(first,first))
                    raise ArgumentError, "Block return value incorrect." unless
                        acceptable_return_values.member?(block.call(sec,sec))
                rescue
                    raise ArgumentError, "Block couldn't sort these two elements: "\
                                         "#{first} and #{sec}"
                end

            }
            # first = tmp_array[0]
            # sec = tmp_array[1]

            # first_val_class = first.class
            # tmp_array.each { |tmp|
            #     next if (tmp.is_a? first_val_class)
            #     sec = tmp
            # }

        end
    end

    def block_required?
        tmp_array = self.clone
        if tmp_array.empty? or tmp_array.uniq == nil or tmp_array.uniq.size == 1
            return false
        elsif tmp_array.uniq.size >= 2
            tmp_array.uniq!
            first = tmp_array[0]
            sec = tmp_array[1]

            first_val_class = first.class
            tmp_array.each { |tmp|
                next if (tmp.is_a? first_val_class)
                sec = tmp
            }

            # ensure that the return values are acceptable
            acceptable_return_values = [-1,0,1]

            if acceptable_return_values.member?(first <=> sec) and
              acceptable_return_values.member?((sec <=> first)) and
              acceptable_return_values.member?((first <=> first)) and
              acceptable_return_values.member?((sec <=> sec)) and
              ((sec <=> sec) == (first <=> first)) and
              [first <=> sec, sec <=> first, first <=> first].uniq.size == 3
                return false
            else
                return true
            end
        end
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

        #self[0] = 10
        #@duration = 1

        return []
    end

    def mergesort(q, r)

    end
end
