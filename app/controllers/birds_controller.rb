class BirdsController < ApplicationController

  #instead of using rescue inside of the methods you can use rescue_from and if there are any errors in repsonses this method
  #will automatically run
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
    #if any of the below code in this method throw an error this rescue method will throw a response
    #you can use that instead of using an if else statement
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response
  end

  # def show
  #   bird = find_bird
  #   if bird
  #     render json: bird
  #   else
  #     render_not_found_response
  #   end
  # end

  # PATCH /birds/:id
  def update
    bird = find_bird
    bird.update(bird_params)
    render json: bird
    #if any of the below code in this method throw an error this rescue method will throw a response
    #you can use that instead of using an if else statement
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response
  end

  # def update
  #   bird = find_bird
  #   if bird
  #     bird.update(bird_params)
  #     render json: bird
  #   else
  #     render_not_found_response
  #   end
  # end

  # PATCH /birds/:id/like
  def increment_likes
    bird = find_bird
    bird.update(likes: bird.likes + 1)
    render json: bird
    #if any of the below code in this method throw an error this rescue method will throw a response
    #you can use that instead of using an if else statement
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response
  end

  # def increment_likes
  #   bird = find_bird
  #   if bird
  #     bird.update(likes: bird.likes + 1)
  #     render json: bird
  #   else
  #     render_not_found_response
  #   end
  # end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content
    #if any of the below code in this method throw an error this rescue method will throw a response
    #you can use that instead of using an if else statement
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response
  end

  # def destroy
  #   bird = find_bird
  #   if bird
  #     bird.destroy
  #     head :no_content
  #   else
  #     render_not_found_response
  #   end
  # end

  # anything that doesnt have to do with the resources routing and is a custom function is typically put as private like below
  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def find_bird
    Bird.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

end
