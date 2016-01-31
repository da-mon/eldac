
module Colorful

  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def diff(color, diff)
      r = (color[0..1].to_i(16) * diff).to_i
      g = (color[2..3].to_i(16) * diff).to_i
      b = (color[4..5].to_i(16) * diff).to_i
      '%02x%02x%02x' % [r, g, b]
    end

    def bg_css(bg1, bg2)
      <<-EOF
      background:-webkit-linear-gradient(##{bg1}, ##{bg2}); background:-o-linear-gradient(##{bg1}, ##{bg2}); background:-moz-linear-gradient(##{bg1}, ##{bg2}); background:linear-gradient(##{bg1}, ##{bg2}); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=##{bg1}, endColorstr=##{bg2}); -ms-filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=##{bg1}, endColorstr=##{bg2});
      EOF
    end

  end

end
