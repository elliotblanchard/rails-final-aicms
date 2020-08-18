class GeneratorsController < ApplicationController
    before_action :redirect_if_not_admin

    def index
        @generators = Generator.all
    end 

    def new
        @generator = Generator.new
    end    
    
    def create
        @generator = Generator.new(generator_params)
        if @generator.save
            redirect_to @generator
        else
            render :new
        end
    end

    def show
        @generator = Generator.find_by_id(params[:id])
    end

    def edit
        @generator = Generator.find(params[:id])
    end

    def update
        @generator = Generator.find(params[:id])
    
        if @generator.update(generator_params)
          redirect_to generator_path(@generator)
        else
          render :edit
        end      
    end  
    
    def destroy
        Generator.find(params[:id]).destroy
        redirect_to generators_path
    end      

    private

    def generator_params
        params.require(:generator).permit(:name, :api_url, :description)
    end    
end
