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
        @generator = get_generator
    end

    def edit
        @generator = get_generator
    end

    def update
        @generator = get_generator
    
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
    
    def get_generator
        Generator.find(params[:id])
    end
end
