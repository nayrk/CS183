#!/usr/bin/ruby

#usage function
def usage(error,code)
	$stderr.puts "Error: #{error}"
	exit code
end

if ARGV.length == 0
	usage("Please enter an argument", 1)
end

if !File.exists?(ARGV[0])
	usage("File does not exist", 1)
end

if !File.file?(ARGV[0])
	usage("That is not a regular file", 1)
end

passFile = File.open(ARGV[0], "r")

#Username Array
userName = Array.new

#UID Array
uid = Array.new

#File line Array
itself = Array.new

passFile.each do |line|
	#3 groups: line itself, username, and uid
	if line =~ /(([a-z]+):[x|\*]:(\d+):\d+:[a-zA-Z\- ]*:[a-z\/]+:[a-z\/]+)/
		itself.push $1
		userName.push $2		
		uid.push $3		
	else
		usage("Format not correct", 1)
	end
end

#Bool to exit with code 2 if it gets flagged
exit2 = false

for i in (0..userName.length - 1)
	for j in (i..userName.length - 1)
		if userName[i] == userName[j] and i != j
			$stderr.puts "DUP_USERNAME #{itself[i]}"
			$stderr.puts "DUP_USERNAME #{itself[j]}"
			exit2 = true
		end
	end
end

for i in (0..uid.length - 1)
	for j in (i..uid.length - 1)
		if uid[i] == uid[j] and i != j
			$stderr.puts "DUP_UID #{itself[i]}"
			$stderr.puts "DUP_UID #{itself[j]}"
			exit2 = true
		end
	end
end

if exit2 == true
	exit 0
end
