require 'contracts'
require 'timeout'

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
                # else
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

        begin 
            Timeout::timeout(@duration) {mergesort}
        rescue Timeout::Error
            puts "#{@duration} second(s) have elapsed. Timeout! Safely exiting and terminating all threads."
            Thread.list.each {|t| t.kill if t != Thread.current}
        rescue ThreadError
            puts "A thread has encountered an error. Safely exiting and terminating all threads."
            Thread.list.each {|t| t.kill if t != Thread.current}
        end

    end

    
    def mergesort()
        return self if self.size <= 1
        
        threads = []
        threads << Thread.new {self[0...(self.size / 2)].mergesort}
        threads << Thread.new {self[(self.size / 2)...self.size].mergesort}

        threads.each(&:join)
        return merge(threads[0].value, threads[1].value)
    end

    
    def merge(left, right)
        # Assumes #left and #right are already sorted in ascending order.
        # Returns a sorted array containing all elements (merged) of #left and #right.
        
        # Return immediately if either array is empty.
        return left if right.empty?
        return right if left.empty?
        
        # If each array only contains one element, merge them manually.
        if left.size == 1 and right.size == 1
            return [[left[0], right[0]].min, [left[0], right[0]].max]
        end
        
        # If #left has only one element, find its appropriate position in #right and merge.
        if left.size == 1
            return left.concat(right) if left[0] <= right[0]
            return right.concat(left) if left[0] >= right[-1]
            right.each_with_index {|x, i| return right[0...i].concat(left).concat(right[i...right.size]) if left[0] <= x}
        end
        
        # If #right has only one element, do the above.
        if right.size == 1
            return merge(right, left)
        end
        
        # Optimization: Since #left and #right are sorted, if their last and first elements are sequential, combine them.
        return left.concat(right) if left.last <= right.first
        return right.concat(left) if right.last <= left.first
        
        # Swap the argument order to keep the larger array as the first argument.
        merge(right, left) if right.size > left.size
                
        # Find index in #left such that #left[i] <= center_of_#right <= #left[i+1] using binary search; return otherwise.
        lpivot = left.size/2
        rpivot = custom_binsearch(right, left[lpivot])
        
        # Split the work of merging using the pivots; merge half on one thread, and half on another, then combine the results.
        tl = Thread.new {merge(left.take(lpivot), right.take(rpivot+1))}
        tr = Thread.new {merge(left.drop(lpivot), right.drop(rpivot+1))}
        
        return tl.value + tr.value
    end
        

    private def custom_binsearch(arr, val)
        # Cistom Binary Search for MergeSort:
        # Finds index in #arr such that #arr[i] <= #val <= #arr[i+1];
        # Returns -1 or #arr.size if val is too small or too large, respectively.
    
        lower = 0
        upper = arr.size - 1

        while (upper >= lower)
            middle = (upper+lower)/2
            if val > arr[middle]
                lower = middle + 1
            elsif val < arr[middle]
                upper = middle - 1
            else
                return middle
            end
        end

        return upper
    end

end
