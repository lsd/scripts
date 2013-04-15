# Quick script to disinfect every file listed in 'dirty_files.txt'
# Removes the annoying eval(base64_decode("DQ..."); PHP worm
#
# Make backups before running this!

infected = 'dirty_files.txt'
oxyclean = 'perl -pi -e \'s/eval\(base64_decode\("D.*?"\)\);//g\''

unless File.exists? infected
  puts "NOT FOUND - All infected files should be in #{infected}"
  exit
end

puts "\nStarting (cleanser is #{oxyclean} \"file.php\")\n\n"

bytes = 0
cleaned = 0

IO.foreach(infected) do |f|
  f.chop!
  before = File.size(f)

  # skip presumably clean files
  puts "* File < 601 bytes - skipping #{f}" and next unless before > 600

  # backup file.php to file.dirty
  puts "* Backing #{f} to #{f}.dirty"
  %x(cp #{f} #{f}.dirty)

  # dont use sed (need to be non-greedy) and be careful between *nix/os x distributions)
  %x(#{oxyclean} "#{f}")

  diff = before - File.size(f)
  puts "* #{diff} bytes removed from #{f}\n\n" if diff > 0

  # Check PHP syntax (lint)
  #p %x(php -l #{f})

  cleaned += 1
  bytes += diff
end

puts "\n----------------------------\n"
puts "Done. Stats: #{cleaned} files cleaned. #{bytes} bytes removed\n"
