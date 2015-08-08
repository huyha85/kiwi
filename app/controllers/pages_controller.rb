class PagesController < ApplicationController
  before_filter :set_tab

  def home
  end

  def contact
  end

  private
  def set_tab
    @tab = action_name
  end
end
