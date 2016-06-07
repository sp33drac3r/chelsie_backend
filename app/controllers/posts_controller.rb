class PostsController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @posts = @school.posts.reverse

    render :json => {
      :school => @school,
      :posts => @posts
    }
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments

    render :json => {
      :post => @post,
      :comments => @comments
    }
  end

  def create
    @post = Post.new(post_params)
    @post.school_id = params[:school_id]

    if @post.save
      render :json => @post
    end
  end

  def edit
    @post = Post.find(params[:id])

    render :json => @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render :json => @post
    end
  end

  def delete
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

end
