class Species < ApplicationRecord
    has_many :pets

    def dispname
        self.name.capitalize
    end
end
