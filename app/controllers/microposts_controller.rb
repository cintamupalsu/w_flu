class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        
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
        end
        
        if @micropost.save
            flash[:success] = "日記を書きました"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'freeaccess_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "ノートを削除しました"
        redirect_to request.referrer || root_url
    end

    private

    def micropost_params
        params.require(:micropost).permit(:content)
    end

    def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
    end

   
end
