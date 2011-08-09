class News < ActiveRecord::Base
  validates :title, :abstraction, :content, :presence => true
end
