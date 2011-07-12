# generate a list of publications from gdocs_pubs.yaml

require 'yaml'

pubs = YAML::load(File.open('gdocs_pubs.yml', 'r')) ; # .to_hash ;

## pubs.each_pair { |k, v| puts "\n#{k}: #{v}\n" unless v.empty? }

## pubs.each_pair { |k, v| puts "\n#{k}: #{v}\n" if v.has_value? }

# p pubs.methods

 #p pubs ; puts

#pubs.each { |p| p p }

p pubs.class

puts "# Publications by #{pubs['author']}\n\n"

pubs.each_pair do |k,v|

  p k.class
  p v.class

  puts


end

## need to delete the 'chrome=true' bit to make
## at appear full-screen :)
