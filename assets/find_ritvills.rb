require 'rexml/document'

puts "Loading words"
$f = File.open("uniquer.txt", "r").readlines.collect{|v| v.chomp}.sort
puts "Loading complete"

def process_element(element)
  # If the name of this element ends with 'entry', print its text
  if element.name.end_with?('entry') || element.name.end_with?('Entry')
    if not element.elements['value'].nil? then
      clean_text = element.elements['value'].to_s[7..-9].gsub(/&lt;.*?&gt;/, '').gsub(/["',\.!?]/, "").downcase
      reasons = clean_text.split(" ").select{|v| !$f.include? v}

      unless reasons.length.zero? then 
        puts "Offender: #{clean_text}"
        puts "Reasons: #{reasons}"
      end
    end
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

