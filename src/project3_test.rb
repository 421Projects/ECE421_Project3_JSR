require "test/unit"
require_relative "assignment3_main.rb"

class ArrayMultiThreadSortTest < Test::Unit::TestCase

    @large_time = 99999

    def test_has_functionality
        assert([].respond_to?:multithreaded_sort)
    end

    def test_array_inplace?
        arr = [19,21,9,1,45]
        arr.multithreaded_sort(100)
        assert_equal(arr, [19,21,9,1,45], "Original Array has changed.")
    end

    def test_returns_array
        assert([].multithreaded_sort(100).is_a? Array, "Returned object is not an Array.")
    end

    def test_empty_array
        arr = []
        assert_equal(arr.multithreaded_sort(100), [], "Array not sorted properly.")
    end

    def test_no_duration
        assert_raise ArgumentError do
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

    def test_object_repeated
        arr = [1,2,1]
        assert_equal(arr.sort, arr.multithreaded_sort(@large_time), "Array doesn't handle repeated values.")
        arr = ["a","asdasd","a"]
        assert_equal(arr.sort, arr.multithreaded_sort(@large_time), "Array doesn't handle repeated values.")
    end

    # test basic sorting capabilities
    def test_number_object
        small_pos = [1,15,99,2,49,12,33]
        large_pos = [1023124,19309182930,8030124,91928492834,102938901,9238409823094,12093]
        small_neg = [-3,-43,-123,-41,-1]
        large_neg = [-123129123,-12993849,-82348912,-73246814,-65234763524,-16253765]

        assert_equal(small_pos.sort, small_pos.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(large_pos.sort, large_pos.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(small_neg.sort, small_neg.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(large_neg.sort, large_neg.multithreaded_sort(@large_time), "Array not sorted properly.")

        small_pos_with_dec = [1.812,15.8201,99.8123,2,49.82,12,33.910283]
        large_pos_with_dec = [10231.24,193091.82930,803012.4,9192849.2834,10293.8901,92384.09823094,1209.3]
        small_neg_with_dec = [-3.01290,-43.90123,-123.0812,-41.1092,-1.0912]
        large_neg_with_dec = [-1231.29123,-12.993849,-8234891.2,-7324.6814,-652347.63524,-1625.3765]

        assert_equal(small_pos_with_dec.sort, small_pos_with_dec.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(large_pos_with_dec.sort, large_pos_with_dec.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(small_neg_with_dec.sort, small_neg_with_dec.multithreaded_sort(@large_time), "Array not sorted properly.")
        assert_equal(large_neg_with_dec.sort, large_neg_with_dec.multithreaded_sort(@large_time), "Array not sorted properly.")
    end

    def test_string_object
        small_words = ["asd","921","asdc","Asd","ASD(**(J@)"]
        large_words = ["asd*(U(*HC(*H@*98u8d9h2n89N(*H)","921)(SJ*HC(*HN@aposk9j)",
                       "asdc)(U@*HNOIDNonc)","AsdAP(SD()J@)","ASD(**(Japoskd9j2c902@)"]

        assert_equal(small_words.sort, small_words.multithreaded_sort(@large_time))
        assert_equal(large_words.sort, large_words.multithreaded_sort(@large_time))
    end

    class dummyClass
        attr_accessor :var1, :var2
        def new(var1, var2)
            @var1 = var1
            @var2 = var2
        end
    end

    def test_dummyObject
    end

end


