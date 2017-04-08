defmodule Dsps.RedisTest.Session do
    use Dsps.Redis.Session

    test "redis session creation" do
        user = UserSession.new_session(1)
        new_redis_session("testUUID")

        assert get_redis_session("testUUID") != :undefined
    end
end