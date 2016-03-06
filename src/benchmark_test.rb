require 'benchmark'
require_relative 'assignment3_main.rb'

num_values = 1000
num_attempts = 3

randoms = []
num_values.times {randoms << rand(num_values)}

print "\n\n Sorting #{num_values} values using the built-in sort, #{num_attempts} attempts:\n\n"

Benchmark.bm(20, "Total:", "Average:") do |bm|
    attempts = []
    attempts << bm.report("Built-in - Trial #1") {randoms.sort}
    attempts << bm.report("Built-in - Trial #2") {randoms.sort}
    attempts << bm.report("Built-in - Trial #3") {randoms.sort}
    [attempts.reduce(:+), attempts.reduce(:+)/attempts.size.to_f]
end


print "\n\n Sorting #{num_values} values using our multithreaded (custom) mergesort, #{num_attempts} attempts:\n"

Benchmark.bm(20, "Total:", "Average:") do |bm|
    attempts = []
    attempts << bm.report("Multithreaded - Trial #1") {randoms.mergesort}
    attempts << bm.report("Multithreaded - Trial #2") {randoms.mergesort}
    attempts << bm.report("Multithreaded - Trial #3") {randoms.mergesort}
    [attempts.reduce(:+), attempts.reduce(:+)/attempts.size.to_f]
end
