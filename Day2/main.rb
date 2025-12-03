class PuzzleSolver
  def initialize
    @input = []
    @output = []
    @result = 0
    @prefilter = []
    @filtered = []
    read_input('input2.txt')
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
            @result += num

          end
        end
      end
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

class PuzzleSolverPart2 < PuzzleSolver
  def initialize
    @input = []
    @output = []
    @result = 0
    @prefilter = []
    @filtered = []
    read_input('input2.txt')
  end

  def calc
    @output.each do |pair|
      a = pair[0]
      b = pair[1]
      first = a > b ? b : a
      second = a > b ? a : b
      values = (first..second).to_a 
      @filtered << values

    end
      @filtered.each do |i|
        i.each do |num|
          if equal?(num)
            @result += num
          end
        end
      
      end
    p @result
  end

  def call
    calc
  end

  def equal?(value)
    array = []
    max = []
    array = value.to_s.chars
    mid = array.length / 2
    
    first_half = array.take(mid)
    second_half = array.drop(mid)

    first_half.join.to_i
    second_half.join.to_i

    if first_half == second_half
      return true
    end

    new_arr = array.map { |e| e.to_i }

    (new_arr.length - 1).times do |index|

      current = []
      
      if index == 0 
        next
      end

      if new_arr[0] == new_arr[index]
        p "index: #{index}"
        p "#{new_arr[0]} == #{new_arr[index]}"
        current = new_arr.slice(0, index)
        if current.length > max.length
          p "new_arr0: #{new_arr[0]} new_arrindex: #{new_arr[index]}"
          max = current
          p "max: #{max}"
        end
      end

      if new_arr[index - 1] == new_arr[index + 1] && new_arr[index] == new_arr[index + 2]
        current = new_arr.slice(index - 1,index + 2)
        if current.length > max.length
          p "#{new_arr[index - 1]}#{new_arr[index]} == #{new_arr[index + 1]}#{new_arr[index + 2]}"
          max = current
          p "max: #{max}"
        end
      end
    end
    p max.join.to_i
    false
  end
  
end


PuzzleSolverPart2.new.call
