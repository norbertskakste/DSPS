defmodule Dsps.RedisTest.Session do
    import Dsps.Redis.Session

    use ExUnit.Case

    test "redis session creation" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID", user)

        assert Dsps.Redis.Session.get_redis_session("testUUID") != :undefined

        assert Dsps.Redis.Session

        Dsps.Redis.Session.cleanup_all
    end

    test "redis session deletion" do
        user = Dsps.Redis.Session.UserSession.new_session(1)
        Dsps.Redis.Session.new_redis_session("testUUID", user)
        Dsps.Redis.Session.delete_redis_session("testUUID")

        assert Dsps.Redis.Session.get_redis_session("testUUID") == :undefined

        Dsps.Redis.Session.cleanup_all
    end
end