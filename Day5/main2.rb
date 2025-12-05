class PuzzleSolver
  
  def initialize
    @ranges_raw = read_input('ranges.txt')
    @progress = 0.0
    @ranges = []
    @fresh_ids = 0
    @running = false
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
    p "ranges loaded" if DEBUG
  end

  def call
    get_ranges
    get_fresh
  end

  def get_fresh
    highest_id = @ranges.map(&:end).max
    lowest_id = @ranges.map(&:begin).min
    @range = (lowest_id..highest_id)
    @current_id = lowest_id
    @fresh_ids = 0
    @progress = 0.0

    range_length = highest_id - lowest_id
    p "full range length: #{range_length}" if DEBUG
    p "lowest id: #{lowest_id}" if DEBUG
    p "highest id: #{highest_id}" if DEBUG
    @running = true
    display = Thread.new { print_progress }

    @range.each do |id|
      is_fresh = @ranges.any? { |r| r.cover?(id) }
      p "is fresh: #{is_fresh} for id #{id}" if is_fresh && DEBUG2
      @fresh_ids += 1 if is_fresh
      @progress = (((id - lowest_id).to_f / range_length.to_f) * 100.0).round(2)
      @current_id = id
      end
  ensure
    @running = false
    display&.join
    p @fresh_ids
  end

  def get_progress(current, total)
    current_progress = (current.to_f / total.to_f) * 100.0
    
    if current_progress.round(2) != @progress
      @progress = current_progress.round(2)
    end   
  end

  def print_progress
    while @running
      range_string = @range ? "#{@range.begin}-#{@range.end}" : "no range"
      print "\r\033[KChecking ID: #{@current_id} | in Range: #{range_string}"
      print "\n\033[KFresh_ids: #{@fresh_ids} | Progress: #{@progress}%"
      print "\033[1A"
        STDOUT.flush
      sleep 0.1
    end
  end
end

DEBUG = true
DEBUG2 = false
PuzzleSolver.new.call