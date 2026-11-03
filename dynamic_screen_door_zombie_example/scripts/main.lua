local speed_hook = "Lawn.Zombie.PickRandomSpeed()"
assert(api.has_hook(speed_hook), "Dynamic screen door zombie example requires the updated ReMod zombie API")

-- 图鉴文本来自资源包根目录的 LawnStrings_*.txt。
local reinforced_screen_door = api.register_zombie({
    id = "reinforced_screen_door",
    name_key = "REINFORCED_SCREEN_DOOR_ZOMBIE",
    reanimation = ReanimationType.Zombie,
    pick_weight = 3500,
    zombie_value = 5,
    starting_level = 1,
    first_allowed_wave = 1,
    initialize = function(zombie)
        -- 原生初始化随后应用关卡倍率，并同步各层最大血量。
        zombie:LoadPlainZombieReanim()
        zombie.mBodyHealth = 270
        zombie.mShieldType = ShieldType.Door
        zombie.mShieldHealth = 1800
        zombie:AttachShield()
    end,
    can_go_in_pool = true,
    almanac = true,
    almanac_image = "IMAGE_REANIM_ZOMBIE_SCREENDOOR1"
})

api.hook(speed_hook, "postfix", function(zombie)
    if zombie.mZombieType == reinforced_screen_door then
        zombie.mVelX = 0.32
        zombie:UpdateAnimSpeed()
    end
end)

assert(api.get_zombie_type("reinforced_screen_door") == reinforced_screen_door)
api.log("registered reinforced_screen_door zombie " .. tostring(reinforced_screen_door))
