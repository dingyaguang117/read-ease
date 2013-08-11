require "thread"


class ThreadPool      
    attr_accessor :max_size  

    def initialize(max_size = 10)  
      @max_size = max_size  
      @q = SizedQueue.new(max_size)  
    end

    def process(&block)
      #puts "qsize: #{@q.size}"
      @q.push(0)
      Thread.new do
        block.call
        #puts 'poped'
        @q.pop
      end
    end
end

def test
  pool = ThreadPool.new 10

  (1..10000).each do |i|
    pool.process do
      puts "start #{i}"
      sleep(3)
      puts "end #{i}"
    end
    
  end

end


def test2
  #pool = ThreadPool.new 1
  q = SizedQueue.new(2)
  q.pop()
end


if __FILE__ == $0
  test
end
