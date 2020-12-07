BAG_LINES = File.readlines('day7_input.txt').map{ |line| line.chomp.gsub(/ bags?|[.]/, '') }
bag_rules = { }

BAG_LINES.each do |line|
  rule = line.split(" contain ")
  bag = rule.first.to_sym
  bag_rules[bag] = []
  
  rule[1].split(",").each do |b|
    m = b.match(/^ ?(\d+) (\w+ \w+)$/)
    bag_rules[bag] << [m[2].to_sym, m[1].to_i] unless m.nil?  
  end
end

# Part 1
def containing_bag_count(rules, target_bag)
  used = {}
  counts = {}
  rules.keys.each { |k| counts[k] = 0; used[k] = false }
  
  bag_count_rec = lambda do |bag|
    return 0 if rules[bag].empty?
	return 1 if bag == target_bag
		
	count = 0
    rules[bag].each do |b|
	  count += used[b.first] ? count[b.first] : b[1] * bag_count_rec.call(b.first)
	  
	  counts[b] = count
	  used[b] = true
    end
	
	count
  end
  
  rules.keys.select { |k| k != target_bag }.map { |k| bag_count_rec.call(k) }.select { |c| c > 0 }.length
end
puts "#{containing_bag_count(bag_rules, :"shiny gold")}"

# TODO: Part 2