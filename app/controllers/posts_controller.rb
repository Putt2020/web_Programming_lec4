class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  #before_action :set_user
  before_action :logged_in

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    if @post.user_id != session[:user_id]
      redirect_to posts_path, notice: "That is not your post sir, yours user id is #{session[:user_id]}"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if @post.user_id != session[:user_id]
      redirect_to posts_path, notice: "That is not your post sir, yours user id is #{session[:user_id]}"
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    if post_params[:user_id].to_i != session[:user_id]
      redirect_to userPost_path, notice: "That is not your user id sir, yours user id is #{session[:user_id]}"
    else
      respond_to do |format|
        if @post.save
          format.html { redirect_to userPost_path, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @test = post_params[:user_id]
    if post_params[:user_id].to_i != session[:user_id]
      redirect_to post_path(@post), notice: "That is not your user id sir, yours user id is #{session[:user_id]}"
    else  
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_path(@post), notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.user_id != session[:user_id]
      redirect_to posts_path, notice: "That is not your post sir, yours user id is #{session[:user_id]}"
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to userPost_path, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  #def userPost
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in
      if(session[:user_id])
        @user = User.find_by(id: session[:user_id])
        return true
      else
        redirect_to main_path, notice: "you did not login"
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end

#    def set_user
#      @user = User.find_by(id: session[:user_id])
#    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
end

