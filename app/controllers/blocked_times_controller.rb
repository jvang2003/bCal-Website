class BlockedTimesController < ApplicationController
  def index
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def show
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def new
    @calendar = Calendar.find(params[:calendar_id])
    @blocked_time = BlockedTimes.new
  end

  def update
  end
end
