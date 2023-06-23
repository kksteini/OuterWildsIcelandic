require 'rexml/document'

puts "Loading words"
$f = File.open("uniquer.txt", "r").readlines.collect{|v| v.chomp}.sort
puts "Loading complete"

$reasons = []
$processed = 0

def process_element(element)
  # If the name of this element ends with 'entry', print its text
  if element.name.end_with?('entry') || element.name.end_with?('Entry')
    $processed += 1
    if not element.elements['value'].nil? then
      clean_text = element.elements['value'].to_s[7..-9].gsub('\n', " ").gsub(/&lt.*?&gt;/, '').gsub(/[ 0123456789—\\“”…;:()"';,\.!?]/, "").downcase
      reasons = clean_text.split(" ").select{|v| !$f.include? v}

      unless reasons.length.zero? then 
        puts "Offender: #{clean_text}"
        #puts "Reasons: #{reasons}"
        reasons.each do |reason|
          $reasons.push(reason) unless $reasons.include? reason
        end

        puts "Reasons so far: #{$reasons}"
      end
    end
    puts "Have processed #{$processed} of around 3000" if $processed % 100 == 0
 end

  # Recursively process each child of this element
  element.elements.each do |child|
    process_element(child)
  end
end

# Load the XML file
file = File.new("Translation.xml")  # replace with your xml file path
doc = REXML::Document.new(file)

# Process the root element
process_element(doc.root)

