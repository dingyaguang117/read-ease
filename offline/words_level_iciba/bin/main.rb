require "hpricot"
require File.dirname(__FILE__) + '/HttpUtil'
require File.dirname(__FILE__) + '/DB'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

MyHttpUtil = HttpUtil.new
MyTableWord = TableWord.new

def extraWords(classId, courseId)
    url = "http://nbdc.iciba.com/?action=words&class=#{classId}&course=#{courseId}"
    puts url
    ret = []
    html = MyHttpUtil.get(url)
    tree = Hpricot(html)

    
    tree.search('//ul[@class="word_main_list"]/li').each do |li|
        item = {}
        item[:text] = li.search('/div[@class="word_main_list_w"]/span')[0].attributes["title"]
        item[:soundmark] = li.search('/div[@class="word_main_list_y"]/strong/text()')[0].to_s.strip
        item[:soundUrl] = li.search('/div[@class="word_main_list_y"]/a')[0].attributes["id"]
        item[:chText] = li.search('/div[@class="word_main_list_s"]/span')[0].attributes["title"]
        item[:classId] = classId
        item[:lang] = "en"
        ret << item
        MyTableWord.insert(item)
    end

    return ret
end

def main()
    extraWords(11, 1).each do |one|
        puts one
    end
end


if __FILE__ == $0
    main
end