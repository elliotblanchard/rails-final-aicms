class DocumentsController < ApplicationController
    before_action :redirect_if_not_logged_in
end
