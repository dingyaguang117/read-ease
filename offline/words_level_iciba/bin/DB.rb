require "mysql2"

HOST = "127.0.0.1"
USERNAME = "root"
PASSWORD = ""
DATABASE_NAME = "test"


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
    TableName = 'words'

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
        sql = "insert into #{TableName} (text, soundmark, soundiUrl, chText, lang, classId) values (
                '#{item[:text]}', '#{item[:soundmark]}', '#{item[:soundUrl]}', '#{item[:chText]}', 
                '#{item[:lang]}', #{item[:classId]})"
        puts sql
        @database.client.query(sql)
    end


    def query
        ret = []
        sql = "select * from #{TableName}"
        @database.client.query(sql).each do |word|
            puts word["chText"]
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