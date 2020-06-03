module HashtagsHelper
  def hashtag_links(hashtags)
    arr = []
    hashtags.each do |h|

      if h.text? && h.text_eng?
        arr << h.text
        arr << h.text_eng
      elsif h.text? && h.text_eng.nil?
        arr << h.text
      elsif h.text.nil? && h.text_eng?
        arr << h.text_eng
      end
    end
    arr
  end
end
