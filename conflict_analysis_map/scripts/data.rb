require 'csv'
require 'json'

input_string = File.read("data/random10k_events_with_cities.tsv").force_encoding('MacRoman').encode('UTF-8'); nil
data = CSV.parse(input_string, {col_sep: "|", headers: true})

events_by_date = {}
data.each do |row|
  event = row.to_h
  event['lat'] = event['prim_lat_dec'].to_f
  event['long'] = event['prim_long_dec'].to_f
  date = Date.parse(event['sqldate'].to_s)
  if events_by_date[date]
    events_by_date[date] << event
  else
    events_by_date[date] = [event]
  end
end

events_by_date = events_by_date.sort.to_h
events_by_date.keys.each do |key|
  events_by_date[key.to_s] = events_by_date[key] # add entry for new key
  events_by_date.delete(key)                     # remove old key
end

events_by_date.each_pair do |date, events|
  File.open("json/events/#{date}.json","w") do |f|
    f.write(JSON.pretty_generate(events))
    f.close
  end
end
