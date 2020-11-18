require 'json'
require 'pp'

json = File.read('recipes.json')
object = JSON.parse(json)

puts "Comment tu t'appelles ?"
name = gets.chomp
puts "Salut a toi #{name}"
count = 0
#puts object[1]["recipe_name"]


while count == 0 do
  puts "Quels sont tes ingredients, #{name} ?"
  ingredient_frigo = gets.chomp.capitalize
  object.each do |recette|
    if recette["ingredients"].include?ingredient_frigo
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

puts "Alors #{name}, que souhaites-tu cuisiner ?"
choix = gets.chomp.capitalize
object.each do |recette|
  if recette["recipe_name"].include?choix
    puts "C'est parti ! Tu auras besoin de :"
    recette["ingredients"].each do |quantite|
      puts quantite.to_s
    end
    #print recette["ingredients"].split(",")
  end
end
