module ApplicationHelper
  def full_title page_title
    base_title = t "title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def toastr_flash
    flash_script = flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type.eql? "notice"
      type = "error" if type.eql? "alert"
      text = "toastr.#{type}('#{message}');"
      flash_messages << text if message
    end
    javascript_tag flash_script.join("\n")
  end
end
