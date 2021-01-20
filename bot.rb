require 'json'
require 'pp'
require 'open-uri'
#@ rb_sysopen
json = JSON.load(URI.open("https://raw.githubusercontent.com/QuentinBerard/BotRecettes-Ruby/main/recipes.json"))
#json = File.read("recipes.json")
#object = JSON.parse(json)


puts "Comment tu t'appelles ?"
name = gets.chomp.capitalize
puts "Salut a toi #{name}"
count = 0
#puts object[1]["recipe_name"]

tabRecettes= []
nomRecettes =[]

def trouve_recette(json,num_recette,nomRecettes)
  json.each do |recette|
    if num_recette == recette["recipe_id"]
      nomRecettes.push(recette["recipe_name"])
      return nomRecettes
    end
  end
end

while count == 0 do
  puts "Quels sont tes ingredients, #{name} ? Mets des virgules entre chaque ingredient !"
  ingredient_frigo = gets.chomp.split(",").map(&:strip).map(&:capitalize)
  #ingredient_frigo = ingredient_frigo.map(&:capitalize)

  print(ingredient_frigo)
  json.each do |recette|
    ingredient_frigo.each do |ingredient|
      if recette["ingredients"].include?ingredient
        count += 1
        tabRecettes.push(recette["recipe_id"])
      end
    end
  end
  if tabRecettes.length == 0
    puts "Déso, essayes un autre ingredient mon ptit pote !"
  end
end

print(tabRecettes)
tabRecettes.uniq!
tabRecettes.each do |num_recette|
  trouve_recette(json,num_recette,nomRecettes)
end

if nomRecettes.length >= 1
  puts "Et si on cuisinait un(e) "+nomRecettes[0]+" ?"
end
i = 0
until i==nomRecettes.length-1
  if nomRecettes.length > 1
    i= i+1
    puts "ou alors un(e) "+nomRecettes[i]+" ?"
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
