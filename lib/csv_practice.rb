# csv_practice.rb
require 'csv'
require 'awesome_print'
require 'pry'

def load_data(filename) #take file name and returns data from file in array of hashes
data = CSV.open(filename,'r', headers:true).map do |line|
  line.to_h
  end
  return data
end

def total_medals_per_country(olympic_data)
  country_names = []
  olympic_data.each do |individual_data|
    country = individual_data["Team"]
    country_names << country
  end
  country_names = country_names.uniq
  country_hash = Hash[country_names.collect {|name|[name,[]]}] #{country_name=>[]}

  olympic_data.each do |individual_data|
      unless individual_data["Medal"] == "NA"
        country_hash[individual_data["Team"]] << individual_data["Medal"]
      end
  end
  country_hash.each do |k,v|
    country_hash[k] = v.length
  end
  medal_totals= []
  country_hash.each do |individual|
    medal_totals << {
      :country => individual[0],
      :total_medals => individual[1]
    }
    end
  return medal_totals
end

def save_medal_totals(filename, medal_totals)
  CSV.open(filename, 'w') do |csv|
    csv << medal_totals.first.keys
    medal_totals.each do |country|
      csv << country.values
    end
  end
end

def all_gold_medal_winners(olympic_data)
#loop through original data file
  individual_medal_winners_hash = {}
  gold_medal_winners = []
  olympic_data.each do |individual_data|
    if individual_data['Medal'] == 'Gold'
      individual_medal_winners_hash[individual_data['Name']] = individual_data['Medal']
    end
  end
  individual_medal_winners_hash.each do |k,v|
    gold_medal_winners << {"Name" => k , "Medal"=> v}
  end
  return gold_medal_winners
end

def medals_sorted_by_country(medal_totals)
medal_totals.sort_by do |item|
  item[:country]
  end
end

def country_with_most_medals(medal_totals)
  most_medals = medal_totals.max_by {|h| h[:total_medals].to_i} [:country]
  return most_medals
end

 def athlete_height_in_inches(olympic_data)
   change_height_to_inches = olympic_data.map {|h| (h["Height"].to_i * 0.394).round(2)}
   #returns an array of the new heights, how do i get those heights to go back into the original array of hashes with the rest of the athlete data
   return change_height_to_inches
 end
#go through sorted original data from load_data methods
#convert athlete heights from cm to inches
#return array of hshes with converted data
# end

# olympic_data = load_data('../data/test.csv')
# p athlete_height_in_inches(olympic_data)
#  medal_totals = total_medals_per_country(olympic_data)
#  p country_with_most_medals(medal_totals)
# # puts "What do you want to name your file?"
# filename = gets.chomp
# save_medal_totals(filename, medal_totals)
# p all_gold_medal_winners(olympic_data)
#return county with the most medals - use .max_by
# end
