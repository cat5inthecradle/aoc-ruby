require_relative '../lib/elf'

module Advent
  class Day01
    def initialize(sample: false)
      @input = Elf::File.new(1, sample: sample).load
    end

    def part1
      puts "Part 1 solution: #{solve_part1}"
    end

    def part2
      puts "Part 2 solution: #{solve_part2}"
    end

    private

    def solve_part1
      first_list = []
      second_list = []
      @input.each do |line|
        elements = line.split.map(&:to_i)
        first_list << elements[0]
        second_list << elements[1]
      end

      first_list.sort!
      second_list.sort!

      total_distance = 0
      first_list.each_with_index do |first, i|
        second = second_list[i]
        difference = (first - second).abs
        # puts "#{first} - #{second} = #{difference}"
        total_distance += difference
      end

      return total_distance
    end

    def solve_part2
      first_list = []
      second_list = []
      @input.each do |line|
        elements = line.split.map(&:to_i)
        first_list << elements[0]
        second_list << elements[1]
      end

      first_list.sort!
      second_list.sort!

      similarity = 0
      j = 0
      first_list.each do |first|
        # puts "#{first} vs #{second_list.join(', ')}"
        count = 0
        j = 0
        second = second_list[j]
        # skip and remove lesser values
        while j < second_list.length && second_list[j] < first do
          second_list.delete_at(j)
          # j += 1
        end
        # count equal values
        while j < second_list.length && second_list[j] == first do
          count += 1
          j += 1
        end

        # puts "#{first} - #{count} times"
        similarity += count * first
      end

      return similarity
    end
  end
end

if __FILE__ == $0
  day = Advent::Day01.new(sample: ARGV.include?('--sample'))
  day.part1
  day.part2
end
