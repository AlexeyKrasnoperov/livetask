module Livetask
  module SidekiqWeb

    def get_progress(jid)
      Sidekiq.redis do |conn|
        conn.get("livetask-#{jid}-progress")
      end
    end

    def get_log(jid)
      Sidekiq.redis do |conn|
        conn.get("livetask-#{jid}-log")
      end
    end

    def get_processes_ids
      Sidekiq.redis do |conn|
        conn.zrevrange("livetask-processes", 0, (2**(0.size * 8 -2) -1))
      end
    end

  end
end
