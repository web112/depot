class Shop < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :orders
  
  
  #validates :name, :email, :telephone, :image_url, :description, :presence => true
  
  validates :name, :presence => true

=begin
  validates :image_url, :format => 
  {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPC or PNG image.'
  }
=end
  
  
  before_destroy :ensure_not_referenced_by_any_order
  
  def ensure_not_referenced_by_any_order

    if orders.count.zero?
      return true
    else
      errors[:base] << "Order present"
      return false
    end
  end
end
