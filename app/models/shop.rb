class Shop < ActiveRecord::Base
  def uploaded_image= (file_field)
    now = Time.now
    @file_name =  now.strftime("%y%m%d%H%M%S") + '_' + sanitize_filename(file_field.original_filename)

    self.image_url = "user_files/shop_images/"+@file_name

    if !file_field.original_filename.empty? and file_field.content_type.chomp =~ /gif|jpeg|png/
      File.open("public/images/user_files/shop_images/"+@file_name,"wb+") do |f|
        f.write(file_field.read)
      end
    end
  end

  def sanitize_filename(filename)
    filename = File.basename(filename.gsub("\\", "/")) # work-around for IE
    filename.gsub!(/[^a-zA-Z0-9\.\-\+_]/,"_")
    filename = "_#{filename}" if filename =~ /^\.+$/
    filename = "unnamed" if filename.size == 0
    filename
  end
  
  has_many :users, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :orders
  
  
  validates :name, :email, :telephone, :image_url, :description, :presence => true
  
  validates :name, :presence => true
  validates :image_url, :format =>
  {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPC or PNG image.'
  }

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
