class PuzzleSolver
  def initialize
    @input = read_input('input.txt')
    @result = []
    @line = 0
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
      @line += 1
      highest, second_highest = find_highest(line)
      p "highest: #{highest[:n]}, second highest: #{second_highest[:n]}" if DEBUG
      no = []
      no[highest[:i]] = highest[:n]
      no[second_highest[:i]] = second_highest[:n]
      no.compact!
      p "no = #{no}"
      no2 = no.join.to_i
      @result << no2
      p "pushing #{no2} to result array"
    end
    p "result: #{@result.sum}" 
  end

  def find_highest(value)
    highest = {n: 0, i: nil}
  
    value.each_with_index do |n, i| 
      current = n.to_i
      p "#{current} vs #{highest[:n]}" if DEBUG

      if current > highest[:n]
        highest[:n] = current.to_i
        highest[:i] = i
      end
    end
    second_highest = find_second(value, highest[:i])
    p "found highest: #{highest}, second highest: #{second_highest} line: #{@line}" 
    return highest, second_highest
  end

  def find_second(value, i)
    second_highest = {n: -1, i: nil}

    value.each_with_index do |n, ii|
      next unless ii > i
    
      current = n.to_i

      if current >= second_highest[:n]
        second_highest[:n] = current
        second_highest[:i] = ii
      end
    end

    if second_highest[:n].nil?
      value.each_with_index do |n, ii|
        next if ii <= i

        current = n.to_i
        
        if current >= second_highest[:n]
          second_highest[:n] = current
          second_highest[:i] = ii
        end

      end
    end
    return second_highest
  end


end



PuzzleSolver.new.call