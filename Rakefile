require 'rake'

# Define a task for each day
namespace :day do
  (1..25).each do |day|
    desc "Run solution for day #{day}"
    task day.to_s.to_sym do
      Rake::Task['day:run'].invoke(day.to_s, nil)
    end
  end

  # The actual rake task, which is clunky to call from the CLI, hence the above helper tasks
  desc "Run a specific day's solution. Example: rake day:1 sample=true"
  task :run, [:day, :sample] do |t, args|
    day = args[:day]
    sample_mode = args[:sample] == 'true'

    unless day
      puts "Please specify a day to run, e.g., rake day:1"
      exit 1
    end

    day_file = File.join('days', "day#{day.rjust(2, '0')}.rb")

    unless File.exist?(day_file)
      puts "Day file not found: #{day_file}"
      exit 1
    end

    command = "ruby #{day_file}"
    command += " --sample" if sample_mode
    exec(command)
  end
end

desc "Run all days' solutions"
task :all do
  Dir.glob('days/day*.rb').sort.each do |file|
    puts "Running #{file}..."
    system("ruby #{file}")
    puts "-" * 40
  end
end
