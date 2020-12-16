class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    #user_id = params[:id].to_i
    #user_email = params[:email]
    #apikey = params[:apikey]
    #password = params[:password]
    user_id = login_params['id'].to_i
    user_email = login_params['email']
    apikey = login_params['apikey']
    password = login_params['password']

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
    #apikey = params[:apikey]
    #user_email = params[:email]
    apikey = heatmap_params['apikey']
    user_email = heatmap_params['email']

    user = User.find_by(remember_digest: apikey)
    if user != nil && user.email == user_email
      from_date = Time.zone.now.to_date - 14.days
      heatPoints = Position.select("id, lat, lon, recdate, power, reportsheet_id").where("DATE(recdate)>='#{from_date.to_date}'")
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

  def getcomment
   
    email = getcomment_params['email']
    apikey = getcomment_params['apikey']
    reportsheetid =getcomment_params['id']

    user = User.find_by(remember_digest: apikey)
    if user.email == email
      reportsheet = Reportsheet.find(reportsheetid.to_i)
      jsonMsg(200, reportsheet.comment, [])
    else
      jsonMsg(501, "Authentication Failed", [])
    end
  end

  def postposition
   
    email = postposition_params['email']
    apikey = postposition_params['apikey']
    positionString = postposition_params['positions']
    comment = postposition_params['comment']
    
    user = User.find_by(remember_digest: apikey)

    lats = []
    lons = []
    timeStamps = []
    if positionString != nil
      idokeistr = positionString.split(",")
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

    if user != nil && user.email == email
      reportsheet = Reportsheet.create(user_id: user.id, comment: comment)
      reportsheet.delay.add_geoposition(lats, lons, timeStamps, user.id, reportsheet.id)
      responseInfo = {status: 200, developerMessage: "緯度経度を送りました。"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: []}
      render json: jsonString.to_json
    else
      responseInfo = {status: 500, developerMessage: "承認することができなかったです。アプリを再起動して下さい。"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: []}
      render json: jsonString.to_json
    end
  end

  def get_microposts
    # params check
    email = getmicroposts_params['email']
    apikey = getmicroposts_params['apikey']
    if getmicroposts_params['date'] == nil
      selected_date = Time.zone.now.to_date
    else
      selected_date = Date.parse(getmicroposts_params['date'])
    end
    
    user = User.find_by(remember_digest: apikey)
    if user!= nil && user.email == email
      following_ids = "SELECT follower_id FROM relationships WHERE followed_id = :user_id"  
      users = User.select("id, name").where("id = :user_id OR id IN (#{following_ids})", user_id: user.id)
      master = []
      counter =0
      users.each do |user|
        detail ={}
        detail["id"] = user.id
        detail["name"]=user.name
        detail["microposts"]=user.microposts.select("id, content, created_at, sadness, joy, fear, disgust, anger").where("DATE(created_at)>='#{selected_date.beginning_of_month}' AND DATE(created_at)<='#{selected_date.end_of_month}'")
        master[counter] = detail
        counter+=1
      end 
      responseInfo ={status: 200, developerMessage: "OK"}
      metadata = {responseInfo: responseInfo}
      jsonString = {metadata: metadata, results: master}
      render json: jsonString.to_json
    else
      jsonMsg(501, "Authentication Failed", [])
    end
  end

  def postmicropost
    #params check
    email = postmicropost_params['email']
    apikey = postmicropost_params['apikey']
    comment = postmicropost_params['comment']
    datepost = postmicropost_params['datepost']
    date = Date.parse(datepost)
    user = User.find_by(remember_digest: apikey)
    if user != nil && user.email == email
      @micropost = user.microposts.build(content: comment, created_at: datepost, updated_at: datepost)
      see_emotion = @micropost.init_emotions
      if see_emotion != "ok"
        if @micropost.init_emotions == "ja"
            #Translate Japanese to English
            project_id = "sbs-projects"
            translate = Google::Cloud::Translate.translation_v2_service project_id: project_id
            translation = translate.translate @micropost.content, to: 'en'
            originText = @micropost.content
            @micropost.content = translation.text.inspect.gsub("&#39;","'")
            @micropost.init_emotions
            @micropost.content = originText
        else 
            @micropost.init_emotions_default
        end
        if @micropost.save

          master = []
          counter = 0
          detail = {}
          detail["id"] = user.id
          detail["name"] = user.name 
          detail["microposts"] = user.microposts.select("id, content, created_at, sadness, joy, fear, disgust, anger").where("DATE(created_at)>='#{date.beginning_of_month}' AND DATE(created_at)<='#{date.end_of_month}'")
          master[counter] = detail
        
          responseInfo ={status: 200, developerMessage: "OK"}
          metadata = {responseInfo: responseInfo}
          jsonString = {metadata: metadata, results: master}
          render json: jsonString.to_json

        else
          jsonMsg(502, "Authentication Failed", [])
        end
      else
        jsonMsg(501, "Authentication Failed", [])
      end
    end
  end

  private

  def login_params
    params.permit(:id, :email, :password, :apikey)
  end

  def heatmap_params
    params.permit(:apikey, :email)
  end

  def getcomment_params
    params.permit(:email, :apikey, :id)
  end

  def getmicroposts_params
    params.permit(:apikey, :email, :date)
  end

  def postposition_params
    params.permit(:email, :apikey, :positions, :comment)
  end

  def postmicropost_params
    params.permit(:email, :apikey, :comment, :datepost)
  end

  def jsonMsg(errNum, errMessage, result)
    responseInfo ={status: errNum, developerMessage: errMessage}
    metadata = {responseInfo: responseInfo}
    jsonString = {metadata: metadata, results: result}
    render json: jsonString.to_json
  end


end
