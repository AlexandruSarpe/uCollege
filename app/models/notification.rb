class Notification < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :description

    enum status:{active: 1,archived:0}
end
