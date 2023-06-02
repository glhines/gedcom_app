# == Schema Information
#
# Table name: gedcoms
#
#  id                  :integer         not null, primary key
#  gedcom_file_name    :string(255)
#  gedcom_file_size    :integer
#  gedcom_content_type :string(255)
#  gedcom_updated_at   :datetime
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Gedcom < ActiveRecord::Base

  belongs_to :user

  # attr_accessible  :gedcom, :gedcom_file_name, :gedcom_content_type,
  #   :gedcom_file_size, :gedcom_updated_at

  # Paperclip config 
  #has_attached_file :gedcom, 
  #  :styles => {:text => { :quality => :better } }, 
  #  :processors => [:gedcom_parser],
  #  :storage => :s3,
  #  :s3_credentials => "#{Rails.root}/config/s3.yml",
  #  :path => "/:style/:id/:filename",
  #  :url => ":s3_path_url"
    
  #validates_attachment :gedcom, content_type: "application/octet-stream"

  # Paperclip callback 
  #before_post_process :cancel_post_processing

  private

    def cancel_post_processing
      # Returning 'false' will cancel Paperclip post-processing
      false
    end

end
