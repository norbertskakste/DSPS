defmodule Dsps.Exredis.Supervisor do
    use Supervisor

    def start_link do
        Supervisor.start_link(__MODULE__, [])
    end

    def init([]) do
        pool_options = [
            name: {:local, :redis_pool},
            worker_module: :eredis,
            size: 10,
            max_overflow: 0,
        ]

        arg = ["127.0.0.1", 6379]

        children = [
            :poolboy.child_spec(:redis_pool, pool_options, arg)
        ]

        supervise(children, strategy: :one_for_one)
    end
end