require "net/http"

class HttpUtil
    
    attr_accessor :headers, :proxy
    attr :opener

    def initialize(headers = nil , proxy = nil)
        @headers = headers
        @proxy = proxy
    end

    def get(url)
        url = URI.parse(url)
        begin
            data = Net::HTTP.get(url)   
        rescue Exception => e
            puts "HttpUtil: Error, when get",url
            puts e
        end
    end
end


if __FILE__ == $0
    httpUtil = HttpUtil.new
    puts httpUtil.get("http://www.baidu.com")
end