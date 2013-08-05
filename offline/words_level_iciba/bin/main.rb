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

    #检查结束
    #puts tree.search('//div[@class="word_resultV_cont word_resultV_End"]').size 
    if tree.search('//div[@class="word_resultV_cont word_resultV_End"]').size != 0
        return nil
    end
    
    tree.search('//ul[@class="word_main_list"]/li').each do |li|
        item = {}
        begin
            item[:text] = li.search('/div[@class="word_main_list_w"]/span')[0].attributes["title"].strip
            item[:soundmark] = li.search('/div[@class="word_main_list_y"]/strong/text()')[0].to_s.strip
            item[:soundUrl] = li.search('/div[@class="word_main_list_y"]/a')[0].attributes["id"].strip
            item[:chText] = li.search('/div[@class="word_main_list_s"]/span')[0].attributes["title"].strip
            item[:classId] = classId
            item[:lang] = "en"
        rescue => e
            puts e
            next
        end
        ret << item
    end

    return ret
end

def main()
    classList = [41,42,43,44,125,126,127,128,129,293,294,358,359,361,362,363,364,365,366,355,75,76,77,78,79,80,81,97,98,147,153,175,145,144,146,99,100,101,87,83,84,85,86,102,82]
    classList.each do |classId|
        i = 1
        while true
            ret = extraWords(classId, i)
            if ret.nil?
                break
            end
            ret.each do |item|
                puts item
                MyTableWord.insert(item)
            end
            i += 1
        end
    end
end


if __FILE__ == $0
    main
    #extraWords(140,72).each do |item|
    #    puts item
    #    MyTableWord.insert(item)
    #    
    #end
end