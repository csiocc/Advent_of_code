class PuzzleSolver
  def initialize
    @input = []
    @output = []
    @result = 0
    @prefilter = []
    @filtered = []
    read_input('input.txt')
  end

  def read_input(file_path)
    line = File.read(file_path)
    @input = line.split(',').map(&:strip)
    @input.each do |c|
      inner_arr = []
      current =  c.split("-")
      current.each do |d|
        inner_arr << eval("#{d}")
        inner_arr
      end
      @output << inner_arr
      
    end
    p "output: #{@output}"
  end

  def calc
    @output.each do |pair|
      a = pair[0]
      b = pair[1]
      first = a > b ? b : a
      second = a > b ? a : b
      values = (first..second).to_a 
      @filtered << values.map {|v| (v.to_s.chars).length % 2 == 0 ? v : nil}.compact
    end
      @filtered.each do |i|
        i.each do |num|
          if equal?(num)
            p equal?(num)
            p "num is equal: #{num}"
            p "result: #{@result} += #{num}"
            @result += num
            p "result: #{@result}"
          end
        end
      
      end
    p "filtered: #{@filtered}"
    p @result
  end



  def call
    calc
  end

  def equal?(value)
    array = []
    array = value.to_s.chars
    mid = array.length / 2
    
    first_half = array.take(mid)
    second_half = array.drop(mid)

    first_half.join.to_i
    second_half.join.to_i

    if first_half == second_half
      return true
    else
      return false
    end
    false
  end
end


PuzzleSolver.new.call
