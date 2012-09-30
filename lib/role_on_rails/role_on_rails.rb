require 'role_on_rails/role_subject'
require 'role_on_rails/role_context'

module RoleOnRails

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def role_subject
      has_many :role_assignments, :dependent => :destroy
      include RoleOnRails::RoleSubject::InstanceMethods
      extend RoleOnRails::RoleSubject::SingletonMethods
    end

    def role_context
      belongs_to :role_assignment, :as => :context, :dependent => :destroy
      include RoleOnRails::RoleContext::InstanceMethods
      extend RoleOnRails::RoleContext::SingletonMethods
    end
  end

end

