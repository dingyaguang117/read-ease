require "hpricot"
require File.dirname(__FILE__) + '/HttpUtil'
require File.dirname(__FILE__) + '/DB'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

MyHttpUtil = HttpUtil.new(nil, {addr: "127.0.0.1", port: 8087})
MyTableWord = TableWord.new



def ExtraPage(pageNum)
    url = "http://dictionaryinstant.com/dictionary/browse/words?page=#{pageNum}"
    puts url
    data = MyHttpUtil.get(url)
    if data == nil
        raise pageNum
    end
    tree = Hpricot(data)
    ret = []
    tree.search('//div[@id="definitions"]/li/a/text()').each do |word|
        item = {}
        puts word.to_s.strip
        item[:text] = word.to_s.strip
        item[:soundmark] = ""
        item[:soundUrl] = ""
        item[:chText] = ""
        item[:classId] = 0
        item[:lang] = "en"
        ret << item
    end
    return ret
end


def main
    for i in 53..23500
        ret = ExtraPage(i)
        ret.each do |item|
            puts item
            MyTableWord.insert(item)
        end
    end
end


if __FILE__ == $0
    main
end
