class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:destroy]

  # GET /stories
  def index
    @stories = Story.all
  end

  # GET /stories/1
  def show
  end

  # GET /stories/new
  def new
    # @story = Story.new
    @story = current_user.stories.build
  end

  # POST /stories
  def create
    # @story = Story.new(story_params)
    @story = current_user.stories.build(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to story_url(@story), notice: "Story was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    if @story.image.attached?
      @story.image.purge
    end
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url, notice: "Story was successfully destroyed." }
    end
  end

  def correct_user
    @story = current_user.stories.find_by(id: params[:id])
    redirect_to stories_path, notice: "Not Authorized To Edit This Story" if @story.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:line, :image, :user_id)
    end

end
