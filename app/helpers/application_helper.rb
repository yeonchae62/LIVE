# frozen_string_literal: true

module ApplicationHelper
  # Checks if the given path is the current page
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end
end
