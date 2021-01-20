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

tabRecettes.uniq!
tabRecettes.each do |num_recette|
  trouve_recette(json,num_recette,nomRecettes)
end

if nomRecettes.length >= 1
  puts "\nEt si on cuisinait un(e) "+nomRecettes[0]+" ?"
end
i = 0
until i==nomRecettes.length-1
  if nomRecettes.length > 1
    i= i+1
    puts "ou alors un(e) "+nomRecettes[i]+" ?"
  end
end


nombreRecettePossible=0
uniqueMatch=0
while uniqueMatch==0 do
  puts "\nAlors #{name}, quelle recette souhaites-tu cuisiner ?"
  nombreRecettePossible=0
  choix = gets.chomp.capitalize
  json.each do |recette|
    if (recette["recipe_name"].include?choix) && (nombreRecettePossible>0) && (recette["recipe_name"]!=choix) && (nomRecettes.include?(recette["recipe_name"]))
      nombreRecettePossible+=1
      puts "ou "+recette["recipe_name"]+"?"
    end
    if (recette["recipe_name"].include?choix) && (nombreRecettePossible==0) && (recette["recipe_name"]!=choix) && (nomRecettes.include?(recette["recipe_name"]))
      nombreRecettePossible+=1
      puts "\nTu veux dire "+recette["recipe_name"]+"?"
    end
    if (recette["recipe_name"]==choix) && (nomRecettes.include?(recette["recipe_name"]))
      uniqueMatch+=1
      puts "\nC'est parti ! Tu auras besoin de :"
      recette["ingredients"].each do |key, value|
        puts value.to_s + " de " + key.to_s
      end
      puts "\nVoilà les étapes à suivre : "
      recette["steps"].each do |value|
        puts value
      end
    end
  end
  if nombreRecettePossible==0
    puts "Je n'ai pas cette recette dsl"
  end
end
