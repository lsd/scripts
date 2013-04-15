# Quick script to disinfect every file listed in 'dirty_files.txt'
# Removes the annoying eval(base64_decode("DQ..."); PHP worm
#
# Make backups before running this!

infected = 'dirty_files.txt'

unless File.exists? infected
  p "NOT FOUND - All infected files should be in #{infected}"
  exit
end

p "Starting..."

total = 0

IO.foreach(infected) do |f|
  f.chop!
  before = File.size(f)

  %x(sed -i '' 's/eval(base64_decode("D.*"));//g' #{f})

  diff = before - File.size(f)
  p "#{diff} bytes removed from #{f}"

  p %x(php -l #{f})

  total += diff
end

p "done. In total: (#{total}) bytes removed"
