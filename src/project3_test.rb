require "test/unit"
require_relative "assignment3_main.rb"

class ArrayMultiThreadSortTest < Test::Unit::TestCase

    def test_has_functionality
        assert([].respond_to?:multithreaded_sort)
    end

    def test_array_inplace?
        arr = [19,21,9,1,45]
        arr.multithreaded_sort(100)
        assert_equal(arr, [19,21,9,1,45], "Original Array has changed.")
    end

    def test_returns_sorted
        arr = [19,21,9,1,45]
        assert_equal(arr.multithreaded_sort(100), [1,9,19,21,45], "Array not sorted properly.")
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

    end
end


