class MobileParser
  class << self
	def number_for_saving(mobile_number)
	  mn = mobile_number.gsub(/[^\d]/, '')
	  number_with_country_code(mn)
	end

	def number_with_country_code(mobile_number)
	  mobile_number.gsub(/^0/, '63')
	end

	def number_for_sending(mobile_number)
	  '+' + number_for_saving(mobile_number)
	end
  end
end