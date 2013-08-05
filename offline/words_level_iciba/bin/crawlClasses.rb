require "hpricot"
require File.dirname(__FILE__) + '/HttpUtil'
require File.dirname(__FILE__) + '/DB'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

MyHttpUtil = HttpUtil.new


def extraClasses()
    url = 'http://nbdc.iciba.com/'
    puts url
    html = MyHttpUtil.get(url)
    tree = Hpricot(html)
    ret = []
    tree.search('//li[@has_child="0"]').each do |li|
        ret << li.attributes['class_id']
    end
    return ret
end



if __FILE__ == $0
    extraClasses.each do |classId|
        print classId,','
    end
end