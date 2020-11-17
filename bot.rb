require 'json'


json = File.read('recipes.json')
object = JSON.parse(json)

puts "Comment tu t'appelles ?"
name = gets.chomp
puts "Salut a toi #{name}"

#puts object[1]["recipe_name"]

puts "Quels sont tes ingredients, #{name} ?"
ingredient_frigo = gets.chomp.capitalize
puts ingredient_frigo

count = 0

object.each do |recette|
  if recette["ingredients"].include?ingredient_frigo
    count += 1
    puts "Et si on cuisinait un "+recette["recipe_name"]+" ?"
  end
end

if count == 0
  puts "Déso, essayes un autre ingredient mon ptit pote !"
end

# if object[0]["ingredients"].include?ingredient_frigo
#     puts "Et si on cuisinait un "+object[0]["recipe_name"]+"?"
#   else
#     puts "quoi ?"
# end
