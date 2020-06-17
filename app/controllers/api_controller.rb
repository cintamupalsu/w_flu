class ApiController < ApplicationController
  def login

    user_id = params[:id].to_i
    user_email = params[:email]
    apikey = params[:apikey]
    password = params[:password]

    user = User.find_by(email: user_email)
    if user != nil
      if user.authenticate(password)
        if user.remember_digest == nil
          user.remember
        end
        responseInfo ={status: 200, developerMessage: "OK"}
        metadata = {responseInfo: responseInfo}
        apiKey = {apikey: user.remember_digest}
        jsonString = {metadata: metadata, results: apiKey}
        render json: jsonString.to_json
      elsif user.remember_digest == apikey
        jsonMsg(201, "OK")
      else
        jsonMsg(300, "Password confirmation needed")
      end
    else
      jsonMsg(500, "User not found or password didn't match")
    end
  end



  def heatmap
    apikey = params[:apikey]
    user_email = params[:email]
    user = User.find_by(remember_digest: apikey)
    if user != nil && user.email == user_email
      from_date = Time.zone.now.to_date - 14.days

      heatPoints = Position.select("id, lat, lon, recdate, power").where("DATE(recdate)>='#{from_date.to_date}'")
      heatPoints.each do |heatPoint|
        heatPoint.power = ((15/8) * (15.0-(Time.zone.now.to_date - heatPoint.recdate.to_date).to_f)).to_i
      end
      responseInfo = {status: 200, developerMessage: "OK"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: heatPoints}
      render json: jsonString.to_json
    else
      jsonMsg(501, "Authentication error")
    end
  end

  private

  def login_params

  end

  def jsonMsg(errNum, errMessage)
    responseInfo ={status: errNum, developerMessage: errMessage}
    metadata = {responseInfo: responseInfo}
    jsonString = {metadata: metadata, results: nil}
    render json: jsonString.to_json
  end


end
