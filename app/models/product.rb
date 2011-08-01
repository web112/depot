class Product < ActiveRecord::Base
  
  default_scope :order => 'title'
  
  has_many :line_items, :dependent => :destroy
  has_many :orders, :through => :line_items
  
  belongs_to :shop
  
  
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => 
  {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPC or PNG image.'
  }
  
  before_destroy :ensure_not_referenced_by_any_line_item_in_orders
  
  def ensure_not_referenced_by_any_line_item_in_orders
    
    line_items.each do
      |item|
      if item.order != nil
        return false
      end
    end

    return true;
=begin
    if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Item present"
      return false
    end
=end
    
  end
  
end
