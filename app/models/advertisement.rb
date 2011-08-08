class Advertisement < ActiveRecord::Base
  def uploaded_image= (file_field)
    now = Time.now
    @file_name =  now.strftime("%y%m%d%H%M%S") + '_' + sanitize_filename(file_field.original_filename)

    self.image_url = "user_files/advertisement_images/"+@file_name

    if !file_field.original_filename.empty? and file_field.content_type.chomp =~ /gif|jpeg|png/
      File.open("public/images/user_files/advertisement_images/"+@file_name,"wb+") do |f|
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
end
