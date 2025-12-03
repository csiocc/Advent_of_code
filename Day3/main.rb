class PuzzleSolver
  def initialize
    @input = read_input('input.txt')
    @result = []
    @clicks = 0
    @result2 = 0
  end
  DEBUG = false

  def read_input(file_path)
    File.readlines(file_path, chomp: true).map do |line|
      line.chars.map(&:to_i)
    end
  end

  def call
    loop_through(@input)
  end

  def loop_through(value)
    value.each do |line|
      @clicks += 1
      highest, second_highest = find_highest(line)
      no = eval("#{highest}#{second_highest}")
      @result << no
    end
    p "result: #{@result.sum}"
  end

  def find_highest(value)
    p "input = #{value}" 
    highest = 0
    second_highest = 0

    value.each do |n| 
      current = n.to_i

      p "current = #{current}"
      p "#{current} vs #{highest}" if DEBUG

      if current > highest
        highest = current.to_i
        p "highest = #{highest}"
        next
      end
      if current <= highest && current > second_highest
        second_highest = current.to_i
        p "second highest = #{second_highest}"
      end  
    end
    p "highest: #{highest}, second highest: #{second_highest}, clicks: #{@clicks}" 
    return highest, second_highest
  end


end



PuzzleSolver.new.call