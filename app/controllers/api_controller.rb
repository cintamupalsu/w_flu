class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    reportsheetid = params[:rsid]
    memostr = params[:memo]

    # get Latitude and Longitude
    lats = []
    lons = []
    timeStamps = []

    idostr = params[:idostr]
    if idostr != nil
      idokeistr = idostr.split(",")
      counter = 0
      idokeistr.each do |ik|
        if counter%3 == 0
          lats.push ik.to_f
        elsif counter%3 == 1
          lons.push ik.to_f
        elsif counter%3 == 2
          timeStamps.push Date.parse(ik)
        end
        counter += 1
      end
    end
    # --

    if lats.count !=0 && lats.count == lons.count
      memostr = params[:memo]
      user = User.find_by(remember_digest: apikey)
      position = Position.where("user_id=?", user.id).last
      if user != nil && user.email == user_email
        if reportsheetid.to_i == 0
          reportsheet = Reportsheet.create(user_id: user.id, comment: memostr)
          position = Position.where("user_id=?", user.id).last
          (0..lats.count-1).each do |i|
            if position != nil
              if timeStamps[i] > position.recdate
                Position.create(reportsheet_id: reportsheet.id, lat: lats[i], lon: lons[i], recdate: timeStamps[i], user_id: user.id)
              end
            else
              Position.create(reportsheet_id: reportsheet.id, lat: lats[i], lon: lons[i], recdate: timeStamps[i], user_id: user.id)
            end
          end
          responseInfo = {status: 201, developerMessage: "#{reportsheet.id}"}
          metadata = {responseInfo: responseInfo}
          jsonString = {metadata: metadata, results: []}
        else
          reportsheet = Reportsheet.find(reportsheetid.to_i)
          if reportsheet != nil
            reportsheet.delay.add_geoposition(lats, lons, timeStamps, user.id, reportsheetid.to_i)
            #add_geoposition(lats, lons, timeStamps, user.id, reportsheetid.to_i)
          end
          responseInfo = {status: 200, developerMessage: "OK"}
          metadata = {responseInfo: responseInfo}
          jsonString = {metadata: metadata, results: []}
        end
        render json: jsonString.to_json
      else
        jsonMsg(501, "Authentication Failed", [])
      end
    else
      jsonMsg(502, "Data series unmatch", [])
    end
  end

  def postposition
    email = params[:email]
    apikey = params[:apikey]
    positionString = params[:positions]
    user = User.find_by(remember_digest: apikey)
    if user != nil && user.email == email
      Reportsheet.create(user_id: user.id, comment: positionString)
      responseInfo = {status: 200, developerMessage: "OK"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: []}
      render json: jsonString.to_json
    else
      responseInfo = {status: 500, developerMessage: "Failed"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: []}
      render json: jsonString.to_json
    end
  end
# http://localhost:3000/api/idokeireport?email=maulanamania@gmail.com&apikey=$2a$12$zP1fvP/lBZfvcC3dX9Y6oOyjKldilF9WqWGqu6UfmL2O49H/HdMKq&idostr=1.2343,2.3434,2020/6/30,1.2346,3.2434,2020/7/1&memo=testing

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
