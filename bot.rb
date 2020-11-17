require 'json'

=begin puts "Comment tu t'appelles ?"
name = gets.chomp
puts "Salut a toi #{name}"
=end

json = File.read('recipes.json')
object = JSON.parse(json)
puts object[1]["recipe_id"]



	