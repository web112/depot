class Product < ActiveRecord::Base
	default_scope :order => 'title'
	has_many :line_items
	has_many :orders, :through=> :line_items
	
	before_destroy :ensure_not_referenced_by_any_line_item
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true;
		else
			errors[:base] << "Line Items present"
			return false
		end
	end
	
	validates :title, :description, :image_url, :presence => true
	validates :title, :uniqueness => true
	validate :price_a_cent
	
	validates :image_url, :format => {
	:with    => %r{\.(gif|jpg|png)$}i,
	:message => 'must be a URL for GIF, JPC or PNG image.'
	}
	
	protected
	def price_a_cent
		errors.add(:price, 'should be at least 0.01' ) if price.nil? || price<0.01
	end
end
