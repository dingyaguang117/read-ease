require "mysql2"

HOST = "127.0.0.1"
USERNAME = "root"
PASSWORD = ""
DATABASE_NAME = "read-ease"


class DB
    attr_accessor :client
    def initialize(host = nil,username = nil,password = nil,db = nil)
        if host.nil?
            @client = Mysql2::Client.new(:host => HOST, :username => USERNAME,:password=> PASSWORD,:database=>DATABASE_NAME)
        else
            @client = Mysql2::Client.new(:host => host, :username => username,:password=> password,:database=>db)
        end
    end
end


class TableWord
    TableName = 'word'

    def initialize
        @database = DB.new
    end

    def create
        @database.client.query("create table #{TableName} (id integer auto_increment,text varchar(100), soundmark varchar(100),
                                soundiUrl varchar(255), chText varchar(255), lang varchar(10), classId integer, primary key(id),
                                UNIQUE KEY `classId_text_unique` (`classId`,`text`))
                                DEFAULT CHARSET=utf8")
    end

    def drop
        begin
            @database.client.query("drop table #{TableName} ")
        rescue  => e
        end
    end 

    def insert(item)
        item.each do |k,v|
            if v.class == "".class
                item[k] = @database.client.escape(v)
            end
        end
        begin
            sql = "insert into #{TableName} (text, soundmark, soundiUrl, chText, lang, classId) values (
                '#{item[:text]}', '#{item[:soundmark]}', '#{item[:soundUrl]}', '#{item[:chText]}', 
                '#{item[:lang]}', #{item[:classId]})"
            @database.client.query(sql)

        rescue => e
            puts '======== insert error ========'
            puts e.error_number
            puts e
            puts sql
            puts '========================='
            #重复key 忽略
            if e.error_number != 1062
                raise
            end
        end
        #puts sql
    end


    def query
        ret = []
        sql = "select * from #{TableName}"
        @database.client.query(sql).each do |word|
            print word["chText"]
            ret << word
        end
        return ret
    end
end

if __FILE__ == $0
    #DB.new #(HOST,USERNAME,PASSWORD,DATABASE_NAME)
    word = TableWord.new
    word.drop
    word.create
    word.query
    #word.insert(item)
end