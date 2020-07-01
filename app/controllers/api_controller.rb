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
        jsonMsg(201, "OK", [])
      else
        jsonMsg(300, "Password confirmation needed", [])
      end
    else
      jsonMsg(500, "User not found or password didn't match", [])
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
        heatPoint.power = (0.533 * (15.0-(Time.zone.now.to_date - heatPoint.recdate.to_date).to_f)).to_i+1
      end

      responseInfo = {status: 200, developerMessage: "OK"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: heatPoints}
      #jsonMsg(200, 0K, heatPoints)
      render json: jsonString.to_json
    else
      heatPoints = []
      jsonMsg(501, "Authentication Failed", heatPoints)
      #responseInfo = {status: 501, developerMessage: "Authentication Failed"}
      #metadata = {responseInfo: responseInfo}
      #jsonString = {metadata: metadata, results: []}
      #render json: jsonString.to_json
      ##jsonMsg(501, "Authentication error")
    end
  end

  def idokeireport
    apikey = params[:apikey]
    user_email = params[:email]
    idostr = params[:idostr]
    memostr = params[:memo]
    user = User.find_by(remember_digest: apikey)
    if user != nil && user.email == user_email

    else

    end
  end

  private

  def login_params

  end

  def jsonMsg(errNum, errMessage, result)
    responseInfo ={status: errNum, developerMessage: errMessage}
    metadata = {responseInfo: responseInfo}
    jsonString = {metadata: metadata, results: result}
    render json: jsonString.to_json
  end


end
