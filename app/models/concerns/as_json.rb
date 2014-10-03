module Concerns
	module AsJson
		def only_attributes
      self.attributes.keys
    end

    def methods_list
      []
    end

    def as_json(**options)
      options.symbolize_keys!
      only = only_attributes | Array(options[:only]); options.delete(:only)
      methods = methods_list | Array(options[:methods]); options.delete(:methods)
      super(only: only_attributes, methods: methods_list, **options)
    end
	end
end