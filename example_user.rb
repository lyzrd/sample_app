class User
  # Create getters and setters
  attr_accessor :name, :email
  
  # constructor
  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end
  
  def formatted_email
    "#{@name} <#{@email}>"
  end
end