module ApplicationHelper
  # @author: HuyenDT
  # Renders flash messages
  def render_flash_messages
    s = ''
    flash.each do |k,v|
      # v.each do |v1|
      #   s << content_tag('li', v1.html_safe)
      # end
      if v.kind_of?(Array)
        s << content_tag('div', v.join('<br/>').html_safe, :class => "flash #{k}", :id => "flash_#{k}")
      else
        s << content_tag('div', v.html_safe, :class => "flash #{k}", :id => "flash_#{k}")
      end

    end
    s.html_safe
  end

  def year_options_for_select
    year_options = Array.new
    # year_options <<["", ""]
    (1905..Time.now.year).to_a.reverse.each do |year|
      year_options << [year, year]
    end
    year_options
  end

  def normalize_text(text)
    if !text.nil?
      text = (h(text).gsub(/\n/, '<br/>')).html_safe
    end
    text
  end
end
