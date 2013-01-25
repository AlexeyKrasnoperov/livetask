module Livetask
  module SidekiqWeb

    def self.show_tasks
      "<div id='livetask'>Loading tasks...</div>"
    end

    def get_tasks_ids
      Sidekiq.redis do |conn|
        conn.zrevrange("livetask-tasks", 0, (2**(0.size * 8 -2) -1))
      end
    end

    def get_progress(jid)
      Sidekiq.redis do |conn|
        conn.hget("livetask-#{jid}-info", "progress")
      end
    end

    def get_status(jid)
      Sidekiq.redis do |conn|
        conn.hget("livetask-#{jid}-info", "status")
      end
    end

    def get_log(jid)
      Sidekiq.redis do |conn|
        conn.get("livetask-#{jid}-log")
      end
    end

    def get_last_changed_at(jid)
      Sidekiq.redis do |conn|
        Time.at(conn.zscore("livetask-tasks", jid)).to_datetime
      end
    end

  end
end
