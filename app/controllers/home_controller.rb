# frozen_string_literal: true

#:nodoc:
class HomeController < ApplicationController
  def index
    @weather = Weather.details(params)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
