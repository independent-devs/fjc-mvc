# frozen_string_literal: true

if ENV['RAILS_ENV'] == 'test'
  puts 'Skipping Seed File in Test Environment use Factories instead'

  return
end

Dir.glob('db/seeds/*.rb').each do |seed_file|
  puts seed_file
  load(seed_file)
end
