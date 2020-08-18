class DocumentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if admin?
            @documents = Document.all
        else
            @documents = current_user.documents.all
        end
    end

    def new
        @document = Document.new
        @generators = Generator.all
    end    

    def create
        @generator = Generator.find(params[:generator][:id])
        params[:document][:generator_id] = params[:generator][:id]
        params[:document][:user_id] = current_user.id
        params[:document][:generated_response] = @generator.generator_request(params[:document])
        @document = Document.new(document_params)
        if @document.save
            redirect_to @document
        else
            render :new
        end
    end

    def show
        @document = Document.find_by_id(params[:id])
        unless (@document.user.id == current_user.id) || admin?
            redirect_to user_path 
        end
    end

    def destroy
        Document.find(params[:id]).destroy
        redirect_to documents_path
    end      

    private

    def document_params
        params.require(:document).permit(:name, :prompt, :length, :generated_response, :is_continuation, :start_at_beginning, :pause_at_end, :top_p, :temperature, :user_id, :generator_id)
    end    
end
