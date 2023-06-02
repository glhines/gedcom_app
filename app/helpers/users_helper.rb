module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    # gravatar_image_tag(user.email.downcase, :alt => user.name,
    #                                         :class => 'gravatar',
    #                                         :gravatar => options)
    hash = Digest::MD5.hexdigest(user.email.downcase)
    image_tag("https://www.gravatar.com/avatar/#{hash}", :alt => user.name,
                                                         :class => 'gravatar',
                                                         :size => options[:size].to_s)
  end
end
