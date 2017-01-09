class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include FunctionsConcern
end
