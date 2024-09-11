class DashboardsController < ApplicationController
  def show
    @events = Event.order(:started_at).as_json()
  end
end
