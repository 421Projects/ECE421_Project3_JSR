require "test/unit"
require_relative "assignment3_main.rb"

class ArrayMultiThreadSortTest < Test::Unit::TestCase

    def large_time
        99999
    end

    def test_has_functionality
        assert([].respond_to?:multithreaded_sort)
    end

    def test_array_inplace?
        arr = [19,21,9,1,45]
        arr.multithreaded_sort(large_time)
        assert_equal(arr, [19,21,9,1,45], "Original Array has changed.")
    end

    def test_returns_array
        result = [].multithreaded_sort(large_time)
        assert(result.is_a?(Array), "Returned object is not an Array.")
    end

    def test_empty_array
        arr = []
        assert_equal(arr.multithreaded_sort(large_time), [], "Array not sorted properly.")
    end

    def test_no_duration
        assert_raise ParamContractError do
            [].multithreaded_sort
        end
    end

    def test_bad_duration
        assert_raise ParamContractError do
            [].multithreaded_sort(0)
        end
        assert_raise ParamContractError do
            [].multithreaded_sort(-99999999)
        end
        assert_raise ParamContractError do
            [].multithreaded_sort("asd")
        end
        assert_raise ParamContractError do
            [].multithreaded_sort([])
        end
        assert_raise ParamContractError do
            [].multithreaded_sort(Hash.new)
        end
    end

    def test_bad_array
        assert_raise ArgumentError do
            [nil,nil,3,12].multithreaded_sort(large_time)
        end
        assert_raise ArgumentError do
            [3,12,"asd"].multithreaded_sort(large_time)
        end
        assert_raise ArgumentError do
            [nil,3,12,"Abc"].multithreaded_sort(large_time)
        end
    end

    def test_bad_array_and_duration
        assert_raise ParamContractError do
            [nil,nil,3,12].multithreaded_sort(0)
        end
        assert_raise ParamContractError do
            [3,12,"asd"].multithreaded_sort(-9999999)
        end
        assert_raise ParamContractError do
            [nil,3,12,"Abc"].multithreaded_sort("time")
        end
    end

    def test_object_repeated
        arr = [1,2,1]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't handle repeated values.")

        arr = [838923,1098123,838923,290834,1293804,838923]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't handle repeated values.")

        arr = ["a","asdasd","a"]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't handle repeated values.")

        arr = ["a98Y(*H)","rep","IJ(J)(J)asdasd","rep","a()JC(DPOJC*J$)","rep","rep"]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't handle repeated values.")
    end

    def test_already_ordered
        arr = [1,2,3,4,5]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already sorted values.")

        arr = [189234,20912,309273]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already sorted values.")

        arr = ["a","b","c"]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already sorted values.")

        arr = ["aaaa21sdxwc","aaa32dfcew","ze2ssaxc","zzsd2d"]
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already sorted values.")
    end

    def test_already_ordered_but_reversed
        arr = [1,2,3,4,5]
        arr.reverse!
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already reverse sorted values.")

        arr = [189234,20912,309273]
        arr.reverse!
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already reverse sorted values.")

        arr = ["a","b","c"]
        arr.reverse!
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already reverse sorted values.")

        arr = ["aaaa21sdxwc","aaa32dfcew","ze2ssaxc","zzsd2d"]
        arr.reverse!
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array doesn't already reverse sorted values.")
    end


    # test basic sorting capabilities
    def test_number_object
        small_pos = [1,15,99,2,49,12,33]
        large_pos = [1023124,19309182930,8030124,91928492834,102938901,9238409823094,12093]
        small_neg = [-3,-43,-123,-41,-1]
        large_neg = [-123129123,-12993849,-82348912,-73246814,-65234763524,-16253765]

        assert_equal(small_pos.sort, small_pos.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(large_pos.sort, large_pos.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(small_neg.sort, small_neg.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(large_neg.sort, large_neg.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        small_pos_with_dec = [1.812,15.8201,99.8123,2,49.82,12,33.910283]
        large_pos_with_dec = [10231.24,193091.82930,803012.4,9192849.2834,
                              10293.8901, 92384.09823094,1209.3]
        small_neg_with_dec = [-3.01290,-43.90123,-123.0812,-41.1092,-1.0912]
        large_neg_with_dec = [-1231.29123,-12.993849,-8234891.2,-7324.6814,
                              -652347.63524,-1625.3765]

        assert_equal(small_pos_with_dec.sort, small_pos_with_dec.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(large_pos_with_dec.sort, large_pos_with_dec.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(small_neg_with_dec.sort, small_neg_with_dec.multithreaded_sort(large_time),
                     "Array not sorted properly.")
        assert_equal(large_neg_with_dec.sort, large_neg_with_dec.multithreaded_sort(large_time),
                     "Array not sorted properly.")
    end

    def test_string_object
        small_words = ["asd","921","asdc","Asd","ASD(**(J)"]
        large_words = ["asd*(U(*HC(*H*98u8d9h2n89N(*H)","921)(SJ*HC(*HN@aposk9j)",
                       "asdc)(U@*HNOIDNonc)","AsdAP(SD()J@)","ASD(**(Japoskd9j2c902@)"]

        assert_equal(small_words.sort, small_words.multithreaded_sort(large_time))
        assert_equal(large_words.sort, large_words.multithreaded_sort(large_time))
    end

    def generate_random_number_array(min,max,step_size,elements)
        return (min..max).step(step_size).to_a.shuffle.take(elements)
    end

    def test_randomly_generated_numbers_positives_only
        # non decimals
        arr = generate_random_number_array(0,rand()*1000,1,2390)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(0,rand()*100,1,9929)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # decimals
        arr = generate_random_number_array(0,rand()*1000,rand(),100)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(0,rand()*100,rand(),10000)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")
    end

    def test_randomly_generated_numbers_negatives_only
        # non decimals
        arr = generate_random_number_array(-rand()*1000,0,1,2390)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(-rand()*100,0,1,9929)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # decimals
        arr = generate_random_number_array(-rand()*1000,0,rand(),100)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(-rand()*100,0,rand(),10000)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")
    end

    def test_randomly_generated_numbers_both
        # non decimals
        arr = generate_random_number_array(-rand()*483,rand()*823,1,2390)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(-rand()*983,rand()*398,1,9929)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # decimals
        arr = generate_random_number_array(-rand()*372,rand()*389,rand(),100)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")

        # large array
        arr = generate_random_number_array(-rand()*893,rand()*987,rand(),10000)
        assert_equal(arr.sort, arr.multithreaded_sort(large_time),
                     "Array not sorted properly.")
    end

    class DummyClass
        attr_accessor :var1, :var2
    end

    def test_custom_sort
        arr = ["as","pac2","ad2","43g","f3c","d3o3","asd"]

        sorted_array = arr.sort { |x,y|
            x[x.size-1].ord <=> y[y.size-1].ord
        }

        multithreaded_sorted_array = arr.multithreaded_sort(large_time) { |x,y|
            x[x.size-1].ord <=> y[y.size-1].ord
        }

        assert_equal(sorted_array, multithreaded_sorted_array,
                     "Custom criterion failed. Array not sorted properly.")

        arr = ["as","pac2","ad2","43g","f3c","d3o3","asd"]

        sorted_array = arr.sort { |x,y|
            y[y.size-1].ord <=> x[x.size-1].ord
        }

        multithreaded_sorted_array = arr.multithreaded_sort(large_time) { |x,y|
            y[y.size-1].ord <=> x[x.size-1].ord
        }

        assert_equal(sorted_array, multithreaded_sorted_array,
                     "Custom criterion failed. Array not sorted properly.")

    end

    def test_dummyObject1
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = [14713,83236]
        d2.var1, d2.var2 = [91240,21236]
        d3.var1, d3.var2 = [89202,12136]
        d4.var1, d4.var2 = [23814,23846]
        d5.var1, d5.var2 = [89237,12346]
        d6.var1, d6.var2 = [89492,20136]

        arr = [d1,d2,d3,d4,d5,d6]

        sorted_array = arr.sort { |x,y|
            x.send("var1") <=> y.send("var1")
        }

        multithreaded_sorted_array = arr.multithreaded_sort(large_time) { |x,y|
            x.send("var1") <=> y.send("var1")
        }

        assert_equal(sorted_array, multithreaded_sorted_array,
                     "Custom criterion with custom class failed. "\
                     "Array not sorted properly.")
    end

    def test_dummyObject2
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = [14.713,83.236]
        d2.var1, d2.var2 = [91.240,21.236]
        d3.var1, d3.var2 = [89.202,12.136]
        d4.var1, d4.var2 = [23.814,23.846]
        d5.var1, d5.var2 = [89.237,12.346]
        d6.var1, d6.var2 = [89.492,20.136]

        arr = [d1,d2,d3,d4,d5,d6]

        sorted_array = arr.sort { |x,y|
            x.send("var2") <=> y.send("var2")
        }

        multithreaded_sorted_array = arr.multithreaded_sort(large_time) { |x,y|
            x.send("var2") <=> y.send("var2")
        }

        assert_equal(sorted_array, multithreaded_sorted_array,
                     "Custom criterion with custom class failed. "\
                     "Array not sorted properly.")
    end

    def test_dummyObject3
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = ["14713","83236"]
        d2.var1, d2.var2 = ["91240","21236"]
        d3.var1, d3.var2 = ["89202","12136"]
        d4.var1, d4.var2 = ["23814","23846"]
        d5.var1, d5.var2 = ["89237","12346"]
        d6.var1, d6.var2 = ["89492","20136"]

        arr = [d1,d2,d3,d4,d5,d6]

        sorted_array = arr.sort { |x,y|
            x.send("var1") <=> y.send("var2")
        }

        multithreaded_sorted_array = arr.multithreaded_sort(large_time) { |x,y|
            x.send("var1") <=> y.send("var2")
        }

        assert_equal(sorted_array, multithreaded_sorted_array,
                     "Custom criterion with custom class failed. "\
                     "Array not sorted properly.")
    end



    def check_if_done_in_time(array_to_sort_and_time, &block)
        time_leeway = 0.5
        original_array = array_to_sort_and_time
        duration = rand() * 5

        if block_given?
            sorted_array = array_to_sort_and_time.sort {|x,y| block.call(x,y)}
        else
            sorted_array = array_to_sort_and_time.sort
        end

        if block_given?
            before_calling = Time.now
            result_array = array_to_sort_and_time.multithreaded_sort(duration){|x,y| block.call(x,y)}
            after_calling = Time.now
        else
            before_calling = Time.now
            result_array = array_to_sort_and_time.multithreaded_sort(duration)
            after_calling = Time.now
        end

        computation_time = after_calling - before_calling
        assert(computation_time <= duration + time_leeway, "Computation took too long.")
        if (original_array == result_array)
        # not sorted, time ran out, presumably
        else
            assert_equal(sorted_array, result_array)
        end

    end

    # test basic sorting capabilities
    def test_number_object_with_timing
        small_pos = [1,15,99,2,49,12,33]
        large_pos = [1023124,19309182930,8030124,91928492834,102938901,9238409823094,12093]
        small_neg = [-3,-43,-123,-41,-1]
        large_neg = [-123129123,-12993849,-82348912,-73246814,-65234763524,-16253765]
        small_pos_with_dec = [1.812,15.8201,99.8123,2,49.82,12,33.910283]
        large_pos_with_dec = [10231.24,193091.82930,803012.4,9192849.2834,
                              10293.8901, 92384.09823094,1209.3]
        small_neg_with_dec = [-3.01290,-43.90123,-123.0812,-41.1092,-1.0912]
        large_neg_with_dec = [-1231.29123,-12.993849,-8234891.2,-7324.6814,
                              -652347.63524,-1625.3765]
        arrs = [small_pos, large_pos, small_neg, large_neg,
                small_pos_with_dec, large_pos_with_dec, small_neg_with_dec,
                large_neg_with_dec]

        arrs.each {
            |arr|
            check_if_done_in_time(arr)
        }
    end

    def test_string_object_with_timing
        small_words = ["asd","921","asdc","Asd","ASD(**(J)"]
        large_words = ["asd*(U(*HC(*H*98u8d9h2n89N(*H)","921)(SJ*HC(*HN@aposk9j)",
                       "asdc)(U@*HNOIDNonc)","AsdAP(SD()J@)","ASD(**(Japoskd9j2c902@)"]

        arrs = [small_words, large_words]

        arrs.each {
            |arr|
            check_if_done_in_time(arr)
        }
    end

    def test_randomly_generated_numbers_positives_only_with_timing
        # non decimals
        arr1 = generate_random_number_array(0,rand()*1000,1,2390)

        # large array
        arr2 = generate_random_number_array(0,rand()*100,1,9929)

        # decimals
        arr3 = generate_random_number_array(0,rand()*1000,rand(),100)

        # large array
        arr4 = generate_random_number_array(0,rand()*100,rand(),10000)

        arrs = [arr1, arr2, arr3, arr4]
        arrs.each {
            |arr|
            check_if_done_in_time(arr)
        }
    end

    def test_randomly_generated_numbers_negatives_only_with_timing
        # non decimals
        arr1 = generate_random_number_array(-rand()*1000,0,1,2390)

        # large array
        arr2 = generate_random_number_array(-rand()*100,0,1,9929)

        # decimals
        arr3 = generate_random_number_array(-rand()*1000,0,rand(),100)

        # large array
        arr4 = generate_random_number_array(-rand()*100,0,rand(),10000)

        arrs = [arr1, arr2, arr3, arr4]
        arrs.each {
            |arr|
            check_if_done_in_time(arr)
        }
    end

    def test_randomly_generated_numbers_both_with_timing
        # non decimals
        arr1 = generate_random_number_array(-rand()*483,rand()*823,1,2390)

        # large array
        arr2 = generate_random_number_array(-rand()*983,rand()*398,1,9929)

        # decimals
        arr3 = generate_random_number_array(-rand()*372,rand()*389,rand(),100)

        # large array
        arr4 = generate_random_number_array(-rand()*893,rand()*987,rand(),10000)

        arrs = [arr1, arr2, arr3, arr4]
        arrs.each {
            |arr|
            check_if_done_in_time(arr)
        }
    end

    def test_custom_sort_with_timing
        arr = ["as","pac2","ad2","43g","f3c","d3o3","asd"]

        check_if_done_in_time(arr) { |x,y|
            x[x.size-1].ord <=> y[y.size-1].ord
        }

        arr = ["as","pac2","ad2","43g","f3c","d3o3","asd"]

        check_if_done_in_time(arr) { |x,y|
            y[y.size-1].ord <=> x[x.size-1].ord
        }
    end

    def test_dummyObject1_with_timing
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = [14713,83236]
        d2.var1, d2.var2 = [91240,21236]
        d3.var1, d3.var2 = [89202,12136]
        d4.var1, d4.var2 = [23814,23846]
        d5.var1, d5.var2 = [89237,12346]
        d6.var1, d6.var2 = [89492,20136]

        arr = [d1,d2,d3,d4,d5,d6]

        check_if_done_in_time(arr) { |x,y|
            x.send("var1") <=> y.send("var1")
        }
    end

    def test_dummyObject2_with_timing
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = [14.713,83.236]
        d2.var1, d2.var2 = [91.240,21.236]
        d3.var1, d3.var2 = [89.202,12.136]
        d4.var1, d4.var2 = [23.814,23.846]
        d5.var1, d5.var2 = [89.237,12.346]
        d6.var1, d6.var2 = [89.492,20.136]

        arr = [d1,d2,d3,d4,d5,d6]

        check_if_done_in_time(arr) { |x,y|
            x.send("var2") <=> y.send("var2")
        }

    end

    def test_dummyObject3_with_timing
        d1 = DummyClass.new
        d2 = DummyClass.new
        d3 = DummyClass.new
        d4 = DummyClass.new
        d5 = DummyClass.new
        d6 = DummyClass.new

        d1.var1, d1.var2 = ["14713","83236"]
        d2.var1, d2.var2 = ["91240","21236"]
        d3.var1, d3.var2 = ["89202","12136"]
        d4.var1, d4.var2 = ["23814","23846"]
        d5.var1, d5.var2 = ["89237","12346"]
        d6.var1, d6.var2 = ["89492","20136"]

        arr = [d1,d2,d3,d4,d5,d6]

        check_if_done_in_time(arr) { |x,y|
            x.send("var1") <=> y.send("var2")
        }
    end


end
