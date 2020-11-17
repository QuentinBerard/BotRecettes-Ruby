require 'json'

json = File.read('recipes.json')
object = JSON.parse(json)

puts "Comment tu t'appelles ?"
name = gets.chomp.capitalize
puts "Salut a toi #{name}"
count = 0
#puts object[1]["recipe_name"]


while count == 0 do
  puts "Quels sont tes ingredients, #{name} ?"
  ingredient_frigo = gets.chomp.capitalize
  object.each do |recette|
    recette["ingredients"].each do |ingredient_recette|
    #  puts ingredient_recette
      if ingredient_frigo.include?ingredient_recette.to_s
        count += 1
        if count==1
          puts "Et si on cuisinait un "+recette["recipe_name"]+" ?"
        end
        if count>1
          puts "ou alors un "+recette["recipe_name"]+" ?"
        end
      end
    end
    if count == 0
      puts "Déso, essayes un autre ingredient mon ptit pote !"
    end
  end
end
