class Role
  attr_reader :id, :name, :symbol

  unless const_defined?("LIST")
    # NOTE: DO NOT CHANGE IDs
    TEACHING_ASSISTANT              = [1, :teaching_assistant]                # internal, course-related
    PUBLIC_DISCUSSION_ADMINISTRATOR = [2, :public_discussion_administrator]
    TEACHER                         = [3, :teacher]                           # internal, course-related
    STUDENT                         = [4, :student]                           # internal, course-related
    SCHOOL_ADMINISTRATOR            = [5, :school_administrator]
    GENERAL_SCHOOL_ADMINISTRATOR    = [6, :general_school_administrator]
    GENERAL_COURSE_ADMINISTRATOR    = [7, :general_course_administrator]
    GENERAL_ADMINISTRATOR           = [8, :general_administrator]
    GENERAL_OBSERVER                = [9, :general_observer]

    LIST = [
      TEACHING_ASSISTANT,
      TEACHER,
      STUDENT,

      GENERAL_ADMINISTRATOR,
      GENERAL_COURSE_ADMINISTRATOR,
      GENERAL_OBSERVER,
      PUBLIC_DISCUSSION_ADMINISTRATOR,
      GENERAL_SCHOOL_ADMINISTRATOR,
      SCHOOL_ADMINISTRATOR
    ]
  end

  def initialize(id)
    row = LIST.assoc(id.to_i)
    if row
      @id     = row[0]
      @symbol = row[1]
      @name   = I18n.t("admin.roles.names.#{row[1]}")
    end
  end

  def self.ids_for(symbols)
    symbols = [symbols].compact unless symbols.is_a?(Array)
    symbols.map(&:to_sym).inject([]) do |result, symbol|
      role = LIST.rassoc(symbol)
      result << role[0] unless role.nil?
      result
    end
  end

  def self.list
    LIST.map { |l| Role.new(l[0]) }
  end

  def self.assignable_list
    LIST.map { |l| Role.new(l[0]) unless [1,3,4].include? l[0] } .compact
  end
end

