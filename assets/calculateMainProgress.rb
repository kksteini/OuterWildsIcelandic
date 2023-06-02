require 'rexml/document'

$total = 0
$hits = 0

def levenshtein_distance(str1, str2)
  return if str1.nil? || str2.nil?
  return str2.length if str1.empty?
  return str1.length if str2.empty?

  matrix = Array.new(str1.length + 1) { Array.new(str2.length + 1) }

  (0..str1.length).each { |i| matrix[i][0] = i }
  (0..str2.length).each { |j| matrix[0][j] = j }

  (1..str1.length).each do |i|
    (1..str2.length).each do |j|
      cost = (str1[i - 1] == str2[j - 1]) ? 0 : 1
      matrix[i][j] = [
        matrix[i - 1][j] + 1,
        matrix[i][j - 1] + 1,
        matrix[i - 1][j - 1] + cost
      ].min
    end
  end

  matrix[str1.length][str2.length]
end

def process_element(element)
  # If the name of this element ends with 'entry', print its text
  if element.name.end_with?('entry') || element.name.end_with?('Entry')
    return if element.elements['key'].nil? || element.elements['value'].nil? || element.elements['key'].text.nil? || element.elements['value'].text.nil?
    unless levenshtein_distance(element.elements['key'].text, element.elements['value'].text) < element.elements['key'].text.length / 2 || element.elements['key'].text.include?(element.elements['value'].text)
      $hits += 1
    end
    $total += 1
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

puts "Total: #{$total}"
puts "Hits: #{$hits}"
puts "Percentage: #{$hits.to_f / $total.to_f * 100.0}"
