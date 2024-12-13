require_relative '../lib/elf'

DAY = 2

module Advent
  class Day02
    def initialize(sample: false)
      @input = Elf::File.new(DAY, sample: sample).load
    end

    def part1
      puts "Part 1 solution: #{solve_part1}"
    end

    def part2
      puts "Part 2 solution: #{solve_part2}"
    end

    private

    def solve_part1
      # Your solution for Part 1 using @input
      0
    end

    def solve_part2
      # Your solution for Part 2 using @input
      0
    end
  end
end

if __FILE__ == $0
  day = Advent::Day01.new(sample: ARGV.include?('--sample'))
  day.part1
  day.part2
end
