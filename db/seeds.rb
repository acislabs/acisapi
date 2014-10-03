%w(+639178061524 +639177696957 +639152222222 +6391111111 +6395555555 +6399999999).each do |num|
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
