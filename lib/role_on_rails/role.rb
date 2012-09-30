module RoleOnRails
  module Role
    cattr_accessor :list

    def self.ids_for(symbols)
      symbols = [symbols].compact unless symbols.is_a?(Array)
      symbols.map(&:to_sym).inject([]) do |result, symbol|
        role = @@list.rassoc(symbol)
        result << role[0] unless role.nil?
        result
      end
    end

    def self.define_role(symbol, id = nil, name = nil)
      @@list ||= []
      @@list << [symbol, id || @@list.size + 1, name || I18n.t("roles.names.#{symbol}")]
    end

    def initialize(id)
      row = @@list.assoc(id.to_i)
      if row
        @id     = row[0]
        @symbol = row[1]
        @name   = I18n.t("roles.names.#{row[1]}")
      end
    end

  end
end

