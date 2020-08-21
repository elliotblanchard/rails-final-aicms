class DocumentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if admin?
            @documents = Document.all
        else
            if user_found?
                @documents = @user.documents
            else
                @documents = current_user.documents
            end
        end
    end

    def generated_length
        if admin?
            @documents = Document.all.generated_length
        else
            if user_found?
                @documents = @user.documents.generated_length
            else
                @documents = current_user.documents.generated_length
            end
        end
    end

    def new
        @generators = Generator.all
        if user_found?
            @document = @user.documents.build
        else
            @document = Document.new
        end
    end    

    def create
        @generator = Generator.find(params[:generator][:id])
        params[:document][:generator_id] = params[:generator][:id]
        params[:document][:user_id] = current_user.id
        params[:document][:generated_response] = @generator.generator_request(params[:document]) #Call the API to generate the document content
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
    
    def user_found?
       true if (params[:user_id]) && (@user = User.find_by_id(params[:user_id]))
    end
end
