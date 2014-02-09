module ActionController
  module Rescue
    private

    def process_action(*args)
      super
    rescue Exception => exception
        Mdbe.halt(exception)
        exception.__resume
    end
  end
end
