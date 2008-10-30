class Experience < ActiveRecord::Base
  belongs_to :user
  
  def to_s
    self.value.to_s
  end
end
