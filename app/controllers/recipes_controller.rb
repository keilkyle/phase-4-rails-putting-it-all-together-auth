class RecipesController < ApplicationController
   
def index
    if session[:user_id]
        recipes = Recipe.all
        render json: recipes
    else
        render json: {errors: ["error"]}, status: :unauthorized
    end
end

def create
    user = User.find_by(id: session[:user_id])
    if session[:user_id]
        recipe = user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    else
        render json: {errors: ["error"]}, status: :unauthorized
    end
end

private
def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user)
end

end
