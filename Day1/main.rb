class PuzzleSolver
  attr_reader :input

  def initialize
    @input = nil
    @solution = 0
    @clicks = 0
    @start = 50 
    @scale = 100
    @input = []
    read_input('input.txt')
  end
  
  def read_input(file_path)
    input = []
    File.readlines(file_path, chomp: true).map do |line|
      new_line = line.sub(/\A[LR]/, { 'L' => '-', 'R' => '+' })
      hash = {operator: new_line.slice!(0), value: new_line[0..-1].to_i}
      @input << hash
    end
  end

  def calc(distance, operator)
    case operator
      when '+'
        steps_to_zero = (@scale - @start) % @scale
        steps_to_zero = @scale if steps_to_zero.zero?
        zeros = distance >= steps_to_zero ? 1 + ((distance - steps_to_zero) / @scale) : 0
        @clicks += zeros
        @start = (@start + distance) % @scale
      when '-'
        steps_to_zero = @start % @scale
        steps_to_zero = @scale if steps_to_zero.zero?
        zeros = distance >= steps_to_zero ? 1 + ((distance - steps_to_zero) / @scale) : 0
        @clicks += zeros
        @start = (@start - distance) % @scale
    end
    @solution += 1 if @start.zero?
  end

  def solution
    @input.each do |line|
      operator = line[:operator]
      value = line[:value]
      calc(value, operator)
    end
    puts "p1: #{@solution}"
    puts "gesammt: #{@clicks}"
  end 
  
end

solver = PuzzleSolver.new
solver.solution

