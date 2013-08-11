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
            if @proxy == nil
                data = Net::HTTP.get(url)
            else
                puts @proxy
                data = Net::HTTP::Proxy(@proxy[:addr], @proxy[:port]).get(url)
            end
        rescue Exception => e
            puts "HttpUtil: Error, when get",url
            puts e
            return nil
        end
        return data
    end
end


if __FILE__ == $0
    httpUtil = HttpUtil.new(nil, proxy = {addr: "127.0.0.1", port: 8087})
    puts httpUtil.get("http://dictionaryinstant.com/")
end