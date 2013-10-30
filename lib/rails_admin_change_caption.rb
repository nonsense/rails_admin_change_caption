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

              ids = params[:bulk_ids]

              ids.each do |id|
                text = params[("photo_caption_" + id.to_s).to_sym]

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

