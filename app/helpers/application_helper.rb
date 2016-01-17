# -*- coding: utf-8 -*-
module ApplicationHelper

  def logged_in?
    !session[:user_id].nil?
  end

  def active_menu(path)
    request.original_fullpath == path ? 'active' : ''
  end

  def dl
    '➤'
  end

  def glyph(sym)
    icons = {
      :records  => 'th-list',
      :projects => 'list-alt',
    }
    icons[sym.to_sym]
  end

  def side_menu
    html = ''
    %w(projects records).each do |m|
      active, span = '', ''
      if request.original_fullpath.include? m
	active = ' class="active"'
	span = ' <span class="sr-only">(current)</span>'
      end
      link = link_to raw("<span class='glyphicon glyphicon-#{glyph(m)}' aria-hidden='true'></span> &nbsp;#{m.titleize}#{span}"), send("#{m}_path")
      html << "<li#{active}>#{link}</li>"
    end
    raw html
  end

end
