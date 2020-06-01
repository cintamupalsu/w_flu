class ApiController < ApplicationController
  def login
    #http://localhost:3000/api_key_onoff?act=1&apikey=1-gIk_N9s4XTzJihuvdSSg
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
        jsonMsg(200, "OK")
      else
        jsonMsg(300, "Password confirmation needed")
      end
    else
      jsonMsg(500, "User not found or password didn't match")
    end
  end

  def jsonMsg(errNum, errMessage)
    responseInfo ={status: errNum, developerMessage: errMessage}
    metadata = {responseInfo: responseInfo}
    jsonString = {metadata: metadata, results: nil}
    render json: jsonString.to_json
  end

  private

  def login_params

  end

end
