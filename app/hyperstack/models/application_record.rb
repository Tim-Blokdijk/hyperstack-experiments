module ActiveRecord
  module Associations
    class AssociationReflection
      def initialize(owner_class, macro, name, options = {})
        owner_class.reflect_on_all_associations << self
        @owner_class = owner_class
        @macro =       macro
        @options =     options
        # use pluralize rather than simple removal of trailing 's' on the name.  https://github.com/hyperstack-org/hyperstack/issues/88
        @klass_name =  options[:class_name] || (collection? && name.camelize.singularize) || name.camelize
        @association_foreign_key = options[:foreign_key] || (macro == :belongs_to && "#{name}_id") || "#{@owner_class.name.underscore}_id"
        @source = options[:source] || @klass_name.underscore if options[:through]
        @attribute = name
      end
      def find_inverse
        klass.reflect_on_all_associations.each do |association|
          next if association.association_foreign_key != @association_foreign_key
          next if association.klass != @owner_class
          next if association.attribute == attribute
          return association if klass == association.owner_class
        end
        # instead of raising an error go ahead and create the inverse relationship if it does not exist.
        # https://github.com/hyperstack-org/hyperstack/issues/89
        if macro == :belongs_to
          Hyperstack::Component::IsomorphicHelpers.log "**** warning dynamically adding relationship: #{klass}.has_many :#{@owner_class.name.underscore.pluralize}, foreign_key: #{@association_foreign_key}", :warning
          klass.has_many @owner_class.underscore.pluralize, foreign_key: @association_foreign_key
        else
          Hyperstack::Component::IsomorphicHelpers.log "**** warning dynamically adding relationship: #{klass}.belongs_to :#{@owner_class.name.underscore}, foreign_key: #{@association_foreign_key}", :warning
          klass.belongs_to @owner_class.underscore, foreign_key: @association_foreign_key
        end
      end
    end
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  regulate_scope all: true
end