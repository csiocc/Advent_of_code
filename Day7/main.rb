class PuzzleSolver
  def initialize
    @input = read_input('input.txt')
    @grid = get_grid
    @splitters_total = 0
    @result = 0
    @plus2 = 0
    @plus3 = 0
    @plus4 = 0
  end

  def read_input(file_path)
    File.readlines(file_path).map do |line|
      line.chomp
    end
  end

  def get_grid
    grid = []
    @input.each do |line|
      grid << line.split('')
    end
    grid
  end

  def count_splitters
    @grid.reject! do |row|
      p "this row has:" if DEBUG
      row_count = row.count('^')
      p row_count 
      if row_count >= 1
        p "#{@splitters_total} += #{row_count}" if DEBUG
        @splitters_total += row_count
        false
      else
        true
      end
      
    end
    p @grid if DEBUG
  end

  def get_lasers
    
    @result = @splitters_total
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        print_grid
        if @grid[r][c] == '^'
          @grid[r][c-1] = '|' unless c == 0 || @grid[r][c-1] == '^'
          @grid[r][c+1] = '|' unless c == row.length - 1 || @grid[r][c+1] == '^'
        end
      end
    end
  end

  def get_inactive
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        if @grid[r][c] == '^'
          p "^ found on #{r} #{c}" if DEBUG2
          p "r+1: #{@grid[r+1]&.[](c)}" if DEBUG2
          
          if @grid[r+1]&.[](c) == '^'
            @result -= 1
          elsif @grid[r+1]&.[](c) == '.' && @grid[r+2]&.[](c) == '^'
            @plus2 += 1
            @result -= 1
          elsif @grid[r+1]&.[](c) == '.' && @grid[r+2]&.[](c) == '.' && @grid[r+3]&.[](c) == '^'
            @plus3 += 1
            @result -= 1
          elsif @grid[r+1]&.[](c) == '.' && @grid[r+2]&.[](c) == '.' && @grid[r+3]&.[](c) == '.' && @grid[r+4]&.[](c) == '^'
            @plus4 += 1
            @result -= 1
          end  
        end
      end
    end
  end

  def call
    system('clear')
    p @grid if DEBUG
    count_splitters
    get_lasers
    get_inactive
    p "splitters total: #{@splitters_total}"
    p "result = #{@result}"
    p "plus2 = #{@plus2}"
    p "plus3 = #{@plus3}"
    p "plus4 = #{@plus4}"

  end

  def print_grid
    number_of_rows = @grid.size
    if defined?(@printed_once) && @printed_once
      print "\e[#{number_of_rows}A" 
    end
    @grid.each do |row|
      puts "\r" + row.join('')
    end
    @printed_once = true
  end

end

DEBUG = false
DEBUG2 = false
PuzzleSolver.new.call