class MobileParser
  class << self
	def number_for_saving(mobile_number)
	  mobile_number.gsub(/[^\d]/, '')
	end

	def number_for_sending(mobile_number)
	  '+' + number_for_saving(mobile_number)
	end
  end
end