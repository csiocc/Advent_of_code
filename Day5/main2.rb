class PuzzleSolver
  
  def initialize
    @ranges_raw = read_input('ranges.txt')
    @progress = 0.0
    @ranges = []
    @fresh_ids = 0
    @current_id = 0
    @range = nil
  end

  def read_input(file_path)
    File.readlines(file_path).map do |line|
      line.chomp
    end
  end

  def get_ranges
    @ranges_raw.each do |range|
      start_str, end_str = range.split('-')
      start_id = start_str.to_i
      end_id = end_str.to_i
      @ranges << (start_id..end_id)
    end
    @ranges.sort_by! { |r| r.begin }
    p "ranges loaded and sorted" if DEBUG
  end

  def call
    get_ranges
    get_fresh
    p @fresh_ids
  end

  def get_fresh
    range_merge = []

    start = @ranges[0].begin
    ending = @ranges[0].end

    p @ranges if DEBUG
    @ranges.drop(1).each do |range|
      if range.begin <= ending + 1
        ending = [ending, range.end].max
      else
        range_merge << (start..ending)
        start = range.begin
        ending = range.end
      end
    end
    range_merge << (start..ending)
    @fresh_ids = range_merge.sum { |range| range.size }
  end

end

DEBUG = true
DEBUG2 = false
PuzzleSolver.new.call