require 'rexml/document'

# Load the XML file
file = File.new("Translation.xml")  # replace with your xml file path
doc = REXML::Document.new(file)

y = doc.root.elements.to_a

puts y.count
last=""
blast=""
node=nil
name = ""
y.each do |element|
  begin
    name = element.name
    node = element.elements.to_a.count
    blast = element.elements['key'].text
    last = element.elements['value'].text
  rescue
    puts "#{name}"
    puts "#{node}"
    puts "#{last}"
    puts "#{blast}"
  end
end