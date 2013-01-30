module Livetask
  module SidekiqWorker

    def set_task_name(name)
      return false unless @jid
      register_task(@jid)
      Sidekiq.redis do |conn|
        conn.hset("livetask-#{@jid}-info", "name", name)
      end
    end

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
        conn.zadd("livetask-#{@jid}-log", Time.now.to_i, "#{Time.now.to_i.to_s[-5..-1]}#{string}")
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
