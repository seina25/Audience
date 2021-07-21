class Members::LineNoticesController < ApplicationController
  def client
  end

  def recieve
  end

  def about
    @today = Date.current.to_time.to_datetime
    @onair_day = Program.find(params[:program_id]).start_datetime
  end
end
