module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Uncle Lloyd", :class => "round")
  end

  def app_name
    "Uncle Lloyd"
  end

  # Return a title on a per-page basis.
  def title
    base_title = app_name
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
