class Post < ActiveRecord::Base
  resourcify
  belongs_to :user
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON # If you use SQLite, add this line.
  
  has_many :impressions, :as=>:impressionable
 
   def impression_count
       impressions.size
   end
 
   def unique_impression_count
       # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
       # so getting keys from the hash and calculating the number of keys
       impressions.group(:ip_address).size.keys.length #TESTED
   end
   
   def self.search(search)
    where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
   end
end
