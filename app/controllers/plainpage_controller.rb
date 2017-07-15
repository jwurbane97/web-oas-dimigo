class PlainpageController < ApplicationController
    before_action :authenticate_user!, except: :landing
    before_action :checkPermission, only: :permission
    
    def landing
        if user_signed_in? then
            redirect_to applies_path
        end
    end
    
    def permission
        @requests = Apply.all
    end
    
    def profile
    end
    
    private
    
    def checkPermission
        unless current_user.permission then
            flash['경고'] = '잘못된 요청입니다.'
            redirect_to applies_path
        end
    end
end