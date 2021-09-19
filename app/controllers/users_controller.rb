class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy userPost ] # to do set_user in show edut update and destroy

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
#    respond_to do |format|
#      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
#      format.json { head :no_content }
#    end
  end
  
  def revive
    @name = params[:name]
    @email = params[:email]
    User.create(name: @name, email: @email, birthday: DateTime.current.to_date, address: "unknown", postal_code: "unknown", pasword: "abc")
  end

  def main
    logging = params[:commit]
    @user = User.find_by(email: params[:email], password: params[:password])
    if !@user.nil?
      redirect_to user_posts_path(@user).concat("/show")
    end
    if @user.nil? && logging == "Login"
      redirect_to '/main', notice: "Either email or password is incorrect :)"
    end
  end

  def userPost

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :password)
    end
end
