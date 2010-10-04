module ApplicationHelper
  def csv_to_boxes(string)
    string.to_s.split(',').map{|w| content_tag(:div, w.strip, :class => "csv_box") }.join.html_safe
  end
end

