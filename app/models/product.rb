class Product < ActiveRecord::Base
  default_scope :order => 'title'

  has_many :line_items, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :orders, :through => :line_items
  has_and_belongs_to_many :book_types

  belongs_to :shop

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :image_url, :format =>
  {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => I18n.t('image_url')
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
  end

  def uploaded_image= (file_field)
    now = Time.now
    @file_name =  now.strftime("%y%m%d%H%M%S") + '_' + sanitize_filename(file_field.original_filename)

    self.image_url = "user_files/product_images/"+@file_name

    if !file_field.original_filename.empty? and file_field.content_type.chomp =~ /gif|jpeg|png/
      File.open("public/images/user_files/product_images/"+@file_name,"wb+") do |f|
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

  def search(keyStr)
    keyArr = keyStr.split(" ")
    #key 1
    if(keyArr.length == 1)
      search_items = Product.find(:all, :conditions => "title like '%#{keyArr[0]}%'")
    elsif(keyArr.length > 1)
      sql="%"+keyArr.join("%")+"%"
      search_items = Product.find(:all, :conditions => "title like '#{sql}'")

      sql2="title like '%"+keyArr.join("%' or title like '%")+"%'"
      search_items2 = Product.find(:all,:conditions => "#{sql2}") - search_items

    search_items = search_items + search_items2
    end
    search_items
  end

end

