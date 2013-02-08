module Livetask
  module Sidekiq
    module Web

      def self.show_tasks
        "<div id='livetask'>Loading tasks...</div>"
      end

      def get_tasks_ids
        ::Sidekiq.redis do |conn|
          conn.zrevrange("livetask-tasks", 0, (2**(0.size * 8 -2) -1))
        end
      end

      def get_task_name(jid)
        ::Sidekiq.redis do |conn|
          conn.hget("livetask-#{jid}-info", "name")
        end
      end

      def get_progress(jid)
        ::Sidekiq.redis do |conn|
          conn.hget("livetask-#{jid}-info", "progress")
        end
      end

      def get_status(jid)
        ::Sidekiq.redis do |conn|
          conn.hget("livetask-#{jid}-info", "status")
        end
      end

      def get_log(jid, to = (2**(0.size * 8 -2) -1), from = 0)
        log_array = []
        ::Sidekiq.redis do |conn|
          log_array = conn.zrevrange("livetask-#{jid}-log", from, to, :with_scores => true)
        end
        log = ""
        log_array.each do |line|
          log += "#{Time.at(line.last)} #{line.first[5..-1]}\n"
        end
        log
      end

      def get_last_changed_at(jid)
        ::Sidekiq.redis do |conn|
          Time.at(conn.zscore("livetask-tasks", jid))
        end
      end

    end
  end
end
