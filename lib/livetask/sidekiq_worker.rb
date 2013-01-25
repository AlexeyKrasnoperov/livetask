module Livetask
  module SidekiqWorker

    def set_progress(progress)
      return false unless @jid
      register_task(@jid)
      Sidekiq.redis do |conn|
        conn.hset("livetask-#{@jid}-info", "progress", progress)
      end
    end

    def set_status(status)
      return false unless @jid
      register_task(@jid)
      Sidekiq.redis do |conn|
        conn.hset("livetask-#{@jid}-info", "status", status)
      end
    end

    def add_to_log(string)
      return false unless @jid
      register_task(@jid)
      Sidekiq.redis do |conn|
        string = "[#{Time.now}] #{string}"
        string = "\n#{string}" if conn.get("livetask-#{jid}-log")
        conn.append("livetask-#{@jid}-log", string)
      end
    end

    private
    def register_task(jid)
      Sidekiq.redis do |conn|
        conn.zadd("livetask-tasks", Time.now.to_i, jid.to_s)
      end
    end

  end
end
