class ApplicationService
    require "ostruct"
    require "uri"
    require "net/http"
    def self.call(*args, &block)
      new(*args, &block).call
    end
end