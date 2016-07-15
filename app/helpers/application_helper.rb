# -*- coding: utf-8 -*-
module ApplicationHelper

  def logged_in?
    !session[:user_id].nil?
  end

  def active_menu(path)
    request.original_fullpath == path ? 'active' : ''
  end

  def dl
    raw '&nbsp;↪&nbsp;'
  end

  def sg(glyph)
    raw "<span class=\"glyphicon glyphicon-#{glyph}\"></span>"
  end

  def glyph(sym)
    icons = {
      :records  => 'th-list',
      :projects => 'list-alt',
    }
    icons[sym.to_sym]
  end

end
