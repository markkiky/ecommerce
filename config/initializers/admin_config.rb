class AdminConfig
    def self.all
        # create a cached hash
        @cache ||= ApiUrl.all.inject({}) do |hsh, c_config|
          hsh[c_config.key.to_sym] = c_config.value
          hsh
        end
    end 
    
    def self.get(key)
        self.all[key.to_sym]
    end

    def self.[](key)
        self.all[key.to_sym]
    end
end