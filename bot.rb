require 'json'
require 'pp'
require 'open-uri'
#@ rb_sysopen
json = JSON.load(URI.open("https://raw.githubusercontent.com/adatechschool/Projets/master/robot_de_conversation/recipes.json"))
#json = File.read("recipes.json")
#object = JSON.parse(json)

puts "Comment tu t'appelles ?"
name = gets.chomp.capitalize
puts "Salut a toi #{name}"
count = 0
#puts object[1]["recipe_name"]


while count == 0 do
  puts "Quels sont tes ingredients, #{name} ? Mets des virgules entre chaque ingredient !"
  ingredient_frigo = gets.chomp.capitalize.split(",")
  ingredient_frigo.each do |ingredient|
    json.each do |recette|
      if recette["ingredients"].include?ingredient
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

puts "Alors #{name}, que souhaites-tu cuisiner ?"
choix = gets.chomp.capitalize
json.each do |recette|
  if recette["recipe_name"].include?choix
    puts "C'est parti ! Tu auras besoin de :"
    recette["ingredients"].each do |key, value|
      puts value.to_s + " de " + key.to_s
    end
    puts "Voilà les étapes à suivre : "
    recette["steps"].each do |value|
      puts value
    end
    #print recette["ingredients"].split(",")
  end
end
