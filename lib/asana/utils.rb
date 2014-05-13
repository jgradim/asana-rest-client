module Asana
  module Utils

    def set_param(options, key, value)
      if options[:params]
        options[:params] = { key => value }.merge(options[:params])
      else
        options[:params] = { key => value }
      end
      options
    end

  end
end
