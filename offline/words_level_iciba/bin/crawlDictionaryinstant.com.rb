require "hpricot"
require File.dirname(__FILE__) + '/HttpUtil'
require File.dirname(__FILE__) + '/DB'
require File.dirname(__FILE__) + '/ThreadPool'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

MyTableDictionaryInstantSucPage = TableDictionaryInstantSucPage.new
MyTableWord = TableWord.new
#logSuc = File.open('suc.log','a+')
#logFail = File.open('fail.log','a+')

def ExtraPage(pageNum)
    if MyTableDictionaryInstantSucPage.exist(pageNum)
        return []
    end
    #if pageNum < 1000000
    #    return []
    #end
    httpUtil = HttpUtil.new(nil, {addr: "127.0.0.1", port: 8087})
    #httpUtil = HttpUtil.new
    puts "start #{pageNum}"
    url = "http://dictionaryinstant.com/dictionary/browse/words?page=#{pageNum}"
    puts url
    data = httpUtil.get(url)
    if data == nil
        #logFail.puts pageNum
        #raise pageNum
        puts "===error #{pageNum}"
        return []
    end
    tree = Hpricot(data)
    ret = []
    tree.search('//div[@id="definitions"]/li/a/text()').each do |word|
        item = {}
        #puts word.to_s.strip
        item[:text] = word.to_s.strip
        item[:soundmark] = ""
        item[:soundUrl] = ""
        item[:chText] = ""
        item[:classId] = 0
        item[:lang] = "en"
        ret << item
    end
    #logSuc.puts pageNum
    #logSuc.close
    puts "===suc #{pageNum}"
    MyTableDictionaryInstantSucPage.insert(pageNum)
    return ret
end


def main
    pool = ThreadPool.new 10

    (1..23500).each do |i|
        puts i
        pool.process do
            puts "start #{i}"
            ret = ExtraPage(i)
            puts "end#{i}"
            
            #puts "tableWord#{i}"
            ret.each do |item|
                puts item
                MyTableWord.insert(item)
            end
            #puts "insert#{i}"
        end
        #sleep(5)
    end
end


if __FILE__ == $0
    main
end
