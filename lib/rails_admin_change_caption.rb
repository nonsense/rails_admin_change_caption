require "rails_admin_change_caption/engine"

module RailsAdminChangeCaption
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class ChangeCaption < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            @response = {}

            if request.post?

              captions = params[:bulk_ids].zip params[:photo_caption]

              captions.each do |caption|
                id = caption[0]
                text = caption[1]

                p = Photo.find(id)
                p.caption = text
                p.save
              end
            end

            redirect_to :back
          end
        end
      end
    end
  end
end

