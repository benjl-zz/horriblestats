require 'backbone.rb'

params = {}

puts "Enter CSV filename for user data (required)"
params[:userdata] = gets.chomp

puts "Is ballot tabultion required? (y or n)"
ballotreq = gets.chomp
if ballotreq === "y"
	puts "Enter CSV filename for ballot data..."
	params[:ballotdata] = gets.chomp
else
	params[:ballotdata] = false
end

puts "Is promotion Canadian or American? (ca or us)"
country = gets.chomp
if country === "ca"
	params[:country] = "ca"
elsif country === "us"
	params[:country] = "us"
else
	params[:country] = false
end

puts "Which demographic categories should be tabulated? (region & age available - separate with a comma)"
dems = gets.chomp

sample = Sample.new(params)

sample.generate_demos(dems.split(','))

sample.stubify('ballots_hs.csv', dems.split(',')) if ballotreq === 'y'

sample.surveyify('survey_hs.csv', dems.split(',')) if surveyreq === 'y'

puts "OPERATION COMPLETED BITCHES! :D"

#dems[:region].each do |k,v|
#	puts "#{k} => #{v[0]}, #{v[1] * 100}%"
#end

#dems[:age].each do |k,v|
#	puts "#{k} => #{v[0]}, #{v[1] * 100}%"
#end

#sample.get_specific_user_data("574").each do |k,v|
#	puts "#{k} => #{v}"
#end
