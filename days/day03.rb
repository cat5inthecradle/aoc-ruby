require_relative '../lib/elf'

module Advent
  class Day03
    def initialize(sample: false)
      @input = Elf::File.new(3, sample: sample).load
    end

    def part1
      # 174336360
      puts "Part 1 solution: #{solve_part1}"
    end

    def part2
      puts "Part 2 solution: #{solve_part2}"
    end

    private

    def solve_part1
      # puts @input
      line = @input.join(" ")
      elements = line.split("mul(")
      if line.start_with?("mul(")
        elements.shift # trash the first element, not part of a mul()
      end

      # elements must contain at least one ")", if it does, substring on that and grab the first
      elements.map! do |e|
        next e.split(")")[0] if e.include?(")")
        next nil
      end.compact!

      # puts elements
      elements.map! do |e|
        pair = e.split(",")
        # puts "Checking mul(#{pair.join(',')})"
        if pair.length != 2
          next nil
        end

        begin
          pair.map! do |factor|
            if !is_valid_integer?(factor)
              raise "'#{factor}' is not a 1-3 digit integer"
            end
            factor.to_i
          end
        rescue => exception
          # puts "#{pair} failed to transform: #{exception}"
          next nil
        end
        
        # puts "checking #{pair}"
        # puts "#{pair[0]} x #{pair[1]} = #{pair[0] * pair[1]}"
        next pair[0] * pair[1]
      end.compact!
      return elements.sum
    end

    def solve_part2
      puts @input
      line = @input.join(" ")

      # yyydo()yyydon't()nnndo()yyyy
      # split on do() is everything after a do, and the first element
      line = line.split("do()").map! do |block|
        # then look for don't() inside the doable block, skip everything after the don't()
        next block.split("don't()")[0] if block.include?("don't()")
        nil
      end.compact!.join(' ')

      elements = line.split("mul(")
      if line.start_with?("mul(")
        elements.shift # trash the first element, not part of a mul()
      end

      # elements must contain at least one ")", if it does, substring on that and grab the first
      elements.map! do |e|
        next e.split(")")[0] if e.include?(")")
        next nil
      end.compact!

      puts elements
      elements.map! do |e|
        pair = e.split(",")
        puts "Checking mul(#{pair.join(',')})"
        if pair.length != 2
          next nil
        end

        begin
          pair.map! do |factor|
            if !is_valid_integer?(factor)
              raise "'#{factor}' is not a 1-3 digit integer"
            end
            factor.to_i
          end
        rescue => exception
          puts "#{pair} failed to transform: #{exception}"
          next nil
        end
        
        puts "checking #{pair}"
        puts "#{pair[0]} x #{pair[1]} = #{pair[0] * pair[1]}"
        next pair[0] * pair[1]
      end.compact!
      return elements.sum
    end

    def is_valid_integer?(value)
      # puts "checking #{value}"
      regex = /^\d{1,3}$/
      value.match?(regex)
    end
  end
end

if __FILE__ == $0
  day = Advent::Day03.new(sample: ARGV.include?('--sample'))
  day.part1
  day.part2
end
