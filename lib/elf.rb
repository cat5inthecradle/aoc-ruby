# lib/elf.rb
module Elf
  class File
    def initialize(day, sample: false)
      @day = day.to_s.rjust(2, '0') # Zero-pad the day for consistent file naming
      @sample = sample
      puts "Sample: #{@sample}"
    end

    def load
      file_path = input_file_path
      raise "File not found: #{file_path}" unless ::File.exist?(file_path)

      ::File.read(file_path).lines.map(&:chomp)
    end

    private

    def input_file_path
      if @sample
        "inputs/day#{@day}_sample.txt"
      else
        "inputs/day#{@day}.txt"
      end
    end
  end
end
