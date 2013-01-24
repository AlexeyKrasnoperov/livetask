module Livetask
  module SidekiqWorker

    def set_progress(n)
      register_process(@jid)
      Sidekiq.redis do |conn|
        conn.set("livetask-#{@jid}-progress", n)
      end
    end

    def add_to_log(string)
      register_process(@jid)
      Sidekiq.redis do |conn|
        string = "[#{Time.now}] #{string}"
        string = "\n#{string}" if conn.get("livetask-#{jid}-log")
        conn.append("livetask-#{@jid}-log", string)
      end
    end

    private
    def register_process(jid)
      Sidekiq.redis do |conn|
        conn.zadd("livetask-processes", Time.now.to_i, jid.to_s)
      end
    end

  end
end
