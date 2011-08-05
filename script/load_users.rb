User.transaction do
    User.create(:name => "admin", :hashed_password=>"admin", :salt=>"admin",
                :role => "administrator") 
end