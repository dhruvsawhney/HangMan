require 'yaml'

class Test

  def initialize(num)
    @num = num
    @arr = [1,2,3]
    @hi= "test"
  end

  # serialize the object
  def to_serialize()
    File.open("output.yml","w") {|f| f.write(self.to_yaml)}
  end

  def to_deserialize
  contents = YAML.load (File.open('output.yml'))
  # puts contents
  end

  # override the string method
  def to_s
    puts @arr.to_s
  end
end

# t = Test.new(12)
# t.to_serialize()
# t.to_deserialize()
# puts t.to_s


arr = Array.new(3)

arr.each do |i|
  puts i.class
  puts i == nil
end

str = "Dhruv\n"
str.rstrip!
puts "#{str.length}"