module LetsgoHelper
  def letsgo_icon_class(letsgo)
    case letsgo.tag
    when "Eat/Drink"
      "fork27.png"
    when "Play"
      "play48.png"
    when "Listen/Watch"
      "entry.png"
    when "Explore"
      "binoculars18.png"
    when "Other"
      "calendar146.png"
  end
end
 
  def letsgo_icon(letsgo)
    content_tag(:span, "", class: letsgo_icon_class(letsgo) )
  end
end