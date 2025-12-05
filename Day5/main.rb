class PuzzleSolver
  
  def initialize
    @ranges_raw = read_input('ranges.txt')
    @ids = read_input('ids.txt')
    @ranges = []

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
    p "ranges loaded" if DEBUG
  end

  def call
    get_ranges
    get_fresh
  end

  def get_fresh
    fresh_ids = []
    @ids.each do |id_str|
      id = id_str.to_i
      is_fresh = @ranges.any? { |range| range.include?(id) }
      p "is fresh: #{is_fresh} for id #{id}" if is_fresh && DEBUG
      fresh_ids << id if is_fresh
    end
    p fresh_ids.length
  end
end

DEBUG = true
PuzzleSolver.new.call