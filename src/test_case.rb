require_relative 'assignment3_main.rb'

num_values = 1000
h = []
num_values.times {h << rand(num_values)}

h.multithreaded_sort(0.001)
h.multithreaded_sort(0.01)
h.multithreaded_sort(1)
h.multithreaded_sort(1.5)

h.multithreaded_sort(2)
puts "\nSuccessfully sorted #{num_values} values using a 2 second timeout."
h.multithreaded_sort(10)
puts "\nSuccessfully sorted #{num_values} values using a 10 second timeout."