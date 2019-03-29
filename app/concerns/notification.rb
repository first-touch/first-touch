module Notification
  extend ActiveSupport::Concern

  included do |parent|
    validates_uniqueness_of :ref

    parent::TEMPLATED_FIELDS.each do |field|
      define_method "filled_#{field}" do |data|
        ErbTemplateHelper.render self[field], data
      end
    end
  end
end
