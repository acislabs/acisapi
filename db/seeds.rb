%w(+639177696957 +639152222222 +6391111111 +6395555555 +6399999999).each do |num|
  	puts "Creating sample verification_codes"
    VerificationCode.create(
	    mobile_number: num, 
	    code: '12345',
	    name: 'Test User'
    )
  	puts "DONE!"
end

verification_codes = VerificationCode.all

verification_codes.each do |code|
	%w(+639177696957 +639152222222 +6391111111 +6395555555 +6399999999).each do |num|
	  	puts "Creating sample user for mobile num #{num}"

	  	if num == code.mobile_number
		    user = User.create(
			    	mobile_number: num, 
			    	access_token: '111111',
			    	operating_system: 'Android', 
			    	device_token: '12345', 
			    	active: true
		    	)

		    if user.save
		  	  puts "VERIFIED!"

		  	  puts "Creating default profile"

		  	  user.profiles.create!(
						name: code.name,
						email: "random@test.com",
						website: "http://acis.io",
						company: "Sourcepad",
						job_title: "Programmer"
					)

					code.destroy
		  	end
		  else
		  	puts "NOT VERIFIED"
		  end
	end
end

# puts "Creating sample profiles"

# users = User.all

# users.each do |user|
	
# end

# puts "Creating sample ignorable users"

# User.first.ignored_users.create(user_id: User.last.id)

