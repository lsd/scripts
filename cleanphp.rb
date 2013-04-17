# Quick script to disinfect every file listed in 'dirty_files.txt'
#
# Removes the annoying eval(base64_decode("DQ..."); PHP worm
# Scan a directories recursively. Backups autoamatic. It copies
# .php to .php.dirty. You can use the
# `find` command to generate a list of suspicious files. (See Usage)
#
# BACKUP YOUR OWN DIR BEFORE RUNNING THIS!
#
# PREREQ:
#
#
# dirty_files.txt# TODO move to /tmp/
#
# USAGE:
#
#cd Sites/
#wget http://github.com/lsd/scripts/cleanphp.rb
#find . -name '*.php > dirty_files.txt
#
# This builds a list of files to be scanned. By
# default, this is every .php file that is 600 bytes or
# bigger. Edit list and/or begin scanning:
#
#vim dirty_files.txt
#
#ruby ./cleanphp.wp
#
#

infected = 'dirty_files.txt'
oxyclean = 'perl -pi -e \'s/eval\(base64_decode\("D.*?"\)\);//g\''

unless File.exists? infected
  puts "NOT FOUND - All infected files should be in #{infected}"
  exit
end

puts "\nStarting (cleanser is #{oxyclean} \"file.php\")\n\n"

bytes = 0
cleaned = 0
failed = []

IO.foreach(infected) do |f|
  begin
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
  rescue
    failed << f
  end
end

puts "FIN.\n----------------------------\n"
puts "Stats: #{cleaned} files cleaned. #{bytes} bytes removed\n"
puts "Failed to read/fix #{failed.size} files. Some of the failed files:"
puts failed[rand(0...failed.size)]
puts failed[rand(0...failed.size)]
puts failed[rand(0...failed.size)]
puts failed[rand(0...failed.size)]
puts failed[rand(0...failed.size)]
puts failed[rand(0...failed.size)]
