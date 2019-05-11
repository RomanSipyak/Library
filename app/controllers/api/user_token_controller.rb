module Api
  class UserTokenController < Knock::AuthTokenController
    # Necessary in order to use knox with devise
    # Without this line protection from CORS will strike you
    protect_from_forgery except: :create
  end
end
