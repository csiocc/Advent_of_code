class PuzzleSolver
  def initialize
    @input = read_input('input.txt')
    @grid = get_grid
    @result = 0
    
  end

  DEBUG = false

  def read_input(file_path)
    File.readlines(file_path).map do |line|
      line.chomp
    end
  end

  def get_grid
    grid = []
    @input.each do |line|
      grid << line.split(' ')
    end
    grid.each_with_index do |line, i|
      break if i == grid.length - 1
      line.map! { |no| no.to_i }
    end
    grid
  end

  def call
    calc
    p @result
  end

  def calc
    inp = @grid
    operators = @grid.pop
    result = 0
    rows = @grid.length
    cols = operators.length

    cols.times do |c|
      p "working on column #{c}" if DEBUG
      rows.times do |r|
        p "working on row #{r} - #{@grid[r]}" if DEBUG
        row = @grid[r]
          if r == 0
            result = row[c]
            next
          end
          op = operators[c]
          if op == '+'
            p "result: #{result} * #{row[c]}" if DEBUG
            result += row[c]
          elsif op == '*'
            p "result: #{result} * #{row[c]}" if DEBUG
            result *= row[c]
          end

        end
        p "#{@result} += #{result}" if DEBUG
        @result += result
      end
    
  end
end

DEBUG = true
PuzzleSolver.new.call
