module Piano
  module Helpers
    def current_user
      !session[:user].nil?
    end
  end
end
