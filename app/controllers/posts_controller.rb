class PostsController < ApplicationController

    before_action :authenticate_user!, :only => [:new, :create]

    def new
        @group = Group.find(params[:group_id])
        @post = Post.new
    end

    def create
        @group = Group.find(params[:group_id])
        @post = Post.new(post_params)
        @post.group = @group
        @post.user = current_user

        if @post.save
          flash[:success] = "Object successfully created"
          redirect_to group_path(@group)
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end
end
