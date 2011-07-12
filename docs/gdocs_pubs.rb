# generate a list of publications from gdocs_pubs.yaml

require 'yaml'

pubs = YAML::load(File.open('gdocs_pubs.yml', 'r')) ; # .to_hash ;

## pubs.each_pair { |k, v| puts "\n#{k}: #{v}\n" unless v.empty? }

## pubs.each_pair { |k, v| puts "\n#{k}: #{v}\n" if v.has_value? }

# p pubs.methods

 p pubs ; puts

# pubs.each { |p| p p }

#pubs.select('doc') { |k, v| puts "\n#{k}: #{v}\n" }

## need to delete the 'chrome=true' bit to make
## at appear full-screen :)
