require "simple_scrubber/version"

module SimpleScrubber
  def self.scrub(text, types=[])
    if types.include? :email
      email_re = /\b([A-Z0-9._%+-]+)@([A-Z0-9.-]+\.[A-Z]{2,4})\b/i
      text.gsub!(email_re, 'xxx@\2')
    end

    if types.include? :phone
      phone_re = /\b(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?\b/
      match = text.match phone_re
      unless match.nil?
        area_code = match[1] || match[2]
        text.gsub!(phone_re, "#{area_code}-xxx-xxxx")
      else
        text
      end
    end

    text
  end
end
