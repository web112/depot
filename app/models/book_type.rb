class BookType < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :name, :presence => true, :uniqueness => true
  
  def BookType.GetTypeNames
    type_names = []
    BookType.all.each do
      |type|
      type_names << type.name
    end
    
    type_names
  end
  
end
