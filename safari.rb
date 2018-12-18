# animal_safari

require 'pg'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "safari_vacation"
)

class SeenAnimal < ActiveRecord::Base
end

def json_print data
    puts JSON.pretty_generate(data.as_json)
end

SeenAnimal.create(species: "Lions", count_of_times_seen: "2", location_of_last_seen: "Desert")

SeenAnimal.create(species: "Tigers", count_of_times_seen: "3", location_of_last_seen: "Desert")

SeenAnimal.create(species: "Bears", count_of_times_seen: "5", location_of_last_seen: "Jungle")

puts "Welcome to the Jungle... We got..."

json_print SeenAnimal.all

puts " OH MY!"

SeenAnimal.find(3).update(count_of_times_seen: "8", location_of_last_seen: "Jungle")

puts "Here's the animals seen in the jungle..."
json_print SeenAnimal.where(location_of_last_seen: "Jungle")

SeenAnimal.where(location_of_last_seen: "Desert").delete_all

puts "Here is the total number of animals seen today..."

json_print SeenAnimal.sum("count_of_times_seen")

puts "Here's the count of Lions, Tigers, and Bears seen..."

json_print SeenAnimal.where(species: "Lions").or(SeenAnimal.where(species: "Tigers").or (SeenAnimal.where(species: "Bears"))).sum("count_of_times_seen")