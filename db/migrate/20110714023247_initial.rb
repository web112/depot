class Initial < ActiveRecord::Migration
  def self.up
	Product.create(:title => 'Web Design for Developers',
	:description => 
    %{<p>
        <em>Web Design for Developers</em> will show you how to make your
        web-based application look professionally designed. We'll help you
        learn how to pick the right colors and fonts, avoid costly interface
        and accessibility mistakes -- your application will really come alive.
        We'll also walk you through some common Photoshop and CSS techniques
        and work through a web site redesign, taking a new design from concept
        all the way to implementation.
      </p>},
	:image_url =>   '/images/wd4d.jpg',    
	:price => 42.95)
	# . . .
	
  end

  def self.down
  
  end
end