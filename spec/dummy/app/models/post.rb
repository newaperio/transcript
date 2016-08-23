class Post < ApplicationRecord
  include Transcript::Receiver
end
