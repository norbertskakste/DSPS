defmodule Dsps.RedisTest.Session do
    use Dsps.Redis.Session

    @test_uuid = "testUUID"

    test "redis session creation" do
        user = UserSession.new_session(1)
        new_redis_session(@test_uuid)

        assert get_redis_session(@test_uuid) != :undefined
    end
end