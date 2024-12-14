require_relative '../lib/elf'

module Advent
  class Day02

    MAX_DELTA = 3

    def initialize(sample: false)
      @input = Elf::File.new(2, sample: sample).load
    end

    def part1
      puts "Part 1 solution: #{solve_part1}"
    end

    def part2
      puts "Part 2 solution: #{solve_part2}"
    end

    private

    def solve_part1
      safe_values = 0
      @input.each do |line|
        is_safe = validate_line(line)
        # puts "#{is_safe ? 'safe  ' : 'unsafe'} - #{line}"
        safe_values += is_safe ? 1 : 0
      end
        
      return safe_values
    end

    def solve_part2
      safe_values = 0
      @input.each do |line|
        is_safe = validate_line(line, tolerance = 1)
        # puts "#{is_safe ? 'safe  ' : 'unsafe'} - #{line}"
        safe_values += is_safe ? 1 : 0
      end
        
      return safe_values
    end

    def validate_line(line, tolerance = 0)
      return true if line.length < 2 # Can't compare, assume valid
      
      elements = line.split.map(&:to_i)

      direction = get_direction(elements)
      # puts "#{line} Direction: #{direction}"
      if direction == 0
        # unfortunately, any one of our values could be the bad value
        # If removing any one of them results in a safe line, then the line is safe
        if tolerance > 0
          for i in 0..elements.length-1 do
            test_elements = elements.dup
            test_elements.delete_at(i)
            # puts "retrying sublist"
            return true if validate_line(test_elements.join(' '), tolerance-1)
          end
        end
        return false # all sublines were invalid
      end

      # we have a direction! Let's validate the deltas

      # iterate through next-to-last item, comparing with next
      error = nil
      for i in 0..elements.length-2 do
        current = elements[i]
        nxt = elements[i+1]
        delta = nxt - current
        error = "Values must change" if current == nxt
        error = "Values must #{direction>0 ? 'increase' : 'decrease'}" if delta * direction < 0
        error = "Values must increment by less than #{MAX_DELTA}" if delta.abs > MAX_DELTA
        if error
          # retry with less tolerance
          if tolerance > 0
            for i in i..i+1 do
              test_elements = elements.dup
              test_elements.delete_at(i)
              # puts "retrying sublist"
              return true if validate_line(test_elements.join(' '), tolerance-1)
            end
          end
          # puts "#{line} - failed retries"
          return false
        end
      end
      return true
    end

    def get_direction(elements)
      direction = 0
      for i in 0..elements.length-2 do
        current = elements[i]
        nxt = elements[i+1]
        delta = nxt - current
        direction += delta <=> 0
      end
      return direction <=> 0
    end
  end
end

if __FILE__ == $0
  day = Advent::Day02.new(sample: ARGV.include?('--sample'))
  day.part1
  day.part2
end
