require 'json'
json = File.read('recipes.json')
object = JSON.parse(json)
puts object[1]

puts "Comment tu t'appelles ?"
name = gets.chomp
puts "Salut a toi #{name}"
