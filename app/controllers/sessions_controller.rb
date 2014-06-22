class SessionsController < ApplicationController
  skip_before_filter :authorize_user!
  layout 'login'

  def new
  	# return redirect_to(after_user_sign_in_path) if signed_in?
  end

  def new_mobile
    render :layout=>"mobile_new"
    # return redirect_to(after_user_sign_in_path) if signed_in?
  end

  def register_mobile
    render :layout=>"mobile_new"
    # return redirect_to(after_user_sign_in_path) if signed_in?
  end

  def create
  	@return_url = params[:return_url]
  	@account = Ecstore::Account.user_authenticate(params[:session][:username],params[:session][:password])
      
      if @account
  		sign_in(@account,params[:remember_me])
             #update cart
             # @line_items.update_all(:member_id=>@account.account_id,
             #                                       :member_ident=>Digest::MD5.hexdigest(@account.account_id.to_s))
      if params[:return_url]
        return redirect_to("/m") if signed_in?
      end
  		render "create"
  	else
             
  		render "error"
  	end
  end

  def destroy
      sign_out
      # refer_url = request.env["HTTP_REFERER"]
      # refer_url = "/" unless refer_url
      if params[:platform]=="mobile"
        redirect_to "/m"
      else
        redirect_to "/"
      end

  end

end
