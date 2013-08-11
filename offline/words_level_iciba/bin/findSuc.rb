require File.dirname(__FILE__) + '/DB'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

MyTableDictionaryInstantSucPage = TableDictionaryInstantSucPage.new

f = File.open("log[1].log","r")

f.each do |line|
    if line.include?("=suc ")
        puts line.split[1]
        begin 
            MyTableDictionaryInstantSucPage.insert(line.split[1])
        rescue
        end
        puts MyTableDictionaryInstantSucPage.exist(line.split[1])
    end
end

