class StatusUpdatesController < ApplicationController
  def index
    @status_updates = StatusUpdate.first(20)
  end
end
