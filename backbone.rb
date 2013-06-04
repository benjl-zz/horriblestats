require 'csv'

class Sample

	def initialize(params)
		#Parses defined CSV value as a nested Hash in the format of "id" => "row" where row is itself header => field. Accessed ex: sample["411"]["email"]		
		@params = params
		@sample = {} #hash of hashes containing user data (:411 => :email => 'example@example.com')
		@headers = [] #array of headers from LDP_User_Basic SQL file
		@btypes = []
		@country = @params[:country]
		a = {}
		linecount = 0

		#------USER FILE---------
		puts "Opening user file..."
		CSV.open("#{@params[:userdata]}", 'r', ',') do |row|
			if linecount === 0
				(0..row.length).each do |x|
					@headers.push(row[x])
				end
			else
				(1..row.length-1).each do |y|
					a[@headers[y]] = [row[y]]
				end
				@sample[row[0]] = a
			end
			a = {}
			linecount += 1
			if linecount % 2 === 0
				output = "working o" + "\r"
			else
				output = "working *" + "\r"
			end
			print output
		end
		puts "User file succesfully loaded"
	end

	def generate_demos(requestarr)
		#generates a nested hash (demos[:region][:wa], demos[:age][:18to34]) for region and age - gender, age, and income unavailable
		if requestarr.include?("region")
			#------REGION---------
			if @country === "us"
					@demos = {:region => {:total => [0.00], :newengland => [0.00,0.00], :midatlantic => [0.00,0.00], :eastnorthcentral => [0.00,0.00], :westnorthcentral => [0.00,0.00], :southatlantic => [0.00,0.00], :eastsouthcentral => [0.00,0.00], :westsouthcentral => [0.00,0.00], :mountain => [0.00,0.00], :pacific => [0.00,0.00], :other => [0.00,0.00]}, :age => {:total => [0.00], :eighteenthirtyfour => [0.00,0.00], :thirtyfivefiftyfour => [0.00,0.00], :fiftyfiveplus => [0.00,0.00], :other => [0.00,0.00]}}
					@counts = {:region => {:total => [],:newengland => [], :midatlantic => [], :eastnorthcentral => [], :westnorthcentral => [], :southatlantic => [], :eastsouthcentral => [], :westsouthcentral => [], :mountain => [], :pacific => [], :other => []}, :age => {:total => [], :eighteenthirtyfour => [], :thirtyfivefiftyfour => [], :fiftyfiveplus => [], :other => []}}

				puts "Gathering region demos..."
				@sample.each do |key,value|
					case value['state'].to_s
					when 'ME','NH','VT','MA','RI','CT'
						@demos[:region][:newengland][0] += 1.00
						@counts[:region][:newengland].push(key.to_s)
					when 'NY','PA','NJ'
						@demos[:region][:midatlantic][0] += 1.00
						@counts[:region][:midatlantic].push(key.to_s)
					when 'WI','MI','IL','IN','OH'
						@demos[:region][:eastnorthcentral][0] += 1.00
						@counts[:region][:eastnorthcentral].push(key.to_s)
					when 'MO','ND','SD','NE','KS','MN','IA'
						@demos[:region][:westnorthcentral][0] += 1.00
						@counts[:region][:westnorthcentral].push(key.to_s)
					when 'DE','MD','DC','VA','WV','NC','SC','GA','FL'
						@demos[:region][:southatlantic][0] += 1.00
						@counts[:region][:southatlantic].push(key.to_s)
					when 'KY','TN','MS','AL'
						@demos[:region][:eastsouthcentral][0] += 1.00
						@counts[:region][:eastsouthcentral].push(key.to_s)
					when 'OK','TX','AR','LA'
						@demos[:region][:westsouthcentral][0] += 1.00
						@counts[:region][:westsouthcentral].push(key.to_s)
					when 'ID','MT','WY','NV','UT','CO','AZ','NM'
						@demos[:region][:mountain][0] += 1.00
						@counts[:region][:mountain].push(key.to_s)
					when 'AK','WA','OR','CA','HI'
						@demos[:region][:pacific][0] += 1.00
						@counts[:region][:pacific].push(key.to_s)
					else
						@demos[:region][:other][0] += 1.00
						@counts[:region][:other].push(key.to_s)
					end
					@demos[:region][:total][0] += 1.00
					@counts[:region][:total].push(key.to_s)
				end
			elsif @country === 'ca'
					@demos = {:region => {:total => [0.00], :bc => [0.00,0.00], :ab => [0.00,0.00], :sk_mb => [0.00,0.00], :on => [0.00,0.00], :qc => [0.00,0.00], :atl => [0.00,0.00], :nth => [0.00,0.00], :other => [0.00,0.00]}, :age => {:total => [0.00], :eighteenthirtyfour => [0.00,0.00], :thirtyfivefiftyfour => [0.00,0.00], :fiftyfiveplus => [0.00,0.00], :other => [0.00,0.00]}}
					@counts = {:region => {:total => [],:bc => [], :ab => [], :sk_mb => [], :on => [], :qc => [], :atl => [], :nth => [], :other => []}, :age => {:total => [], :eighteenthirtyfour => [], :thirtyfivefiftyfour => [], :fiftyfiveplus => [], :other => []}}
				puts "Gathering region demos..."
				@sample.each do |key,value|
					case value['state'].to_s
					when 'BC'
						@demos[:region][:bc][0] += 1.00
						@counts[:region][:bc].push(key.to_s)
					when 'AB'
						@demos[:region][:ab][0] += 1.00
						@counts[:region][:ab].push(key.to_s)
					when 'SK','MB'
						@demos[:region][:sk_mb][0] += 1.00
						@counts[:region][:sk_mb].push(key.to_s)
					when 'ON'
						@demos[:region][:on][0] += 1.00
						@counts[:region][:on].push(key.to_s)
					when 'QC'
						@demos[:region][:qc][0] += 1.00
						@counts[:region][:qc].push(key.to_s)
					when 'NB','PE','NS','NL'
						@demos[:region][:atl][0] += 1.00
						@counts[:region][:atl].push(key.to_s)
					when 'YK','NT','NW'
						@demos[:region][:nth][0] += 1.00
						@counts[:region][:nth].push(key.to_s)
					else
						@demos[:region][:other][0] += 1.00
						@counts[:region][:other].push(key.to_s)
					end
					@demos[:region][:total][0] += 1.00
					@counts[:region][:total].push(key.to_s)
				end
			end
		end

		if requestarr.include?("age")
			#------AGE---------
			puts "Gathering age demos..."
			@sample.each do |key,value|
				age = 2013 - value['fax'].to_s.match(/[0-9]{4}/).to_s.to_i
				case age
				when 18..34
					@demos[:age][:eighteenthirtyfour][0] += 1.00
					@counts[:age][:eighteenthirtyfour].push(key.to_s)
				when 35..54
					@demos[:age][:thirtyfivefiftyfour][0] += 1.00
					@counts[:age][:thirtyfivefiftyfour].push(key.to_s)
				when 55..150
					@demos[:age][:fiftyfiveplus][0] += 1.00
					@counts[:age][:fiftyfiveplus].push(key.to_s)
				else
					@demos[:age][:other][0] += 1.00
					@counts[:age][:other].push(key.to_s)
				end
				@demos[:age][:total][0] += 1.00
				@counts[:age][:total].push(key.to_s)
			end
		end
		puts "Done."
		puts "Calulating Percentages..."
		@demos[:region].each do |key,value|
			@demos[:region][key.to_sym][1] = value[0]/@demos[:region][:total][0]
		end	
		@demos[:age].each do |key,value|
			@demos[:age][key.to_sym][1] = value[0]/@demos[:age][:total][0]
		end	
		puts "Done."
		return @demos
	end

	def stubify(filename,requestarr)
		#takes an array of the names of the available demos then iterates over them creating arrays formated for pringing to the CSV
		bheads = []
		demo_arr = ['']
		value_arr = ['']
		pct_arr = ['']
		stub_arr = [[],[]]
		stubcount = 0
		stubcount2 = 0
		result = 0

		#------LOADING BALLOT FILE---------
		puts "Opening ballot file..."
		linecount = 0
		CSV.open("#{@params[:ballotdata]}", 'r', ',') do |row|
			if linecount === 0
				(0..row.length-1).each do |x|
					bheads.push(row[x])
				end
			elsif !@sample[row[1]].nil?
				@sample[row[1]].merge!(row[2] => true)
				@btypes << row[2]
			else
				puts "WARNING: User id in Ballot file not located in User file. ID:#{row[1]}"
			end
			if linecount % 2 === 0
				output = "working o" + "\r"
			else
				output = "working *" + "\r"
			end
			linecount += 1
			print output
		end
		puts "Ballot file succesfully loaded"

		#------CALCULATING RESULTS & PREPPING FOR PRINTING---------
		stub_names = @btypes.uniq!
		stub_names.each do |stub|
			stub_arr[0] << [stub]
			stub_arr[1] << ['']
		end

		requestarr.each do |cat|
			demo_cat = cat.to_sym

			puts "Preparing #{cat}"

			@demos[demo_cat].each do |region,dbcount|
				puts "Preparing #{region}"
				demo_arr << region.to_s
				value_arr << dbcount[0]
				pct_arr << dbcount[1]

				stub_names.each do |stub|
					result = 0
					@counts[demo_cat][region].each do |user|
						if region === :total
						else
							if @sample[user].has_key?(stub)
								result += 1
							end
						end
					end
					stub_arr[0][stubcount] << result
					total =  @counts[demo_cat][:total]
					pct_result = result / dbcount[0].to_f
					stub_arr[1][stubcount] << pct_result
					stubcount += 1
				end
				stubcount = 0
			end
		end
		
		#------PRINTING RESULTS TO FILE---------
		CSV.open("#{filename}", 'w') do |writer|
			writer << demo_arr
			writer << value_arr
			writer << pct_arr
		end
		
		counter = 0

		stub_arr[0].each do |stub|
			stub.map!{|x| x.to_s + ","}
			stub.push("\n")
			stub_arr[1][counter].map!{|x| x.to_s + ","}
			stub_arr[1][counter].push("\n")
			File.open("#{filename}",'a') {|file| 
				file.write(stub)
			}
			File.open("#{filename}",'a') {|file| 
				file.write(stub_arr[1][counter])
			}
			counter += 1
		end
	end

	def get_ballot_types()
		#returns an array containing each different type of entry ballot
		return @btypes.uniq!
	end
	def all()
		#returns the nested sample hash that was loaded in initialize
		return @sample
	end

	def get_specific_user_data(id,value="")
		#returns specified element, or if value is blank returns the entire row as a hash
		if value === ""
			return @sample["#{id}"]
		else
			return @sample["#{id}"]["#{value}"]
		end
	end

	def query(header,match)
		#returns an array of ids that match the search. Args always passed as a string
		a = []
		@sample.each do |key,value|
			if value[header].to_s === match
				a.push(key)
			end
		end
		return a
	end

	def count(header,match)
		#returns a hash  containing number of matches, number of records searched, and the percentage of matches
		count_records = 0.00
		count_matches = 0.00
		@sample.each do |key,value|
			print "Counting" + "\r"
			count_records += 1.00
			if value[header].to_s === match
				count_matches += 1.00
			end
			print "Counting..."
		end
		h = {:match => count_matches, :of => count_records,:pt => (count_matches/count_records)*100}
	end

	def get_headers()
		#returns an array with all headers from the file.
		return @headers
	end
end
