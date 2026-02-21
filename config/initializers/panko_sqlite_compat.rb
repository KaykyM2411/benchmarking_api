unless defined?(ActiveRecord::ConnectionAdapters::PostgreSQL)
  module ActiveRecord
    module ConnectionAdapters
      module PostgreSQL
        module OID
          class DateTime
          end

          class Json
          end

          class Jsonb
          end
        end
      end
    end
  end
end
