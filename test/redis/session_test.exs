defmodule Dsps.RedisTest.Session do
    import Dsps.Redis.Session

    use ExUnit.Case

    test "redis session creation" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID", user)

        assert Dsps.Redis.Session.get_redis_session("testUUID") != :undefined

        Dsps.Redis.Session.cleanup_all
    end

    test "redis session creation [multiple]" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID1", user)
        Dsps.Redis.Session.new_redis_session("testUUID2", user)
        Dsps.Redis.Session.new_redis_session("testUUID3", user)
        Dsps.Redis.Session.new_redis_session("testUUID4", user)

        assert Dsps.Redis.Session.get_redis_sessions
        |> Kernel.length == 4

        Dsps.Redis.Session.cleanup_all
    end

    test "redis session deletion" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID", user)
        Dsps.Redis.Session.delete_redis_session("testUUID")

        assert Dsps.Redis.Session.get_redis_session("testUUID") == :undefined

        Dsps.Redis.Session.cleanup_all
    end

    test "redis session deletion [multiple]" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID1", user)
        Dsps.Redis.Session.new_redis_session("testUUID2", user)
        Dsps.Redis.Session.new_redis_session("testUUID3", user)
        Dsps.Redis.Session.new_redis_session("testUUID4", user)

        Dsps.Redis.Session.delete_redis_session("testUUID1")
        Dsps.Redis.Session.delete_redis_session("testUUID2")
        Dsps.Redis.Session.delete_redis_session("testUUID3")
        Dsps.Redis.Session.delete_redis_session("testUUID4")

        assert Dsps.Redis.Session.get_redis_sessions == :undefined

        Dsps.Redis.Session.cleanup_all
    end

    test "redis session cleanup_all" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID1", user)
        Dsps.Redis.Session.new_redis_session("testUUID2", user)
        Dsps.Redis.Session.new_redis_session("testUUID3", user)
        Dsps.Redis.Session.new_redis_session("testUUID4", user)

        Dsps.Redis.Session.cleanup_all

        assert Dsps.Redis.Session.get_redis_sessions == :undefined

    end

end