class PositionsController < ApplicationController
  before_action :logged_in_user
  def add_position

  end

  def add_file
    render 'add_file'
  end

  def upload_file
    positionfile = upload_file_params['filename']
    if positionfile != nil
      data = ""
      File.open(positionfile, "r").each_line do |line|
        data = line.split(',')
        position = Position.create(user_id: current_user.id,
                                   lat: data[0].to_f,
                                   lon: data[1].to_f,
                                   recdate: Date.parse(data[2]),
                                   power: data[3].to_i)
      end
      flash[:success] = data
    else
      flash[:warning] = "ブ〜"
    end

    render 'add_file'
  end

  private
  def upload_file_params
    params.require(:uploadpositionfile).permit(:filename)
  end
end
