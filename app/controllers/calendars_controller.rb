class CalendarsController < ApplicationController
  def index
    selDate = params[:selDate]
    if selDate == nil || selDate == ""
      currentDate = DateTime.now
    else
      currentDate = Date.parse selDate
    end
    @month = currentDate.strftime("%m").to_i
    @year = currentDate.strftime("%Y").to_i
    firstday = currentDate.strftime("%y/%m/")+"1"
    @fday = Date.parse firstday
    daystr = @fday.strftime("%a")

    day = 0
    pmday = 0

    @box = Array.new(42)

    case @month
    when 2
      if @year%4 == 0
        day = 29
      else
        day = 28
      end
      pmday = 31
    when 4,6,9,11
      day = 30
      pmday = 31
    when 1,5,7,10,12
      day = 31
      pmday = 30
    when 8
      day = 31
      pmday = 31
    else
      day = 31
      if @year%4 == 0
        pmday = 29
      else
        pmday = 28
      end
    end

    startcount = 0
    case daystr
    when "Mon"
      @box[0] = "" #pmday
      startcount = 1
    when  "Tue"
      @box[0] = "" #pmday-1
      @box[1] = "" #pmday
      startcount = 2
    when "Wed"
      for i in 0..2 do
        @box[i] = "" #pmday - (2 - i)
      end
      startcount = 3
    when "Thu"
      for i in 0..3 do
        @box[i] = ""#pmday - (3 - i)
      end
      startcount = 4
    when "Fri"
      for i in 0..4 do
        @box[i] = ""#pmday - (4 - i)
      end
      startcount = 5
    when "Sat"
      for i in 0..5 do
        @box[i] = "" #pmday - (5 - i)
      end
      startcount = 6
    else
      startcount = 0
    end


    counter = 0
    for i in startcount..41 do
      counter += 1
      @box[i] = counter
      if counter > day
        #counter = 1
        @box[i] = ""
      end
    end
    @test = @month
  end
end
