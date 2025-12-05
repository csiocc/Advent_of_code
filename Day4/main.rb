class PuzzleSolver
  def initialize
    @input = read_input('input.txt')
    @grid = get_grid
    @result = 0
    @resgrid = @grid.clone
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
      grid << line.chars
    end
    new_grid = add_lines(grid)
    new_grid
  end

  def add_lines(grid)
    grid.each do |line|
      line.unshift('.')
      line.push('.')
    end
    new_line = []
    new_line2 = []
    grid.first.length.times do

      new_line << '.'
      new_line2 << '.'
    end
    grid.unshift(new_line)
    grid.push(new_line2)
    
    grid.each { |line| p line } if DEBUG
    grid
  end

  def get_movables(grid)
    last_row = grid.length - 1
    last_col = grid.first.length - 1

    (1...last_row).each do |x|
      (1...last_col).each do |y|
        next if grid[x][y] == '.'

        taken = 0
        taken += 1 if grid[x - 1][y - 1] != '.'
        taken += 1 if grid[x - 1][y]     != '.'
        taken += 1 if grid[x - 1][y + 1] != '.'
        taken += 1 if grid[x][y - 1]     != '.'
        taken += 1 if grid[x][y + 1]     != '.'
        taken += 1 if grid[x + 1][y - 1] != '.'
        taken += 1 if grid[x + 1][y]     != '.'
        taken += 1 if grid[x + 1][y + 1] != '.'
        @result += 1 if taken <= 3
        @resgrid[x][y] = '.' if taken <= 3
      end
    end
  end

  def call
    # p @grid
    # @grid.each { |line| p line}
    changed = true
    while changed == true
      before = @result
      get_movables(@grid)
      after = @result
      p "before: #{before}, after: #{after}" if DEBUG
      changed = false  if before == after
      p "still working" if DEBUG
      break if changed == false
    end
    p "result: #{@result}"
  end
end

PuzzleSolver.new.call
