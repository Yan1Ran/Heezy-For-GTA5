--[[
    Nowiry
    lance
    Author
    Jerry123
    Jackz
    Pichocles
    Mayoscript
--]]

--[[
          _____                   _______                   _____                    _____                    _____          
         /\    \                 /::\    \                 /\    \                  /\    \                  /\    \         
        /::\____\               /::::\    \               /::\____\                /::\    \                /::\    \        
       /:::/    /              /::::::\    \             /::::|   |               /::::\    \              /::::\    \       
      /:::/    /              /::::::::\    \           /:::::|   |              /::::::\    \            /::::::\    \      
     /:::/    /              /:::/~~\:::\    \         /::::::|   |             /:::/\:::\    \          /:::/\:::\    \     
    /:::/____/              /:::/    \:::\    \       /:::/|::|   |            /:::/__\:::\    \        /:::/__\:::\    \    
   /::::\    \             /:::/    / \:::\    \     /:::/ |::|   |           /::::\   \:::\    \      /::::\   \:::\    \   
  /::::::\    \   _____   /:::/____/   \:::\____\   /:::/  |::|___|______    /::::::\   \:::\    \    /::::::\   \:::\    \  
 /:::/\:::\    \ /\    \ |:::|    |     |:::|    | /:::/   |::::::::\    \  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\____\ 
/:::/  \:::\    /::\____\|:::|____|     |:::|    |/:::/    |:::::::::\____\/:::/__\:::\   \:::\____\/:::/  \:::\   \:::|    |
\::/    \:::\  /:::/    / \:::\    \   /:::/    / \::/    / ~~~~~/:::/    /\:::\   \:::\   \::/    /\::/   |::::\  /:::|____|
 \/____/ \:::\/:::/    /   \:::\    \ /:::/    /   \/____/      /:::/    /  \:::\   \:::\   \/____/  \/____|:::::\/:::/    / 
          \::::::/    /     \:::\    /:::/    /                /:::/    /    \:::\   \:::\    \            |:::::::::/    /  
           \::::/    /       \:::\__/:::/    /                /:::/    /      \:::\   \:::\____\           |::|\::::/    /   
           /:::/    /         \::::::::/    /                /:::/    /        \:::\   \::/    /           |::| \::/____/    
          /:::/    /           \::::::/    /                /:::/    /          \:::\   \/____/            |::|  ~|          
         /:::/    /             \::::/    /                /:::/    /            \:::\    \                |::|   |          
        /:::/    /               \::/____/                /:::/    /              \:::\____\               \::|   |          
        \::/    /                 ~~                      \::/    /                \::/    /                \:|   |          
         \/____/                                           \/____/                  \/____/                  \|___|          
                                                                                                                             
--]]

--CV请标明出处:)
----------------------------------------------------------------------------------------------

util.keep_running()

require("store/LM/LM_func")
require("store/LM/2T1_func")
require("store/LM/Mayo")
require("store/LM/LM_enums")

util.require_natives("natives-1663599433")
local configFile <const> = filesystem.store_dir() .. "/LM/config.ini"
if filesystem.exists(configFile) then
	local loaded <const>  = ini.load(configFile)
	for s, t in pairs(loaded) do
		for k, v in pairs(t) do
			if gConfig[ s ] and gConfig[ s ][ k ] ~= nil then
				gConfig[ s ][ k ] = v
			end
		end
	end
end

function playmusic(path)
    local fr = soup.FileReader(path)
    local wav = soup.audWav(fr)
    local dev = soup.audDevice.getDefault()
    local pb = dev:open(wav.channels)
    local mix = soup.audMixer()
    mix.stop_playback_when_done = true
    mix:setOutput(pb)
    mix:playSound(wav)
end

local SHOW_NOTIF = true

----------------------------------------------------------------------------------------------
------原子侠图标------
local Atamiman_dir <const> = filesystem.store_dir().."/LM/Atamiman/"
local skill_1 <const> = directx.create_texture(Atamiman_dir .. "4.png")
local skill_2 <const> = directx.create_texture(Atamiman_dir .. "3.png")
local skill_3 <const> = directx.create_texture(Atamiman_dir .. "2.png")
local skill_4 <const> = directx.create_texture(Atamiman_dir .. "1.png")

--########################################################

--########################################################

NOTIF("Hey Bro")

----------菜单----------
local heezy_root <const> = menu.my_root()--menu.attach_before(menu.ref_by_path("Stand>Settings"),menu.list(menu.shadow_root(), "Heezy二代目", {"HeezyLuaScript"},""))
menu.action(heezy_root,"重启脚本",{},"",function ()
    util.restart_script()
    --util.stop_script()
end)

FRIENDS_LIST = heezy_root:list("好友选项")

SELF_LIST = heezy_root:list("自我选项")
    local self_custom_options <const> = SELF_LIST:list("自定义血量护甲")
    local self_custom_recharge_options <const> = SELF_LIST:list("自定义生命恢复")
    local self_custom_low_limit <const> = SELF_LIST:list("自定义血量下限")
    local actions_list <const> = SELF_LIST:list("动作列表")

FUN_LIST = heezy_root:list("娱乐选项")
    local Atamiman_features <const> = FUN_LIST:list("原子侠", {}, "技能图标 by TravellerLuaScript")
    local Flashman_features <const> = FUN_LIST:list("闪电侠", {}, "粗制滥造")
    local Ironman_features <const> = FUN_LIST:list("钢铁侠", {}, "by jerryscript")
    local Superman_features <const> = FUN_LIST:list("祖国人", {}, "粗制滥造")
    local Ghostrider_features <const> = FUN_LIST:list("恶灵骑士")
    local Naruto_features <const> = FUN_LIST:list("火影忍者")
    local weapon_features <const> = FUN_LIST:list("武器工坊")
    local model_features <const> = FUN_LIST:list("模型选项")
        local attach_model <const> = model_features:list("附加模型")
    local ptfx_features <const> = FUN_LIST:list("粒子特效")
    local marker_features <const> = FUN_LIST:list("图标显示")

VEHICLE_LIST = heezy_root:list("载具选项")
    local vehicle_drift <const> = VEHICLE_LIST:list("秋名山车神")
    local vehicle_modification <const> = VEHICLE_LIST:list("载具改装")
    local vehicle_window <const> = VEHICLE_LIST:list("载具车窗")
    local vehicle_doorlock <const> = VEHICLE_LIST:list("载具锁门")
    local vehicle_door <const> = VEHICLE_LIST:list("载具门")

SESSION_LIST = heezy_root:list("战局选项")
    local next_chat <const> = SESSION_LIST:list("次世代聊天")
        local regular_coloring_root <const> = next_chat:list("颜色", {}, "")
        local conditional_coloring_root <const> = next_chat:list("类别颜色", {}, "")
        local tags_root <const> = next_chat:list("标签", {}, "")
        local general_settings <const> = next_chat:list("设置", {}, "")
    local session_catfight <const> = SESSION_LIST:list("撕逼魔怔人")
        local crosshair <const>  = session_catfight:list("显示准心")
        local damage_numbers_list <const> = session_catfight:list("显示伤害")
            local damage_numbers_colours_list <const> = damage_numbers_list:list("颜色设置")
        local auto_weapon <const> = session_catfight:list("武器连发")
    local get_host <const> = SESSION_LIST:list("脚本/主机")
    local lobby_event <const> = SESSION_LIST:list("战局事件")
    local lobby_crash <const> = SESSION_LIST:list("战局崩溃")

PROTECTION_LIST = heezy_root:list("防护选项")
    local pool_limiter <const> = PROTECTION_LIST:list("实体池限制")

WORLD_LIST = heezy_root:list("世界选项")
    local terrain_grid <const> = WORLD_LIST:list("地形网格")


MISC_LIST = heezy_root:list("其他选项")
    local music_player <const> = MISC_LIST:list("音乐播放器")
    local tv_list <const> = MISC_LIST:list("移动电视")
    local cutscenes_list <const> = MISC_LIST:list("过场动画")
    local music_event_list <const> = MISC_LIST:list("音乐事件")
    local screen_effect <const> = MISC_LIST:list("屏幕特效")
    local host_queue <const> = MISC_LIST:list("主机序列")

--menu.trigger_commands("HeezyLuaScript")

function InputBox(escReturn, titlegxt, preText)
    preText = string.sub("", 0);
    MISC.DISPLAY_ONSCREEN_KEYBOARD(true, "", "", preText, "", "", "", 100);
    while (MISC.UPDATE_ONSCREEN_KEYBOARD() == 0) do
        HUD.SET_TEXT_FONT(0)
        HUD.SET_TEXT_SCALE(0.34, 0.34)
        HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
        HUD.SET_TEXT_WRAP(0.0, 1.0)
        HUD.SET_TEXT_RIGHT_JUSTIFY(false)
        HUD.SET_TEXT_CENTRE(true)
        HUD.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
        HUD.SET_TEXT_EDGE(0, 0, 0, 0, 0)
        HUD.SET_TEXT_OUTLINE()
        if (HUD.DOES_TEXT_LABEL_EXIST(titlegxt)) then
            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT(titlegxt)
        else
            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
			HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(titlegxt)
        end
        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5, 0.37, 0)
        util.yield(0)
    end
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5, 0.37, 0)
    if (MISC.UPDATE_ONSCREEN_KEYBOARD() == 2) then
        return escReturn
            end
    return MISC.GET_ONSCREEN_KEYBOARD_RESULT()
end

local justPressed <const> = {}
local function getKeyCode(string_or_int)
    local lookup = vk_code[string_or_int]
    return (lookup and lookup or string_or_int)
end
function is_key_just_down(string_or_int)
    local keyCode = getKeyCode(string_or_int)
    local isDown = util.is_key_down(keyCode)
    if isDown and not justPressed[keyCode] then
        justPressed[keyCode] = true
        return true
    elseif not isDown then
        justPressed[keyCode] = false
    end
    return false
end

--------------------------------
------------ 好友列表 ------------
--------------------------------

function get_friend_count()
    native_invoker.begin_call();native_invoker.end_call("203F1CFD823B27A4");
    return native_invoker.get_return_value_int();
end
function get_frined_name(friendIndex)
    native_invoker.begin_call();native_invoker.push_arg_int(friendIndex);native_invoker.end_call("4164F227D052E293");return native_invoker.get_return_value_string();
end

local function gen_fren_funcs(name)
    if NETWORK.NETWORK_IS_FRIEND_ONLINE(name) then
        frined_is_ol = name.." [在线]"
    else
        frined_is_ol = name.." [离线]"
    end
    local balls <const> = FRIENDS_LIST:list(frined_is_ol, {"friend "..name}, "")   

    menu.divider(balls ,frined_is_ol)   

    menu.action(balls,"加入战局", {"jf "..name}, "",function()    
        menu.trigger_commands("join "..name)   
    end)

    menu.action(balls,"观看玩家", {"sf "..name}, "",function()    
        menu.trigger_commands("namespectate "..name)   
    end)

    menu.action(balls,"邀请到战局", {"if "..name}, "",function()    
        menu.trigger_commands("invite "..name)    
    end)

    menu.action(balls,"打开玩家档案", {"pf "..name}, "",function()    
        menu.trigger_commands("nameprofile "..name)    
    end)    
end

FRIENDS_LIST:divider("好友:)")
    
for i = 0 , get_friend_count() do    
    local name = get_frined_name(i)    
    if name == "*****" then goto yes end    
    gen_fren_funcs(name)    
    ::yes::   
end

--------------------------------
------------ 自我选项 ------------
--------------------------------

----------自定义最大生命值----------
menu.divider(self_custom_options, "生命")

local defaultHealth = ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID())
local moddedHealth = defaultHealth
menu.slider(self_custom_options, "自定义最大生命值", { "set_max_health" }, "生命值将被修改为指定的数值"
    , 50, 100000, defaultHealth, 50, function(value)
    moddedHealth = value
end)

menu.toggle_loop(self_custom_options, "开启", {}, "改变你的最大生命值.一些菜单会将你标记为作弊者.当它被禁用时,它会返回到默认的最大生命值."
    , function()
        if PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID()) ~= moddedHealth then
            PED.SET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth)
            ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth)
        end
    end, function()
    PED.SET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), defaultHealth)
    ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), defaultHealth)
end)

menu.click_slider(self_custom_options, "设置当前生命值", { "set_health" }, "", 0, 100000, defaultHealth, 50,
    function(value)
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), value)
    end)

----------自定义最大护甲----------
menu.divider(self_custom_options, "护甲")

local defaultArmour = PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID())

local moddedArmour = defaultArmour
menu.slider(self_custom_options, "自定义最大护甲值", { "set_max_armour" }, "护甲将被修改为指定的数值",50, 100000, defaultArmour, 50, function(value)
    moddedArmour = value
end)

menu.toggle_loop(self_custom_options, "开启", {}, "改变你的最大护甲值.一些菜单会将你标记为作弊者.当它被禁用时,它会返回到默认的最大护甲值.", function()
    if PLAYER.GET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID()) ~= moddedArmour then
        PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), moddedArmour)
         PED.SET_PED_ARMOUR(PLAYER.PLAYER_PED_ID(), moddedArmour)
    end
end, function()
    PLAYER.SET_PLAYER_MAX_ARMOUR(PLAYER.PLAYER_ID(), defaultArmour)
    PED.SET_PED_ARMOUR(PLAYER.PLAYER_PED_ID(), defaultArmour)
end)

menu.click_slider(self_custom_options, "设置当前护甲值", { "set_armour" }, "", 0, 100000, defaultArmour, 50,function(value)
    PED.SET_PED_ARMOUR(PLAYER.PLAYER_PED_ID(), value)
end)

----------自定义生命恢复----------
local custom_recharge = {
    normal_limit = 0.25,
    normal_mult = 1.0,
    cover_limit = 0.25,
    cover_mult = 1.0,
    vehicle_limit = 0.25,
    vehicle_mult = 1.0
}

menu.toggle_loop(self_custom_recharge_options, "开启", {}, "", function()
    if PED.IS_PED_IN_COVER(players.user_ped(), false) then
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), custom_recharge.cover_limit)
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), custom_recharge.cover_mult)
    elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), custom_recharge.vehicle_limit)
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), custom_recharge.vehicle_mult)
    else
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), custom_recharge.normal_limit)
        PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), custom_recharge.normal_mult)
    end
end, function()
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MAX_PERCENT(players.user(), 0.25)
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
end)

menu.divider(self_custom_recharge_options, "站立不动状态")

menu.slider(self_custom_recharge_options, "恢复程度", { "normal_recharge_limit" }, "恢复到血量的多少,单位%\n默认:25%", 1, 100, 25, 10, function(value)
    custom_recharge.normal_limit = value * 0.01
end)

menu.slider(self_custom_recharge_options, "恢复速度", { "normal_recharge_mult" }, "恢复速度\n默认:1.0", 1.0,100.0, 1.0, 1.0, function(value)
    custom_recharge.normal_mult = value
end)

menu.divider(self_custom_recharge_options, "掩体内")

menu.slider(self_custom_recharge_options, "恢复程度", { "cover_recharge_limit" }, "恢复到血量的多少,单位%\n默认:25%", 1, 100, 25, 10, function(value)
    custom_recharge.cover_limit = value * 0.01
end)

menu.slider(self_custom_recharge_options, "恢复速度", { "cover_recharge_mult" }, "恢复速度\n默认:1.0", 1.0,100.0, 1.0, 1.0, function(value)
    custom_recharge.cover_mult = value
end)

menu.divider(self_custom_recharge_options, "载具内")

menu.slider(self_custom_recharge_options, "恢复程度", { "vehicle_recharge_limit" }, "恢复到血量的多少，单位%\n默认:25%", 1, 100, 25, 10, function(value)
    custom_recharge.vehicle_limit = value * 0.01
end)

menu.slider(self_custom_recharge_options, "恢复速度", { "vehicle_recharge_mult" }, "恢复速度\n默认:1.0", 1.0,100.0, 1.0, 1.0, function(value)
    custom_recharge.vehicle_mult = value
end)

----------自定义血量下限----------
local low_health_limit = 0.5

menu.slider(self_custom_low_limit, "设置血量下限(%)", { "low_health_limit" }, "可以到达的最低血量,单位%", 10, 100, 50, 10, function(value)
    low_health_limit = value * 0.01
end)

menu.toggle_loop(self_custom_low_limit, "锁定血量", {}, "当你的血量到达你设置的血量下限值后,锁定你的血量,防不住爆炸", function()
    if not PLAYER.IS_PLAYER_DEAD(players.user()) then
        local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) - 100
        local toLock_health = math.ceil(maxHealth * low_health_limit + 100)
        if ENTITY.GET_ENTITY_HEALTH(players.user_ped()) < toLock_health then
            ENTITY.SET_ENTITY_HEALTH(players.user_ped(), toLock_health)
        end
    end
end)

menu.toggle_loop(self_custom_low_limit, "补满血量", {}, "当你的血量到达你设置的血量下限值后,补满你的血量", function()
    if not PLAYER.IS_PLAYER_DEAD(players.user()) then
        local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) - 100
        local toLock_health = math.ceil(maxHealth * low_health_limit + 100)
        if ENTITY.GET_ENTITY_HEALTH(players.user_ped()) < toLock_health then
            ENTITY.SET_ENTITY_HEALTH(players.user_ped(), maxHealth + 100)
        end
    end
end)

----------动作列表----------
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
       table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
 end

local status = pcall(require, "store/LM/actions_data")
local clearActionImmediately = true
local animAttachments = {}

function clear_anim_props()
    for ent, shouldDelete in pairs(animAttachments) do
        if shouldDelete then
            entities.delete(ent)
        else
            ENTITY.DETACH_ENTITY(ent, false)
        end
    end
end

function delete_anim_props()
    for ent, _ in pairs(animAttachments) do
        entities.delete(ent)
    end
end

function _play_animation(ped, group, animation, flags, duration, props)
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end
    if props ~= nil then
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        for _, propData in ipairs(props) do
            local boneIndex = PED.GET_PED_BONE_INDEX(ped, propData.Bone)
            local hash = util.joaat(propData.Prop)
            STREAMING.REQUEST_MODEL(hash)
            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end
            local object = entities.create_object(hash, pos)
            animAttachments[object] = propData.DeleteOnEnd ~= nil
            ENTITY.ATTACH_ENTITY_TO_ENTITY(
                object, ped, boneIndex,
                propData.Placement[1] or 0.0,
                propData.Placement[2] or 0.0,
                propData.Placement[3] or 0.0,
                propData.Placement[4] or 0.0,
                propData.Placement[5] or 0.0,
                propData.Placement[6] or 0.0,
                false,
                true,
                false,
                true,
                1,
                true
            )
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        end
    end
    TASK.TASK_PLAY_ANIM(ped, group, animation, 8.0, 8.0, duration, flags, 0.0, false, false, false)
end

function play_animation(group, anim, doNotAddRecent, data, remove)
    local flags = AnimationFlags.ANIM_FLAG_REPEAT | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL
    local duration = -1
    local props
    if data ~= nil then
        flags = AnimationFlags.ANIM_FLAG_NORMAL
        if data.AnimationOptions ~= nil then
            if data.AnimationOptions.Loop then
                flags = flags | AnimationFlags.ANIM_FLAG_REPEAT
            end
            if data.AnimationOptions.Controllable then
                flags = flags | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL | AnimationFlags.ANIM_FLAG_UPPERBODY
            end
            if data.AnimationOptions.EmoteDuration then
                duration = data.AnimationOptions.EmoteDuration
            end
        end
        if data.AnimationOptions and data.AnimationOptions.Props then
            props = data.AnimationOptions.Props
        end
    end
    clear_anim_props()
    STREAMING.REQUEST_ANIM_DICT(group)
    while not STREAMING.HAS_ANIM_DICT_LOADED(group) do
        util.yield(100)
    end
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
         _play_animation(ped, group, anim, flags, duration, props)
        STREAMING.REMOVE_ANIM_DICT(group)
    end

menu.action(actions_list, "停止动作", {"stopself"}, "停止当前动作,清除当前道具", function(v)
    clear_anim_props()
    delete_anim_props()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    else
        TASK.CLEAR_PED_TASKS(ped)
    end
        local peds = entities.get_all_peds_as_handles()
        for _, npc in ipairs(peds) do
            if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(npc)
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                else
                    TASK.CLEAR_PED_TASKS(npc)
                end
            end
        end
    end)

for category, rows in pairsByKeys(SPECIAL_ANIMATIONS) do
    local catmenu = menu.list(actions_list, category, {})
    for key, data in pairsByKeys(rows) do
        menu.action(catmenu,
            data[3] or key,
            {"playanim"..key},
            string.format("使用动作:%s %s\n动作ID: %s", data[1], data[2], key),function() 
                play_animation(data[1], data[2], false, data) 
            end)
        end
    end

local scenarioCount = 0
local scenariosMenu = menu.list(actions_list, "场景", {}, "可以播放的场景列表\n某些场景仅适用于特定性别.")
for group, scenarios in pairs(SCENARIOS) do
    local submenu = menu.list(scenariosMenu, group, {}, "所有" .. group .. "的场景")
    for _, scenario in ipairs(scenarios) do
        scenarioCount = scenarioCount + 1
        menu.action(submenu, scenario[2], {"scenario"}, "使用场景: " .. scenario[2], function(v)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                end
                TASK.TASK_START_SCENARIO_IN_PLACE(ped, scenario[1], 0, true);
            end)
        end
    end


------------------------------------------------------

menu.toggle_loop(SELF_LIST, "行动无声", {}, "", function()
    PLAYER.SET_PLAYER_NOISE_MULTIPLIER(PLAYER.PLAYER_ID(), 0.0)
    PLAYER.SET_PLAYER_SNEAKING_NOISE_MULTIPLIER(PLAYER.PLAYER_ID(), 0.0)
end)

menu.toggle_loop(SELF_LIST, "不会被帮派骚乱", {}, "", function()
    PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), false)
end, function()
    PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), true)
end)

menu.toggle_loop(SELF_LIST, "不可被拽出载具", {}, "", function()
    PED.SET_PED_CAN_BE_DRAGGED_OUT(PLAYER.PLAYER_PED_ID(), false)
end, function()
    PED.SET_PED_CAN_BE_DRAGGED_OUT(PLAYER.PLAYER_PED_ID(), true)
end)

menu.toggle_loop(SELF_LIST, "载具内不可被射击", {}, "在载具内不会受伤", function()
    PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), false)
end, function()
    PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), true)
end)

menu.toggle_loop(SELF_LIST, "禁用NPC伤害", {}, "", function()
    PED.SET_AI_WEAPON_DAMAGE_MODIFIER(0.0)
    PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(0.0)
end, function()
    PED.RESET_AI_WEAPON_DAMAGE_MODIFIER()
    PED.RESET_AI_MELEE_WEAPON_DAMAGE_MODIFIER()
end)

menu.toggle_loop(SELF_LIST, "自动杀死敌人", {}, "", function()
	for _, ped in ipairs(entities.get_all_peds_as_handles()) do
		local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(PLAYER.PLAYER_PED_ID(), ped)
		if not ENTITY.IS_ENTITY_DEAD(ped) and ( (rel == 4 or rel == 5) or PED.IS_PED_IN_COMBAT(ped, PLAYER.PLAYER_PED_ID()) ) then
            ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
		end
	end
end)

--------------------------------
------------ 娱乐选项 ------------
--------------------------------
----------图标显示----------
local big_soul_ring  = marker_features:list("大魂环", {},"")

local big_soul_ring_color_option = big_soul_ring:list("魂环(颜色)", {}, "")
menu.toggle_loop(big_soul_ring_color_option, "魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.8, 0, 0, 0, 0, 0, 0, 2, 2, 2, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 3, 3, 3, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.6, 0, 0, 0, 0, 0, 0, 4.5, 4.5, 4.5, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 6, 6, 6, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.4, 0, 0, 0, 0, 0, 0, 9, 9, 9, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 13, 13, 13, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 18, 18, 18, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 24, 24, 24, big_soul_ring_color.r, big_soul_ring_color.g, big_soul_ring_color.b, big_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
end)

big_soul_ring_color = {r = 255.0, g = 255.0, b = 255.0, a = 255.0}
menu.slider(big_soul_ring_color_option, "R", {}, "", 0, 255, big_soul_ring_color.r, 1, function(value)
    big_soul_ring_color.r = value
end)

menu.slider(big_soul_ring_color_option, "G", {}, "", 0, 255, big_soul_ring_color.g, 1, function(value)
    big_soul_ring_color.g = value
end)

menu.slider(big_soul_ring_color_option, "B", {}, "", 0, 255, big_soul_ring_color.b, 1, function(value)
    big_soul_ring_color.b = value
end)

menu.slider(big_soul_ring_color_option, "A", {}, "", 0, 255, big_soul_ring_color.a, 1, function(value)
    big_soul_ring_color.a = value
end)


menu.toggle_loop(big_soul_ring, "魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.8, 0, 0, 0, 0, 0, 0, 2, 2, 2, 255, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 3, 3, 3, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.6, 0, 0, 0, 0, 0, 0, 4.5, 4.5, 4.5, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.4, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 13, 13, 13, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 18, 18, 18, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 24, 24, 24, 255, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(big_soul_ring, "彩虹魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.8, 0, 0, 0, 0, 0, 0, 2, 2, 2, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 3, 3, 3, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.6, 0, 0, 0, 0, 0, 0, 4.5, 4.5, 4.5, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 6, 6, 6, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.4, 0, 0, 0, 0, 0, 0, 9, 9, 9, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 13, 13, 13, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 18, 18, 18, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 24, 24, 24, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(big_soul_ring, "分裂魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.8, 0, 0, 0, 0, 0, 0, 2, 2, 2, 255, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 3, 3, 3, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.6, 0, 0, 0, 0, 0, 0, 4.5, 4.5, 4.5, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.4, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 13, 13, 13, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 18, 18, 18, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 24, 24, 24, 255, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
end)

local small_soul_ring  = marker_features:list("小魂环", {},"")

local small_soul_ring_color_option = small_soul_ring :list("魂环(颜色)", {}, "")
menu.toggle_loop(small_soul_ring_color_option, "魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 2, 2, 2, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 3, 3, 3, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 5, 5, 5, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 7, 7, 7, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 11, 11, 11, small_soul_ring_color.r, small_soul_ring_color.g, small_soul_ring_color.b, small_soul_ring_color.a, 0, 1, 1, 0, 0, 0, false)
end)

small_soul_ring_color = {r = 255.0, g = 255.0, b = 255.0, a = 255.0}
menu.slider(small_soul_ring_color_option, "R", {}, "", 0, 255, small_soul_ring_color.r, 1, function(value)
    small_soul_ring_color.r = value
end)

menu.slider(small_soul_ring_color_option, "G", {}, "", 0, 255, small_soul_ring_color.g, 1, function(value)
    small_soul_ring_color.g = value
end)

menu.slider(small_soul_ring_color_option, "B", {}, "", 0, 255, small_soul_ring_color.b, 1, function(value)
    small_soul_ring_color.b = value
end)

menu.slider(small_soul_ring_color_option, "A", {}, "", 0, 255, small_soul_ring_color.a, 1, function(value)
    small_soul_ring_color.a = value
end)


menu.toggle_loop(small_soul_ring, "魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 2, 2, 2, 255, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 7, 7, 7, 255, 128,0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 11, 11, 11, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(small_soul_ring, "彩虹魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(23, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 2, 2, 2, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 3, 3, 3, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 5, 5, 5, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 7, 7, 7, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(25, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 11, 11, 11, math.random(128, 255), math.random(128, 255), math.random(128, 255), math.random(128, 255), 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(small_soul_ring, "分裂魂环", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 2, 2, 2, 255, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 5, 5, 5, 0, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 7, 7, 7, 255,128,0, 255, 0, 1, 1, 0, 0, 0, false)
    GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 11, 11, 11, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
end)


menu.toggle_loop(marker_features, "野兽", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(31, pos.x, pos.y, pos.z + 1.3, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 234, 0, 180, 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(marker_features, "问号", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(32, pos.x, pos.y, pos.z + 1.5, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 255, 255, 0, 1, 1, 0, 0, 0, false)
end)

menu.toggle_loop(marker_features, "螺旋", {""}, "", function()
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.DRAW_MARKER(42, pos.x, pos.y, pos.z + 1.3, 0, 0, 0, 90, 0, 0, 1, 1, 1, 255, 255, 255, 255, 0, 1, 1, 0, 0, 0, false)
end)

----------原子侠----------

a_s = 0
b_s = 0
c_s = 0
d_s = 0
Atamiman_1 = menu.toggle(Atamiman_features, "原子侠", {"Atamiman"}, "按E使用技能,按->选择技能", function(state)
    Atamiman_running = state
    if Atamiman_running then
        menu.trigger_commands("a1 on")
        menu.trigger_commands("a2 on")
        menu.trigger_commands("a3 on")
        menu.trigger_commands("a4 on")
        NOTIF("按E使用技能,按->选择技能")
        while Atamiman_running do
            directx.draw_texture(skill_1, 0.03+a_s, 0.1, 0.0, 0.0, 0.65, 0.82, 0, 1, 1, 1, 1)
            directx.draw_texture(skill_2, 0.03+b_s, 0.1, 0.0, 0.0, 0.55, 0.82, 0, 1, 1, 1, 1)
            directx.draw_texture(skill_3, 0.03+c_s, 0.1, 0.0, 0.0, 0.45, 0.82, 0, 1, 1, 1, 1)
            directx.draw_texture(skill_4, 0.03+d_s, 0.1, 0.0, 0.0, 0.35, 0.82, 0, 1, 1, 1, 1)
            util.yield()
        end
    else
        a_s = 0
        b_s = 0
        c_s = 0
        d_s = 0
        menu.trigger_commands("a1 off")
        menu.trigger_commands("a2 off")
        menu.trigger_commands("a3 off")
        menu.trigger_commands("a4 off")
        menu.trigger_commands("dominate off")
        menu.trigger_commands("schwarzesloch off")
        menu.trigger_commands("energyshield off")
        menu.trigger_commands("cyclops off")
    end
end)

a_s1 = menu.toggle_loop(Atamiman_features, "1", {"a1"}, "", function()
    if util.is_key_down(0x27) then
        a_s = 0.00
        b_s = 0.00
        c_s = 0.01
        d_s = 0.00
        util.yield(200)
        menu.trigger_commands("a1 off")
        menu.trigger_commands("a2 on")
        menu.trigger_commands("a3 off")
        menu.trigger_commands("a4 off")
        menu.trigger_commands("dominate off")
        menu.trigger_commands("schwarzesloch off")
        menu.trigger_commands("energyshield on")
        menu.trigger_commands("cyclops off")
    end
end)
menu.set_visible(a_s1,false)

a_s2 = menu.toggle_loop(Atamiman_features, "2", {"a2"}, "", function()
    if util.is_key_down(0x27) then
        a_s = 0.00
        b_s = 0.01
        c_s = 0.00
        d_s = 0.00
        util.yield(200)
        menu.trigger_commands("a1 off")
        menu.trigger_commands("a2 off")
        menu.trigger_commands("a3 on")
        menu.trigger_commands("a4 off")
        menu.trigger_commands("dominate off")
        menu.trigger_commands("schwarzesloch on")
        menu.trigger_commands("energyshield off")
        menu.trigger_commands("cyclops off")
    end
end)
menu.set_visible(a_s2,false)

a_s3 = menu.toggle_loop(Atamiman_features, "3", {"a3"}, "", function()
    if util.is_key_down(0x27) then
        a_s = 0.01
        b_s = 0.00
        c_s = 0.00
        d_s = 0.00
        util.yield(200)
        menu.trigger_commands("a1 off")
        menu.trigger_commands("a2 off")
        menu.trigger_commands("a3 off")
        menu.trigger_commands("a4 on")
        menu.trigger_commands("dominate on")
        menu.trigger_commands("schwarzesloch off")
        menu.trigger_commands("energyshield off")
        menu.trigger_commands("cyclops off")
    end
end)
menu.set_visible(a_s3,false)

a_s4 = menu.toggle_loop(Atamiman_features, "4", {"a4"}, "", function()
    if util.is_key_down(0x27) then
        a_s = 0.00
        b_s = 0.00
        c_s = 0.00
        d_s = 0.01
        util.yield(200)
        menu.trigger_commands("a1 on")
        menu.trigger_commands("a2 off")
        menu.trigger_commands("a3 off")
        menu.trigger_commands("a4 off")
        menu.trigger_commands("dominate off")
        menu.trigger_commands("schwarzesloch off")
        menu.trigger_commands("energyshield off")
        menu.trigger_commands("cyclops on")
    end
end)
menu.set_visible(a_s4,false)

menu.divider(Atamiman_features,"------其余技能------")

menu.toggle_loop(Atamiman_features, "公交车盾牌 [K]", {""}, "", function()
    if util.is_key_down(0x4B) then
        local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 7, 0)
        local hash = 3581397346
        forwardOffset.z = forwardOffset.z + 4
        forwardOffset.y = forwardOffset.y + 2
        bus = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        car1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        car2 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        car3 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        car4 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        attach_entity_to_entity_2t1(car1, bus, 0, v3_2t1(2,0,0), v3_2t1(0,0,0), true, true, false, 0, true)
        attach_entity_to_entity_2t1(car2, bus, 0, v3_2t1(4,0,0), v3_2t1(0,0,0), true, true, false, 0, true)
        attach_entity_to_entity_2t1(car3, bus, 0, v3_2t1(-2,0,0), v3_2t1(0,0,0), true, true, false, 0, true)
        attach_entity_to_entity_2t1(car4, bus, 0, v3_2t1(-4,0,0), v3_2t1(0,0,0), true, true, false, 0, true)
        ENTITY.FREEZE_ENTITY_POSITION(bus, true)
        set_entity_rotation_2t1(bus,v3_2t1(-90,0, 0))
        util.yield(500)
    end
end)

menu.toggle(Atamiman_features, "缩小", {""}, "", function(value)
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        PED.SET_PED_CONFIG_FLAG(ped, 223, value)
    end
    util.yield(100)
end)

Atamiman_energyshield = menu.toggle_loop(Atamiman_features, "原子能周身护盾", {"energyshield"}, "", function()
    local _entities = {}
    local player_pos = players.get_position(players.user())
    GRAPHICS.DRAW_MARKER_SPHERE(player_pos.x, player_pos.y, player_pos.z, 20, 73, 175, 255, 0.3)
    if util.is_key_down(0x45) then
        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= 20 then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= 20) and players.user_ped() ~= ped then
                table.insert(_entities, ped)
            end
        end
        for i, entity in pairs(_entities) do
            local force = ENTITY.GET_ENTITY_COORDS(entity)
            FIRE.ADD_EXPLOSION(force.x, force.y, force.z, 70, 1000, true, false, 0, false)
        end
    end
end)
menu.set_visible(Atamiman_energyshield,false)


Atamiman_blackhole = menu.toggle(Atamiman_features, "黑洞",{"schwarzesloch"},"", function(state)  
    blackhole_running = state 
    while blackhole_running do
        pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, 50, 20)
        GRAPHICS.DRAW_MARKER_SPHERE(pos.x, pos.y, pos.z, 5, 0, 0, 0, 1)
        if util.is_key_down(0x45) then
            local pushToX = 1
            local pushToY = 1
            local pushToZ = 1
            local pushStrength = 10
            local blackHoleVehicle = entities.get_all_vehicles_as_handles()
            local blackHoleObject = entities.get_all_objects_as_handles()
            local blackHolePED = entities.get_all_peds_as_handles()
            for index, value in ipairs(blackHoleVehicle) do
                vehiclePos = ENTITY.GET_ENTITY_COORDS(value)
                if ENTITY.DOES_ENTITY_EXIST(value) == true then
                    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                    end
                        if pos.x > vehiclePos.x then
                            pushToX = pushStrength
                        elseif pos.x < vehiclePos.x then
                            pushToX = -pushStrength
                        end
                        if pos.y > vehiclePos.y then
                            pushToY = pushStrength
                        elseif pos.y < vehiclePos.y then
                            pushToY = -pushStrength
                        end
                        if pos.z > vehiclePos.z then
                            pushToZ = pushStrength
                        elseif pos.z < vehiclePos.z then
                            pushToZ = -pushStrength
                        end
                        ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                    end
                end
                for index, value in ipairs(blackHoleObject) do
                    objectPos = ENTITY.GET_ENTITY_COORDS(value)
                    if ENTITY.DOES_ENTITY_EXIST(value) == true then
                        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                        end
                            if pos.x > objectPos.x then
                                pushToX = pushStrength
                            elseif pos.x < vehiclePos.x then
                                pushToX = -pushStrength
                            end
                            if pos.y > objectPos.y then
                                pushToY = pushStrength
                            elseif pos.y < objectPos.y then
                                pushToY = -pushStrength
                            end
                            if pos.z > objectPos.z then
                                pushToZ = pushStrength
                            elseif pos.z < objectPos.z then
                                pushToZ = -pushStrength
                            end
                            ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                        end
                    end
                    for index, value in ipairs(blackHolePED) do
                        if players.user_ped() ~= value and not ENTITY.IS_ENTITY_DEAD(value) then
                        PEDPos = ENTITY.GET_ENTITY_COORDS(value)
                        if ENTITY.DOES_ENTITY_EXIST(value) == true then
                            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                            end
                                if pos.x > PEDPos.x then
                                    pushToX = pushStrength
                                elseif pos.x < PEDPos.x then
                                    pushToX = -pushStrength
                                end
                                if pos.y > PEDPos.y then
                                    pushToY = pushStrength
                                elseif pos.y < PEDPos.y then
                                    pushToY = -pushStrength
                                end
                                if pos.z > PEDPos.z then
                                    pushToZ = pushStrength
                                elseif pos.z < PEDPos.z then
                                    pushToZ = -pushStrength
                                end
                                ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                            end
                        end
                    end
                end
            util.yield()
        end
    end) 
    menu.set_visible(Atamiman_blackhole,false)

Atamiman_dominate = menu.toggle_loop(Atamiman_features, "混乱世界",{"dominate"},"", function() 
    if util.is_key_down(0x45) then
        allveh = entities.get_all_vehicles_as_handles()
        allpeds = entities.get_all_objects_as_handles()
        util.yield(100)
        local vel, velo = v3_2t1(), v3_2t1()
        velo.x = 0.0
        velo.y = 0.0
        velo.z = 1000.00
        local myveh = PED.GET_VEHICLE_PED_IS_IN(players.user_ped())
        for i = 1, #allpeds do
            if not PED.IS_PED_A_PLAYER(allpeds[i]) then
                vel.x = math.random(1000.0, 10000.0)
                vel.y = math.random(1000.0, 10000.0)
                vel.z = math.random(1000.0, 7500.0)
                ENTITY.FREEZE_ENTITY_POSITION(allpeds[i], false)
                ENTITY.APPLY_FORCE_TO_ENTITY(allpeds[i], 5, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, true, true)
                set_entity_velocity_2t1(allpeds[i], vel)
            end
        end
        for y = 1, #allveh do
            if y ~= myveh then
                vel.x = math.random(1000.0, 10000.0)
                vel.y = math.random(1000.0, 10000.0)
                vel.z = math.random(1000.0, 7500.0)
                ENTITY.FREEZE_ENTITY_POSITION(allveh[y], false)
                ENTITY.APPLY_FORCE_TO_ENTITY(allveh[y], 5, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, true, true)
                ENTITY.SET_ENTITY_HAS_GRAVITY(allveh[y], false)
                set_entity_velocity_2t1(allveh[y], velo)
                util.yield(25)
                set_entity_velocity_2t1(allveh[y], vel)
            end
        end  
    end 
end)
menu.set_visible(Atamiman_dominate,false)


local lastShot = newTimer()
local sound = Sound.new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")

local DisableControlActions = function()
	PAD.DISABLE_CONTROL_ACTION(0, 106, true)
	PAD.DISABLE_CONTROL_ACTION(0, 122, true)
	PAD.DISABLE_CONTROL_ACTION(0, 135, true)
	PAD.DISABLE_CONTROL_ACTION(0, 140, true)
	PAD.DISABLE_CONTROL_ACTION(0, 141, true)
	PAD.DISABLE_CONTROL_ACTION(0, 142, true)
	PAD.DISABLE_CONTROL_ACTION(0, 263, true)
	PAD.DISABLE_CONTROL_ACTION(0, 264, true)
end

Atamiman_cyclops = menu.toggle_loop(Atamiman_features, "镭射眼", {"cyclops"}, "", function()
    local hash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat("WEAPON_UNARMED"), true)
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
        DisableControlActions()
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
        end
        local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
        local offset = get_offset_from_cam(80)
        GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, offset.x, offset.y, offset.z,255,0,0,255)
        if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
            if not sound:hasFinished() then
                sound:stop()
            end
        elseif lastShot.elapsed() > 100 then
            if  sound:hasFinished() then
                sound:playFromEntity(players.user_ped())
                AUDIO.SET_VARIABLE_ON_SOUND(sound.Id, "fireRate", 10.0)
            end
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                pos.x, pos.y, pos.z,
                offset.x, offset.y, offset.z,
                200,
                true,
                hash, players.user_ped(), true, true, -1.0
            )
            lastShot.reset()
        end    
end, function()
	if not sound:hasFinished() then
		sound:stop()
	end
end)
menu.set_visible(Atamiman_cyclops,false)

----------闪电侠----------
local Bones = {"IK_L_Hand", "IK_R_Hand","IK_Head","IK_L_Foot", "IK_R_Foot"}
local Flashman_speed = 5
menu.toggle_loop(Flashman_features,"闪电侠", {""}, "", function ()
    if ENTITY.DOES_ENTITY_EXIST(players.user_ped()) then
        menu.trigger_commands("gracefullanding on")
        menu.trigger_commands("superjump on")
        menu.trigger_commands("walkspeed 1")
        menu.trigger_commands("superrun 0")
        util.yield()
        menu.trigger_commands("walkspeed "..Flashman_speed)
        menu.trigger_commands("superrun 0.3")
        util.yield()
        Flashman_ptfx = true
        quick_attack = true
        if ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(players.user_ped()) > 1.5 and not PED.IS_PED_JUMPING(players.user_ped()) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 1) then
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 1, 0.0, 0.0, -100, 0.0, 0.0, 0.0, PED.GET_PED_BONE_INDEX(players.user_ped(), 0x322c), true, true, true, false, true)
        end
        if ENTITY.GET_ENTITY_SPEED(players.user_ped()) * 3.6 >= 200 then
            local _entities = {}
            local player_pos = players.get_position(players.user())
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
                if v3.distance(player_pos, vehicle_pos) <= 7 then
                    table.insert(_entities, vehicle)
                end
            end
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
                if (v3.distance(player_pos, ped_pos) <= 7) and not PED.IS_PED_A_PLAYER(ped) then
                    table.insert(_entities, ped)
                end
            end
            for i, entity in pairs(_entities) do
                local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
                local entity_type = ENTITY.GET_ENTITY_TYPE(entity)
                if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and not (player_vehicle == entity) then
                    local force = ENTITY.GET_ENTITY_COORDS(entity)
                    v3.sub(force, player_pos)
                    v3.normalise(force)
                    if (0 == 1) then
                        v3.mul(force, -1)
                    end
                    if (entity_type == 1) then
                        PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                    end
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, force.x+1, force.y+1, force.z+5, 0, 0, 100, 0, false, false, true, false, false)
                end
            end
        end
    end
end, function ()
    util.yield(100)
    menu.trigger_commands("walkspeed 1")
    menu.trigger_commands("superrun 0")
    menu.trigger_commands("gracefullanding off")
    menu.trigger_commands("superjump off")
    Flashman_ptfx = false
    quick_attack = false
end)


util.create_tick_handler(function ()
    if Flashman_ptfx then
        request_ptfx_asset("scr_rcbarry2")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
        for _, bone in pairs(Bones) do
            local bone_index = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(players.user_ped(), bone)
            local coords = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), bone_index)
            if coords:magnitude() > 0 then
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
                if color then GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(color.r, color.g, color.b) end
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                    "scr_exp_clown_trails", players.user_ped(),
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    bone_index,
                    1.0,
                    false, false, false
                )
            end
        end
        util.yield(200)
    end
end)

util.create_tick_handler(function ()
    if quick_attack then
        if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 130) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 50) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 51) then
            PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
        end
    end
end)
    --PED.SET_PED_MIN_MOVE_BLEND_RATIO(players.user_ped(),100)
menu.slider(Flashman_features, "速度", {}, "", 1, 20, 1, 1, function(value)
    Flashman_speed = value + 4
end)



--[[local bb = "anim@mp_player_intcelebrationmale@heart_pumping"
local cc = "heart_pumping"
menu.toggle_loop(Flashman_features, "IKUN", {""}, "", function()
    while not STREAMING.HAS_ANIM_DICT_LOADED(bb) do 
        STREAMING.REQUEST_ANIM_DICT(bb)
        util.yield()
    end
    ENTITY.SET_ENTITY_ANIM_SPEED(players.user_ped(),bb,cc,10)
    util.yield(100)
    TASK.TASK_PLAY_ANIM(players.user_ped(), bb,cc, 3, 3, -1, 51, 0, false, false, false)
end)]]


----------钢铁侠----------
menu.toggle_loop(Ironman_features, "钢铁侠", {""}, "", function()
    menu.trigger_commands("levitate on")
    menu.trigger_commands("levitatebuttoninstructions off")
    local context = CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    if startViewMode == nil then
        startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    end
    if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) != 4 then
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
    end
    scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("REMOTE_SNIPER_HUD")
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, "REMOTE_SNIPER_HUD")
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    if not (util.is_key_down(0x01) or util.is_key_down(0x02) or util.is_key_down(0x45)) then return end
    local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local b = get_offset_from_cam(80)
    local hash
    if util.is_key_down(0x01) then
        hash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                util.yield()
            end
        end
    elseif util.is_key_down(0x02) then
        hash = util.joaat("WEAPON_RAYPISTOL")
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
    else
        hash = util.joaat("WEAPON_RPG")
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
        a.x += math.random(0, 100) / 100
        a.y += math.random(0, 100) / 100
        a.z += math.random(0, 100) / 100
    end
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat("WEAPON_UNARMED"), true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(a.x, a.y, a.z,b.x, b.y, b.z, 200, true, hash, PLAYER.PLAYER_PED_ID(), true, true, -1.0)
end,function ()
    menu.trigger_commands("levitate off")
    menu.trigger_commands("levitatebuttoninstructions on")
    util.yield_once()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)

----------祖国人----------

menu.toggle(Superman_features, "祖国人", {""}, "", function(toggle) 
    NOTIF("空格上升\nCtrl下降\nE键使用激光眼\nG键使用抛掷")
    if toggle then
    menu.trigger_commands("lasereyes on")
        menu.trigger_commands("throwvehspeds on")
        menu.trigger_commands("supermanfly on")
    else
        menu.trigger_commands("lasereyes off")
        menu.trigger_commands("supermanfly off")
        menu.trigger_commands("throwvehspeds off")
    end
end)

superman_lasereyes = menu.toggle_loop(Superman_features, "激光眼", {"lasereyes"}, "", function(on)
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end)
menu.set_visible(superman_lasereyes,false)

dow_block = 0
walkonair = false
superman_fly = menu.toggle(Superman_features, "飞行", {"supermanfly"}, "", function(on)
    if on then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        woa_ht = pos["z"] - 1.00
        walkonair = true
    else
        walkonair = false
    end
end)
menu.set_visible(superman_fly,false)
util.create_thread(function()
    while true do
        if walkonair then
            if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
                local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
                request_model(hash)
                local c = {}
                c.x = 0.0
                c.y = 0.0
                c.z = 0.0
                dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c["x"], c["y"], c["z"], true, false, false)
                ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
                ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
            end
        end
        if walkonair then
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if car == 0 then
                local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
                local boxpos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
                if MISC.GET_DISTANCE_BETWEEN_COORDS(pos["x"], pos["y"], pos["z"], boxpos["x"], boxpos["y"], boxpos["z"], true) >= 5 then
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos["x"], pos["y"], woa_ht, false, false, false)
                    ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                end
                if PAD.IS_CONTROL_PRESSED(22, 22) then
                    woa_ht = woa_ht + 0.1
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos["x"], pos["y"], woa_ht, false, false, false)
                end
                if PAD.IS_CONTROL_PRESSED(36, 36) then
                    woa_ht = woa_ht - 0.1
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos["x"], pos["y"], woa_ht, false, false, false)
                end
            end
        elseif dow_block ~= 0 then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
        end
        util.yield()
    end
end)

function request_ptfx_asset_lasereyes(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function get_closest_veh_or_ped(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(veh))
        if this_dist < closest_dist  and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            closest = veh
            closest_dist = this_dist
        end
    end
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped)  and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            closest = ped
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end


local entity_held = 0
local are_hands_up = false

superman_throwvehspeds = menu.toggle_loop(Superman_features,"抛掷物体", {"throwvehspeds"}, "", function(on)
    if util.is_key_down(0x47) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh_or_ped(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
        end
    end
end)
menu.set_visible(superman_throwvehspeds,false)
----------恶灵骑士----------
function become_effects(entity)
    local pos = ENTITY.GET_ENTITY_COORDS(entity)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_clown_death", pos.x, pos.y, pos.z, 0, 0, 0, 2.5, false, false, false)
end
local burning_man_ptfx_asset = "core"
local burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
local trail_bones = {0xffa, 0xfa11, 0x83c, 0x512d, 0x796e, 0xb3fe, 0x3fcf, 0x58b7, 0xbb0}
local looped_ptfxs = {}
menu.toggle(Ghostrider_features, "恶灵骑士", {""}, "", function(on)
    if on then 
        become_effects(players.user_ped())
        util.yield(1000)
        request_ptfx_asset(burning_man_ptfx_asset)
        for _, bone in pairs(trail_bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = PED.GET_PED_BONE_INDEX(players.user_ped(), bone)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, players.user_ped(), 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.5, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    else
        for _, p in pairs(looped_ptfxs) do
            GRAPHICS.REMOVE_PARTICLE_FX(p, false)
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(p, false)
        end
    end
end)

local Ghostrider_vehicle_bones = {"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}
local Ghostrider_vehicle_select = {"生成", "传送到你", "删除"}
menu.textslider_stateful(Ghostrider_features, "恶灵骑士摩托", {}, "", Ghostrider_vehicle_select, function(Ghostrider)
    pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),false)
    pos.y = pos.y + 5
    request_model(1491277511)
    if Ghostrider == 1 then
        Ghostrider_vehicle_model = entities.create_vehicle(1491277511,pos,0)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(Ghostrider_vehicle_model,true)
        become_effects(Ghostrider_vehicle_model )
        HUD.ADD_BLIP_FOR_ENTITY(Ghostrider_vehicle_model )
        util.yield(1000)
        request_ptfx_asset(burning_man_ptfx_asset)
        for _, bone in pairs(Ghostrider_vehicle_bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(Ghostrider_vehicle_model , bone)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, Ghostrider_vehicle_model, 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    end
    if Ghostrider == 2 then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ghostrider_vehicle_model , pos.x, pos.y, pos.z, false, false, false)
    end
    if Ghostrider == 3 then
        entities.delete_by_handle(Ghostrider_vehicle_model )
    end
end)

local other_vehicle_bones = {"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}
menu.toggle_loop(Ghostrider_features, "恶灵骑士载具", {""}, "", function()
    if SHOW_NOTIF then
		NOTIF("按E可以将当前载具转换为恶灵骑士载具")
		SHOW_NOTIF = false
	end
    other_vehicle = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    if util.is_key_down(0x45) then 
        become_effects(other_vehicle)
        util.yield(1000)
        request_ptfx_asset(burning_man_ptfx_asset)
        for _, bone in pairs(other_vehicle_bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(other_vehicle, bone)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, other_vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    end
end,function()
    SHOW_NOTIF = true
    util.yield(100)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(other_vehicle)
end)
local is_using_ghostrider_skill = true
menu.toggle_loop(Ghostrider_features, "恶灵骑士技能", {""}, "", function()
    if SHOW_NOTIF then
		NOTIF("按G使用恶灵骑士技能")
		SHOW_NOTIF = false
	end
    vehicle = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    model = 175300549
    if util.is_key_down(0x47) then
        if is_using_ghostrider_skill then
            request_model(model)
            local pos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
            spawn = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(
                spawn, vehicle, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER.PLAYER_PED_ID(), "headlight_r"),
                0, 0, 0,
                0, 0, 0,
                false, true, false, false, 0, true
            )
            is_using_ghostrider_skill = false
        end
        request_ptfx_asset("weap_xs_vehicle_weapons")
        GRAPHICS.USE_PARTICLE_FX_ASSET("weap_xs_vehicle_weapons")
        fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("muz_xs_turret_flamethrower_looping_sf", spawn, 0.0, 0.8, 0.0, 0.0, 50.0, 0.0, 0, 10, false, false, false, 0, 0, 0, 0)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        util.yield(200)
    else
        if not is_using_ghostrider_skill then
            entities.delete_by_handle(spawn)
        end
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(spawn)
        is_using_ghostrider_skill = true
    end
end,function ()
    SHOW_NOTIF = true
    is_using_ghostrider_skill = true
end)
----------火影忍者----------

menu.action(Naruto_features, "神罗天征",{},"辛辣天塞 :)", function()  
    push = 0
    playmusic(filesystem.store_dir() .. "\\LM\\".."Shinratense.wav")
    menu.trigger_commands("playanimgangsign")
    playerpos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), playerpos.x, playerpos.y, playerpos.z, 0, 0, false, true, 2)
    while push <= 100 do
        local pushToX = 1
        local pushToY = 1
        local pushToZ = 1    
        local Pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())     
        local Vehicle = entities.get_all_vehicles_as_handles()
        local Object = entities.get_all_objects_as_handles()
        local PED = entities.get_all_peds_as_handles()
        for index, value in ipairs(Vehicle) do
            vehiclePos = ENTITY.GET_ENTITY_COORDS(value)
            if ENTITY.DOES_ENTITY_EXIST(value) == true then
                if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                end
                if Pos.x > vehiclePos.x then
                    pushToX = -push
                elseif Pos.x < vehiclePos.x then
                    pushToX = push
                end
                if Pos.y > vehiclePos.y then
                    pushToY = -push
                elseif Pos.y < vehiclePos.y then
                    pushToY = push
                end
                if Pos.z > vehiclePos.z then
                    pushToZ = -push
                elseif Pos.z < vehiclePos.z then
                    pushToZ = push
                end
                    ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                end
            end
            for index, value in ipairs(Object) do
                objectPos = ENTITY.GET_ENTITY_COORDS(value)
                if ENTITY.DOES_ENTITY_EXIST(value) == true then
                    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                    end
                    if Pos.x > objectPos.x then
                        pushToX = -push
                    elseif Pos.x < objectPos.x then
                        pushToX = push
                    end
                    if Pos.y > objectPos.y then
                        pushToY = -push
                    elseif Pos.y < objectPos.y then
                        pushToY = push
                    end
                    if Pos.z > objectPos.z then
                        pushToZ = -push
                    elseif Pos.z < objectPos.z then
                        pushToZ = push
                    end
                        ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                    end
                end
                for index, value in ipairs(PED) do
                    if players.user_ped() ~= value and not ENTITY.IS_ENTITY_DEAD(value) then
                    PEDPos = ENTITY.GET_ENTITY_COORDS(value)
                    if ENTITY.DOES_ENTITY_EXIST(value) == true then
                        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                        end
                        if Pos.x > PEDPos.x then
                            pushToX = -push
                        elseif Pos.x < PEDPos.x then
                            pushToX = push
                        end
                        if Pos.y > PEDPos.y then
                            pushToY = -push
                        elseif Pos.y < PEDPos.y then
                            pushToY = push
                        end
                        if Pos.z > PEDPos.z then
                            pushToZ = -push
                        elseif Pos.z < PEDPos.z then
                            pushToZ = push
                        end
                        ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                    end
                end
                GRAPHICS.DRAW_MARKER_SPHERE(Pos.x, Pos.y, Pos.z, push, 255, 255, 255, 0.5) 
                push = push + 0.01
            end
        util.yield()
    end
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
end) 

----------武器工坊----------

menu.toggle_loop(weapon_features, "一拳超人", {"OnePunchMan"}, "", function()
    local pWeapon = memory.alloc_int()
    WEAPON.GET_CURRENT_PED_WEAPON(players.user_ped(), pWeapon, 1)
    local weaponHash = memory.read_int(pWeapon)
    if WEAPON.IS_PED_ARMED(players.user_ped(), 1) or weaponHash == util.joaat("weapon_unarmed") then
        local pImpactCoords = v3.new()
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), pImpactCoords) then
            set_explosion_proof(players.user_ped(), true)
            util.yield_once()
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
        elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
            set_explosion_proof(players.user_ped(), false)
        end
    end
end)

menu.toggle(weapon_features, "强力大锤", {"bighammer"}, "", function(toggle)
    menu.trigger_commands("damagemultiplier 1000")
    menu.trigger_commands("rangemultiplier 1.5")
    if toggle then
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
        obj_1 = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
        obj_2 = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj_1, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj_2,obj_1, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.create_tick_handler(function()
            WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), -1810795771, true)
        end)
    else
        util.yield(100)
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
        entities.delete_by_handle(obj_1)
        entities.delete_by_handle(obj_2)
        menu.trigger_commands("damagemultiplier 0.1")
        util.yield(200)
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
    end
end)

menu.toggle(weapon_features, "武士刀",{"katana"}, "",function(toggle)
    katana_running = toggle
    if katana_running then
        NOTIF("切枪可以将武士刀背在背上")
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        katana_model = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(),1317494643,15,true,true)
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)
        util.create_tick_handler(function()
            if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(players.user_ped()) == 1317494643) then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(katana_model, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
                util.yield(300)
                WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), false, false, false, false)
            else
                ENTITY.ATTACH_ENTITY_TO_ENTITY(katana_model, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 0), 0.1, -0.15, 0.5, 0, -150,0,false, false, false, false, 2, true)
                WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(players.user_ped(), true, false, false, false)
            end
        return katana_running end)
    else
        util.yield(100)
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        entities.delete_by_handle(katana_model)
    end
end)

local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end

menu.toggle(weapon_features, "核弹枪", {"nukeGun"}, "", function(toggle)
    nuke_running = toggle
    if nuke_running then
        if animals_running then menu.trigger_command(exp_animal_toggle, "off") end
        util.create_tick_handler(function()
                if PED.IS_PED_SHOOTING(players.user_ped()) then
                    if not remove_projectiles then
                        remove_projectiles = true
                        disableProjectileLoop(-1312131151)
                    end
                    util.create_thread(function()
                        local hash = util.joaat("w_arena_airmissile_01a")
                        STREAMING.REQUEST_MODEL(hash)
                        local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                        local dir, pos = direction()
                        local bomb = entities.create_object(hash, pos)
                        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                        ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
                        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do util.yield() end
                        local pos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                        entities.delete(bomb)
                        executeNuke(pos)
                    end)
                else
                    remove_projectiles = false
                end
            return nuke_running
        end)
    end
end)

menu.toggle(weapon_features, "核弹枪[ Little Boy ]", {"LittleBoyGun"}, "Little Boy?  :)", function(toggle)
    nuke_running = toggle
    if nuke_running then
        if animals_running then menu.trigger_command(exp_animal_toggle, "off") end
        util.create_tick_handler(function()
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if not remove_projectiles then
                    remove_projectiles = true
                    disableProjectileLoop(-1312131151)
                end
                util.create_thread(function()
                    local hash = util.joaat("tr_prop_tr_military_pickup_01a")
                    STREAMING.REQUEST_MODEL(hash)
                    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    local dir, pos = direction()
                    local bomb = entities.create_object(hash, pos)
                    ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                    ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
                    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do util.yield() end
                    local pos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                    entities.delete(bomb)
                    executeLittle_Boy(pos)
                end)
                remove_projectiles = false
            else
                remove_projectiles = false
            end
            return nuke_running
        end)
    end
end)

menu.toggle_loop(weapon_features,  "天基枪", {}, "", function(toggle)
	local expCoordsInst = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), expCoordsInst) then
		local expCoords = v3.new(v3.get(expCoordsInst))
        FIRE.ADD_EXPLOSION(expCoords.x, expCoords.y, expCoords.z, 59, 5000, true, false, 1.0, false)
        start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", expCoordsInst, v3_2t1(0, 180, 0), 4.5, true, true, true)
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
         while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
            STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
            util.yield()
        end
        start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", expCoordsInst, v3_2t1(0, 180, 0), 1.0, true, true, true)
        for i = 1, 4 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
        end
    end
end)

menu.toggle_loop(weapon_features,  "雷电枪", {}, "", function(toggle)
	local expCoordsInst = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), expCoordsInst) then
		local expCoords = v3.new(v3.get(expCoordsInst))
        FIRE.ADD_EXPLOSION(expCoords.x, expCoords.y, expCoords.z, 59, 100, true, false, 0, false)
        start_networked_ptfx_non_looped_at_coord_2t1("blood_stungun", expCoordsInst, v3_2t1(-90, 0, 0), 50, true, true, true)
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
         while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("core") do
            STREAMING.REQUEST_NAMED_PTFX_ASSET("core")
            util.yield()
        end
        start_networked_ptfx_non_looped_at_coord_2t1("blood_stungun", expCoordsInst, v3_2t1(-90, 0, 0), 50, true, true, true)
        MISC.FORCE_LIGHTNING_FLASH()
    end
end)

menu.toggle_loop(weapon_features, "踢出枪", {"kickgun"}, "", function()
    local ent = get_aim_info()["ent"]
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                if players.get_host() == pid then 
                    NOTIF("您正试图踢出的玩家是主机")
                    return
                end
                menu.trigger_commands("kick" .. players.get_name(pid))
            end
        end
    end
end)

menu.toggle_loop(weapon_features, "崩溃枪", {"crashgun"}, "", function()
    local ent = get_aim_info()["ent"]
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("crash" .. players.get_name(pid))
            end
        end
    end
end)

menu.toggle_loop(weapon_features, "转魂枪", {""}, "距离太远可能会不起作用", function()
    local ent = get_aim_info()["ent"]
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            pos = ENTITY.GET_ENTITY_COORDS(ent, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("copyoutfit " .. players.get_name(pid))
            else
            local soul = ENTITY.GET_ENTITY_MODEL(ent)
            util.request_model(soul)
            util.yield(10)
            PLAYER.SET_PLAYER_MODEL(players.user(),soul)
            if not PED.IS_PED_A_PLAYER(ent) then
                entities.delete_by_handle(ent)
            end
            util.yield(10)
            menu.trigger_commands("allguns")
        end
    end
    if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
        if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
            local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
            if not PED.IS_PED_A_PLAYER(driver) then
                entities.delete_by_handle(driver)
            end
            util.request_model(soulveh)
            util.yield(10)
            PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
            util.yield(10)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            menu.trigger_commands("allguns")
            end
        end
    end
end)

----------模型选项----------

----------附加模型----------
function delete_object(model)
    for k, object in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(object) == model then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false) 
            entities.delete_by_handle(object)
        end
    end
end

menu.toggle(attach_model, "坤坤", {""}, "", function(toggle)
    local model = util.joaat("vw_prop_casino_art_mod_05a")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    request_model(model)
	spawn = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        spawn, PLAYER.PLAYER_PED_ID(), ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER.PLAYER_PED_ID(), "IK_Head"),
        -0.1, 0, 0,
        180, -90, 0,
        false, true, false, false, 0, true
    )
    if not toggle then
        delete_object(model)
    end
end)

menu.toggle(attach_model, "鹿头", {""}, "", function(toggle)
    local model = util.joaat("vw_prop_casino_art_deer_01a")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    request_model(model)
	spawn = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        spawn, PLAYER.PLAYER_PED_ID(), ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER.PLAYER_PED_ID(), "IK_Head"),
        0.3, 0, 0,
        -180, -90, 0,
        false, true, false, false, 0, true
    )
    if not toggle then
        delete_object(model)
    end
end)

menu.toggle(attach_model, "黄金翅膀", {""}, "", function(toggle)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local model = util.joaat("vw_prop_art_wings_01a")
    request_model(model)
	local wings = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
    if not toggle then
        delete_object(model)
    end
end)

menu.toggle(attach_model, "银色翅膀", {""}, "", function(toggle)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local model = util.joaat("vw_prop_art_wings_01b")
    request_model(model)
	local wings = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
    if not toggle then
        delete_object(model)
    end
end)

-----------------------------
local Aerocraft_select = {"生成", "传送上飞行器", "删除"}

menu.textslider_stateful(model_features, "飞行器", {}, "", Aerocraft_select, function(Aerocraft)
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local aircraft_model = util.joaat("prop_boogieboard_01")
    local oppressor = util.joaat("oppressor2")
    request_model(aircraft_model)
    request_model(oppressor)
    STREAMING.REQUEST_ANIM_DICT("anim@heists@heist_corona@team_idles@male_a")
    if Aerocraft == 1 then
        obj = entities.create_object(aircraft_model, pos)
        veh = entities.create_vehicle(oppressor, pos, 0)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
        util.yield(100)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0.05, 0.2, -90, 0, 0, true, false, false, false, 0, true)
    end
    if Aerocraft == 2 then
        cloneplayer = PED.CLONE_PED(players.user_ped(),true, true, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(cloneplayer)
        TASK.TASK_PLAY_ANIM(cloneplayer, "anim@heists@heist_corona@team_idles@male_a", "idle", 8, -8, -1, 1, 0, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(cloneplayer,veh,0, 0, 0, 1.25, 0, 0, 0, true, false, false, true, 0, true)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
    end
    if Aerocraft == 3 then
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
        entities.delete_by_handle(cloneplayer)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    end
    while Aerocraft do
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), veh, false) then
            if not ENTITY.DOES_ENTITY_EXIST(cloneplayer) then
                cloneplayer = PED.CLONE_PED(players.user_ped(),true, true, true)
            end
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(cloneplayer)
            TASK.TASK_PLAY_ANIM(cloneplayer, "anim@heists@heist_corona@team_idles@male_a", "idle", 8, -8, -1, 1, 0, false, false, false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(cloneplayer,veh,0, 0, 0, 1.25, 0, 0, 0, true, false, false, true, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
        else
            entities.delete_by_handle(cloneplayer)
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

local SurfBoard_select = {"生成", "传送上冲浪板", "删除"}

menu.textslider_stateful(model_features, "冲浪板", {}, "", SurfBoard_select, function(SurfBoard)
    if not ENTITY.IS_ENTITY_IN_WATER(players.user_ped()) then NOTIF("不去水里冲你妈啊") return end
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local surf_board = util.joaat("prop_surf_board_01")
    local seashark = util.joaat("seashark3")
    request_model(surf_board)
    request_model(seashark)
    STREAMING.REQUEST_ANIM_DICT("anim@heists@heist_corona@team_idles@male_a")
    if SurfBoard == 1 then
        obj = entities.create_object(surf_board, pos)
        veh = entities.create_vehicle(seashark, pos, 0)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
        util.yield(100)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0.05, 0.2, -90, 0, 0, true, false, false, false, 0, true)
    end
    if SurfBoard == 2 then
        cloneplayer = PED.CLONE_PED(players.user_ped(),true, true, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(cloneplayer)
        TASK.TASK_PLAY_ANIM(cloneplayer, "anim@heists@heist_corona@team_idles@male_a", "idle", 8, -8, -1, 1, 0, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(cloneplayer,veh,0, 0, 0, 1.25, 0, 0, 0, true, false, false, true, 0, true)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
    end
    if SurfBoard == 3 then
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
        entities.delete_by_handle(cloneplayer)
        ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    end
    while SurfBoard do
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), veh, false) then
            if not ENTITY.DOES_ENTITY_EXIST(cloneplayer) then
                cloneplayer = PED.CLONE_PED(players.user_ped(),true, true, true)
            end
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(cloneplayer)
            TASK.TASK_PLAY_ANIM(cloneplayer, "anim@heists@heist_corona@team_idles@male_a", "idle", 8, -8, -1, 1, 0, false, false, false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(cloneplayer,veh,0, 0, 0, 1.25, 0, 0, 0, true, false, false, true, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
        else
            entities.delete_by_handle(cloneplayer)
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

menu.action(model_features, "变成红领雪人", {}, "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local snowman = util.joaat("xm3_prop_xm3_snowman_01a")
    local minitank = util.joaat("minitank")
    request_model(snowman)
    request_model(minitank)
    obja = entities.create_object(snowman, pos)
    veha = entities.create_vehicle(minitank, pos, 0)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), veha, -1)
    ENTITY.SET_ENTITY_VISIBLE(veha, false, false)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obja, veha, 0, 0, 0, 0, 0, 0, -180, true, false, false, false, 0, true)
    while true do
        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), veha, false) then
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

menu.action(model_features, "变成蓝领雪人", {}, "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local snowman = util.joaat("xm3_prop_xm3_snowman_01b")
    local minitank = util.joaat("minitank")
    request_model(snowman)
    request_model(minitank)
    objb = entities.create_object(snowman, pos)
    vehb = entities.create_vehicle(minitank, pos, 0)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehb, -1)
    ENTITY.SET_ENTITY_VISIBLE(vehb, false, false)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    util.yield(100)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(objb, vehb, 0, 0, 0, 0, 0, 0, -180, true, false, false, false, 0, true)
    while true do
        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), vehb, false) then
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

menu.action(model_features, "变成绿领雪人", {}, "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local snowman = util.joaat("xm3_prop_xm3_snowman_01c")
    local minitank = util.joaat("minitank")
    request_model(snowman)
    request_model(minitank)
    objc = entities.create_object(snowman, pos)
    vehc = entities.create_vehicle(minitank, pos, 0)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehc, -1)
    ENTITY.SET_ENTITY_VISIBLE(vehc, false, false)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    util.yield(100)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(objc, vehc, 0, 0, 0, 0, 0, 0, -180, true, false, false, false, 0, true)
    while true do
        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), vehc, false) then
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

menu.action(model_features, "变成胖头娃娃", {}, "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local snowman = util.joaat("vw_prop_casino_art_mod_06a")
    local minitank = util.joaat("minitank")
    request_model(snowman)
    request_model(minitank)
    objc = entities.create_object(snowman, pos)
    vehc = entities.create_vehicle(minitank, pos, 0)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehc, -1)
    ENTITY.SET_ENTITY_VISIBLE(vehc, false, false)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    util.yield(100)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(objc, vehc, 0, 0, 0, 0, 0, 0, -180, true, false, false, false, 0, true)
    while true do
        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), vehc, false) then
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)

----------粒子特效----------
function play_on_entity_bones(entity, bones, ptfx_group, ptfx_name, color)
    request_ptfx_asset(ptfx_group)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_group)
    for _, bone in pairs(bones) do
        local bone_index = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(entity, bone)
        local coords = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, bone_index)
        if coords:magnitude() > 0 then
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_group)
            if color then GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(color.r, color.g, color.b) end
            GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                ptfx_name, entity,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                bone_index,
                1.0,
                false, false, false
                )
            end
        end
end

ptfx_list = function(root, loop)
    for _, ptfx in pairs(ptfx_name) do
        menu.toggle_loop(root, ptfx[2], {}, "使用粒子特效: " .. ptfx[2], function()
            loop(ptfx)
        end)
    end
end

ptfx_color = {r = 1.0, g = 1.0, b = 1.0}
menu.colour(ptfx_features, "颜色", {}, "", 1.0, 1.0, 1.0, 1.0, false, function(value)
    ptfx_color.r = value.r
    ptfx_color.g = value.g
    ptfx_color.b = value.b
end)

playerbones = {
    Head = {"IK_Head"},
    Hands = {"IK_L_Hand", "IK_R_Hand"},
    Pointer = {"IK_L_Hand"},
    Feet = {"IK_L_Foot", "IK_R_Foot"}
}
menu.divider(ptfx_features, "玩家")
local ptfx_head = menu.list(ptfx_features, "头部", {}, "" )
ptfx_list(ptfx_head, function(ptfx)
    play_on_entity_bones(players.user_ped(), playerbones.Head, ptfx[1], ptfx[2], ptfx_color)
    util.yield(ptfx[3])
end)

local ptfx_hands = menu.list(ptfx_features, "手部", {}, "")
ptfx_list(ptfx_hands, function(ptfx)
    play_on_entity_bones(players.user_ped(), playerbones.Hands, ptfx[1], ptfx[2], ptfx_color)
    util.yield(ptfx[3])
end)

local ptfx_feet = menu.list(ptfx_features, "脚部", {}, "")
ptfx_list(ptfx_feet, function(ptfx)
    play_on_entity_bones(players.user_ped(), playerbones.Feet, ptfx[1], ptfx[2], ptfx_color)
    util.yield(ptfx[3])
end)


local ptfx_pointer = menu.list(ptfx_features, "手指", {}, "")
ptfx_list(ptfx_pointer, function(ptfx)
    if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
        play_on_entity_bones(players.user_ped(), playerbones.Pointer, ptfx[1], ptfx[2], ptfx_color)
        util.yield(ptfx[3])
    end
end)

vehiclebones = {
    Wheels = {"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"},
    Exhaust = {"exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5", "exhaust_6", "exhaust_7", "exhaust_8"}
}
menu.divider(ptfx_features, "载具")
local ptfx_wheels = menu.list(ptfx_features, "车轮", {}, "")
ptfx_list(ptfx_wheels, function(ptfx)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
    if vehicle ~= 0 then
        play_on_entity_bones(vehicle, vehiclebones.Wheels, ptfx[1], ptfx[2], ptfx_color)
        util.yield(ptfx[3])
    end
end)

local ptfx_exhaust = menu.list(ptfx_features, "排气管", {}, "")
ptfx_list(ptfx_exhaust, function(ptfx)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
    if vehicle ~= 0 then
        play_on_entity_bones(vehicle, vehiclebones.Exhaust, ptfx[1], ptfx[2], ptfx_color)
        util.yield(ptfx[3])
    end
end)
--------------------------------
------------ 载具选项 ------------
--------------------------------

----------秋名山车神---------- by lancescript_reloaded
player_cur_car = 0

initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end


        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end

    end
end

menu.toggle_loop(vehicle_drift, "显示车辆角度", {"carangle"}, "", function()
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        local ang = math.abs(math.ceil(math.abs(ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0).z) - math.abs(CAM.GET_GAMEPLAY_CAM_ROT(0).z)))
        directx.draw_text(0.5, 1.0, tostring(ang) .. "°", 5, 1.4, {r=1, g=1, b=1, a=1}, true)
    end
end)

menu.toggle_loop(vehicle_drift, "按住shift键进行漂移", {"dshiftdrift"}, "", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)

local shift_drift_toggle = false 
menu.toggle(vehicle_drift, "开关换挡(shift)漂移", {"shiftdrifttoggle"}, "建议绑定一个快捷键", function(on)
    shift_drift_toggle = on
    while true do
        if player_cur_car ~= 0 then 
            if not shift_drift_toggle then 
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
                break 
            end
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
        end
        util.yield()
    end
end)

menu.toggle_loop(vehicle_drift,  "相机方向推力", {"thrustindir"}, "", function(on)
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        if util.is_key_down("X") then 
            cam_direction()
        else 
            before_vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        end
    end
end)
menu.slider_float(vehicle_drift, "相机方向推力的速度", {"thrustindiradd"}, "相机方向的推力需要增加多少额外速度", 0, 3000, 125, 1, function(s)
    thrust_cam_dir_add = s * -0.001
end)

util.create_thread(function()
    local last_car = 0
        while true do
            player_cur_car = entities.get_user_vehicle_as_handle()
            if last_car ~= player_cur_car and player_cur_car ~= 0 then 
                on_user_change_vehicle(player_cur_car)
                last_car = player_cur_car
            end
            util.yield()
        end    
    end)

----------载具改装----------

menu.action(vehicle_modification, "随机改装", {}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), include_last_vehicle_for_vehicle_functions)
    if vehicle == 0 then NOTIF("不上车改你妈啊") else
        for mod_type = 0, 48 do
            local num_of_mods = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, mod_type)
            local random_tune = math.random(-1, num_of_mods - 1)
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, mod_type, math.random(0,1) == 1)
            VEHICLE.SET_VEHICLE_MOD(vehicle, mod_type, random_tune, false)
        end
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, math.random(0,160), math.random(0,160))
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(0,6))
        for index = 0, 3 do
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, index, math.random(0,1) == 1)
        end
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        menu.trigger_command(menu.ref_by_path("Vehicle>Los Santos Customs>Appearance>Wheels>Wheels Colour", 42), math.random(0,160))
    end
end)

menu.toggle_loop(vehicle_modification, "随机改装(循环)", {}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), include_last_vehicle_for_vehicle_functions)
    if vehicle == 0 then NOTIF("不上车改nm装啊") else
        for mod_type = 0, 48 do
            local num_of_mods = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, mod_type)
            local random_tune = math.random(-1, num_of_mods - 1)
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, mod_type, math.random(0,1) == 1)
            VEHICLE.SET_VEHICLE_MOD(vehicle, mod_type, random_tune, false)
        end
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, math.random(0,160), math.random(0,160))
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(0,6))
        for index = 0, 3 do
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, index, math.random(0,1) == 1)
        end
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        menu.trigger_command(menu.ref_by_path("Vehicle>Los Santos Customs>Appearance>Wheels>Wheels Colour", 42), math.random(0,160))
    end
end)

local rapid_khanjali
rapid_khanjali = menu.toggle_loop(vehicle_modification, "可汗贾利快速射击", {}, "", function()
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    if ENTITY.GET_ENTITY_MODEL(player_veh) == util.joaat("khanjali") then
        VEHICLE.SET_VEHICLE_MOD(player_veh, 10, math.random(-1, 0), false)
    else
        NOTIF("请先驾驶可汗贾利")
        menu.trigger_command(rapid_khanjali, "off")
    end
end)
----------载具车窗----------

local VehicleWindows_ListItem = {
    { "全部" },
    { "左前车窗" }, -- 0
    { "右前车窗" }, -- 1
    { "左后车窗" }, -- 2
    { "右后车窗" }, -- 3
    { "前挡风车窗" }, -- 4
    { "后挡风车窗" } -- 5
}
local vehicle_window_select = 1 --选择的车窗

menu.list_select(vehicle_window, "选择车窗", {}, "", VehicleWindows_ListItem, 1, function(value)
    vehicle_window_select = value
end)

menu.toggle_loop(vehicle_window, "修复车窗", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_window_select == 1 then
            for i = 0, 7 do
                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, i)
            end
        elseif vehicle_window_select > 1 then
            VEHICLE.FIX_VEHICLE_WINDOW(vehicle, vehicle_window_select - 2)
        end
    end
end)

menu.toggle_loop(vehicle_window, "摇下车窗", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_window_select == 1 then
            for i = 0, 7 do
                VEHICLE.ROLL_DOWN_WINDOW(vehicle, i)
            end
        elseif vehicle_window_select > 1 then
            VEHICLE.ROLL_DOWN_WINDOW(vehicle, vehicle_window_select - 2)
        end
    end
end, function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_window_select == 1 then
            for i = 0, 7 do
                VEHICLE.ROLL_UP_WINDOW(vehicle, i)
            end
        elseif vehicle_window_select > 1 then
            VEHICLE.ROLL_UP_WINDOW(vehicle, vehicle_window_select - 2)
        end
    end
end)

menu.toggle_loop(vehicle_window, "粉碎车窗", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_window_select == 1 then
            for i = 0, 7 do
                VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, i)
            end
        elseif vehicle_window_select > 1 then
            VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, vehicle_window_select - 2)
        end
    end
end)

----------载具锁门----------

local VehicleDoorsLock_ListItem = {
    { "解锁" }, --VEHICLELOCK_UNLOCKED == 1
    { "上锁" }, --VEHICLELOCK_LOCKED
    { "只对玩家锁门" }, --VEHICLELOCK_LOCKOUT_PLAYER_ONLY
    { "玩家锁定在里面" }, --VEHICLELOCK_LOCKED_PLAYER_INSIDE
    { "强制关闭车门" }, --VEHICLELOCK_FORCE_SHUT_DOORS
    { "上锁但可被破坏", {}, "可以破开车窗开门" }, --VEHICLELOCK_LOCKED_BUT_CAN_BE_DAMAGED
    { "上锁但后备箱解锁" }, --VEHICLELOCK_LOCKED_BUT_BOOT_UNLOCKED
    { "上锁无乘客" }, --VEHICLELOCK_LOCKED_NO_PASSENGERS
    { "不能进入", {}, "按F无上车动作" } --VEHICLELOCK_CANNOT_ENTER
}
local vehicle_door_lock_select = 1 --选择的锁门类型
menu.list_select(vehicle_doorlock, "锁门类型", {}, "", VehicleDoorsLock_ListItem, 1, function(value)
    vehicle_door_lock_select = value
end)

menu.action(vehicle_doorlock, "设置载具门锁状态", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, vehicle_door_lock_select)
    end
end)
menu.textslider_stateful(vehicle_doorlock, "设置单个门锁状态", {}, "貌似无效", { "左前门", "右前门",
    "左后门",
    "右后门" }, function(value)
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        VEHICLE.SET_VEHICLE_INDIVIDUAL_DOORS_LOCKED(vehicle, value - 1, vehicle_door_lock_select)
    end
end)

menu.toggle(vehicle_doorlock, "对所有玩家锁门", {}, "", function(toggle)
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, toggle)
    end
end)

----------载具门----------

local VehicleDoors_ListItem = {
    { "全部" },
    { "左前门" }, -- VEH_EXT_DOOR_DSIDE_F = 0
    { "右前门" }, -- VEH_EXT_DOOR_DSIDE_R = 1
    { "左后门" }, -- VEH_EXT_DOOR_PSIDE_F = 2
    { "右后门" }, -- VEH_EXT_DOOR_PSIDE_R = 3
    { "引擎盖" }, -- VEH_EXT_BONNET = 4
    { "后备箱" } -- VEH_EXT_BOOT = 5
}
local vehicle_door_select = 1 --选择的车门
menu.list_select(vehicle_door, "选择车门", {}, "", VehicleDoors_ListItem, 1, function(value)
    vehicle_door_select = value
end)

menu.toggle_loop(vehicle_door, "打开车门", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_door_select == 1 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
            end
        elseif vehicle_door_select > 1 then
            VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, vehicle_door_select - 2, false, false)
        end
    end
end)

menu.action(vehicle_door, "关闭车门", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_door_select == 1 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_SHUT(vehicle, i, false)
            end
        elseif vehicle_door_select > 1 then
            VEHICLE.SET_VEHICLE_DOOR_SHUT(vehicle, vehicle_door_select - 2, false)
        end
    end
end)

menu.toggle_loop(vehicle_door, "破坏车门", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_door_select == 1 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
            end
        elseif vehicle_door_select > 1 then
            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, vehicle_door_select - 2, false)
        end
    end
end)

menu.toggle_loop(vehicle_door, "删除车门", {}, "", function()
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_door_select == 1 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, true)
            end
        elseif vehicle_door_select > 1 then
            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, vehicle_door_select - 2, true)
        end
    end
end)

menu.toggle(vehicle_door, "车门不可损坏", {}, "", function(toggle)
    local vehicle = entities.get_user_vehicle_as_handle()
    if vehicle then
        if vehicle_door_select == 1 then
            for i = 0, 3 do
                VEHICLE.SET_DOOR_ALLOWED_TO_BE_BROKEN_OFF(vehicle, i, not toggle)
            end
        elseif vehicle_door_select > 1 then
            VEHICLE.SET_DOOR_ALLOWED_TO_BE_BROKEN_OFF(vehicle, vehicle_door_select - 2, not toggle)
        end
    end
end)

------------------------------------------------------
local function get_waypoint_pos(callback, silent)
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
        if callback then
            callback(waypoint_pos)
        end
        return waypoint_pos
    elseif not silent then
        NOTIF("没有设置导航点")
        return nil
    end
end

local smartAutoDriveData = {
    paused = false,
    lastSetTask = 0,
    lastWaypoint = nil
}
local MOVEMENT_CONTROLS = table.freeze({
    59, 60, 61, 62, 63, 64, 71, 72, 75, 76, 87, 88, 89, 90, 102, 106, 107, 108, 109, 110, 111, 112, 113, 122, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
})

menu.toggle_loop(VEHICLE_LIST, "智能自动驾驶", {"smartdrive"},"", function(on)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local my_vehicle = PED.GET_VEHICLE_PED_IS_IN(my_ped, false)
    if my_vehicle > 0 then
        if smartAutoDriveData.paused then
            if ENTITY.GET_ENTITY_SPEED(my_vehicle) <= 15 then
                smartAutoDriveData.paused = false
            end
        else
            for _, control in ipairs(MOVEMENT_CONTROLS) do
                if PAD.IS_CONTROL_PRESSED(2, control) then
                    TASK.CLEAR_PED_TASKS(my_ped)
                    smartAutoDriveData.paused = true
                    break
                end
            end
            if not smartAutoDriveData.paused then
                local waypoint = get_waypoint_pos(nil, true)
                if waypoint then
                    lastWaypoint = waypoint
                    local model = ENTITY.GET_ENTITY_MODEL(my_vehicle)
                    local now = MISC.GET_GAME_TIMER()
                    if now - smartAutoDriveData.lastSetTask > 5000 then
                        PED.SET_DRIVER_ABILITY(my_ped, 1.0)
                        PED.SET_DRIVER_AGGRESSIVENESS(my_ped, 0.6)
                        TASK.TASK_VEHICLE_DRIVE_TO_COORD(my_ped, my_vehicle, waypoint.x, waypoint.y, waypoint.z, 100, 5, model, 787004, 15.0, 1.0)
                        smartAutoDriveData.lastSetTask = now
                    end
                elseif smartAutoDriveData.lastWaypoint then
                    if ENTITY.IS_ENTITY_AT_COORD(my_vehicle, smartAutoDriveData.lastWaypoint.x, smartAutoDriveData.lastWaypoint.y, smartAutoDriveData.lastWaypoint.z, 10.0, 10.0, 10.0, 0, 1, 0) then
                        smartAutoDriveData.lastWaypoint = nil
                        smartAutoDriveData.paused = true
                        VEHICLE.BRING_VEHICLE_TO_HALT(my_vehicle, 5.0, 1)
                        TASK.CLEAR_PED_TASKS(my_ped)
                    end
                end
            end
        end
    end
end,function ()
    TASK.CLEAR_PED_TASKS(my_ped)
end)

--------------------------------
------------ 战局选项 ------------
--------------------------------

----------次世代聊天---------- by lance
local all_visible_chats = {}
function new_chat_obj(pid, player_name, player_color, tag, text)
    return {
        pid = pid,
        player_name = player_name,
        player_color = player_color,
        tag = tag,
        text = text,
        timestamp = os.time()
    }
end

local function uwu(text)
    text = string.lower(text):gsub("l", "w"):gsub("r", "w"):gsub("v", "f"):gsub("i", "i-i"):gsub("d", "d-d"):gsub("n", "n-n")
    local ran = math.random(5)
    pluto_switch ran do 
        case 2:
            text = text .. " uwu"
            break 
        case 3:
            text = text .. " nya.."
            break
        case 4:
            text = text .. " ><"
            break
    end
    return text
end

general_settings:slider("聊天长度", {"chatmaxlength"}, "", 1, 254, gConfig.next_chat.max_chat_len, 1, function(value)
    gConfig.next_chat.max_chat_len = value
end)

general_settings:slider("聊天条数", {"chatmaxchats"}, "", 1, 10, gConfig.next_chat.max_chats, 1, function(value)
    gConfig.next_chat.max_chats = value
end)

general_settings:slider("聊天显示时间", {"chatdisptime"}, "", 1, 300, gConfig.next_chat.display_time, 1, function(value)
    gConfig.next_chat.display_time = value
end)

general_settings:slider("聊天冷却时间", {"chatcooldown"}, "", 0, 10000, gConfig.next_chat.chat_cooldown_ms, 1, function(value)
    gConfig.next_chat.chat_cooldown_ms = value
end)

local pos_x_slider_focused = false
local pos_x_slider = general_settings:slider_float("X", {"chatposx"}, "", 0, 1000, gConfig.next_chat.pos_x*100, 1, function(value)
    gConfig.next_chat.pos_x = value*0.01
end)

menu.on_focus(pos_x_slider, function()
    pos_x_slider_focused = true 
end)

menu.on_blur(pos_x_slider, function()
    pos_x_slider_focused = false
end)

local pos_y_slider_focused = false
pos_y_slider = general_settings:slider_float("Y", {"chatposy"}, "", 0, 1000, gConfig.next_chat.pos_y*100, 1, function(value)
    gConfig.next_chat.pos_y = value*0.01
end)

menu.on_focus(pos_y_slider, function()
    pos_y_slider_focused = true 
end)

menu.on_blur(pos_y_slider, function()
    pos_y_slider_focused = false
end)

local text_scale_slider_focused = false
text_scale_slider = general_settings:slider_float("文本比例", {"chatmsgtxtscale"}, "", 0, 1000, gConfig.next_chat.text_scale*100, 1, function(value)
    gConfig.next_chat.text_scale = value*0.01
end)

menu.on_focus(text_scale_slider, function()
    text_scale_slider_focused = true 
end)

menu.on_blur(text_scale_slider, function()
    text_scale_slider_focused = false
end)

local tag_scale_slider_focused = false
tag_scale_slider = general_settings:slider_float("标签比例", {"chatmsgtagscale"}, "", 0, 1000, gConfig.next_chat.tag_scale*100, 1, function(value)
    gConfig.next_chat.tag_scale = value*0.01
end)

menu.on_focus(tag_scale_slider, function()
    tag_scale_slider_focused = true 
end)

menu.on_blur(tag_scale_slider, function()
    tag_scale_slider_focused = false
end)


general_settings:toggle("UwU", {}, "", function(toggle)
    gConfig.next_chat.uwuify = toggle
end, gConfig.next_chat.uwuify)

general_settings:toggle("显示输入", {}, "", function(toggle)
    gConfig.next_chat.show_typing = toggle
end, gConfig.next_chat.show_typing)


general_settings:toggle("输入时显示", {}, "", function(toggle)
    gConfig.next_chat.wake_typing = toggle
end, gConfig.next_chat.wake_typing)



msg_text_color = {r = 1, g = 1, b = 1, a = 1}
regular_coloring_root:colour("文本颜色", {"chatmsgtxtcolor"}, "", msg_text_color, true, function(rgb)
    msg_text_color = rgb 
end)

tag_color = {r = 1, g = 1, b = 1, a = 1}
regular_coloring_root:colour("标签颜色", {"chatmsgtagcolor"}, "", tag_color, true, function(rgb)
    tag_color = rgb 
end)

typing_color = {r = 1, g = 1, b = 1, a = 0.8}
regular_coloring_root:colour("输入颜色", {"chatmsgtypingcolor"}, "", tag_color, true, function(rgb)
    typing_color = rgb 
end)

bg_color = {r = 0, g = 0, b = 0, a = 0.3}
regular_coloring_root:colour("背景颜色", {"chatmsgbgcolor"}, "", bg_color, true, function(rgb)
    bg_color = rgb 
end)


conditional_coloring_root:toggle("类别颜色", {}, "", function(toggle)
    gConfig.next_chat.classification = toggle
end, gConfig.next_chat.classification)

me_color = {r = 1, g = 0, b = 1, a = 1}
conditional_coloring_root:colour("自己", {"chatmecolor"}, "", me_color, true, function(rgb)
    me_color = rgb 
end)

friends_color = {r = 0, g = 1, b = 0, a = 1}
conditional_coloring_root:colour("好友", {"chatfriendcolor"}, "", friends_color, true, function(rgb)
    friends_color = rgb
end)

strangers_color = {r = 1, g = 1, b = 1, a = 1}
conditional_coloring_root:colour("玩家", {"chatstrangercolor"}, "", strangers_color, true, function(rgb)
    strangers_color = rgb
end)

modders_color = {r = 1, g = 0, b = 0, a = 1}
conditional_coloring_root:colour("作弊者", {"chatmoddercolor"}, "", modders_color, true, function(rgb)
    modders_color = rgb
end)



tags_root:list_select("标签模式", {"chattagmode"}, "", {"GTA V", "无"}, 1, function(index)
    gConfig.next_chat.tag_mode = index
end)


handle_ptr = memory.alloc(13*8)
local function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end
local last_chat_time = os.time()
local chat_cooldowns = {}
chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
    if chat_cooldowns[sender] ~= nil and sender ~= players.user() then
       NOTIF("聊天冷却时间超过 " .. players.get_name(sender) .. ". 消息未显示.")
        return
    end
    -- coloring player names
    local player_color = 1
    if gConfig.next_chat.classification then
        local hdl = pid_to_handle(sender)
        if sender == players.user() then 
            player_color = me_color
        elseif NETWORK.NETWORK_IS_FRIEND(hdl) then
            player_color = friends_color
        elseif players.is_marked_as_modder(sender) then 
            player_color = modders_color
        else
            player_color = strangers_color
        end
    end

    -- custom tags, technically there is also CEO chat but whatever
    local tag = if team_chat then "团队" else "全部" end
    if gConfig.next_chat.tag_mode == 2 then
        tag = ""
    end

    if players.user() ~= sender then 
        text = text:sub(1, gConfig.next_chat.max_chat_len)
    end

    if gConfig.next_chat.uwuify then 
        text = uwu(text)
    end

    -- somehow chats > 254 get generated???
    all_visible_chats[#all_visible_chats+1] = new_chat_obj(sender, players.get_name(sender), player_color, tag, text:sub(1, 254))
    last_chat_time = os.time()
    chat_cooldowns[sender] = true 
    util.yield(gConfig.next_chat.chat_cooldown_ms)
    chat_cooldowns[sender] = nil

    if #all_visible_chats > gConfig.next_chat.max_chats then
        table.remove(all_visible_chats, 1)
    end
end)

function get_all_typers_string()
    local typers = {}
    for _,pid in players.list(false, true, true) do 
        if players.is_typing(pid) then 
            typers[#typers+1] = players.get_name(pid)
        end
    end
    if #typers == 0 then 
        return ""
    end
    local type_string = ""
    if #typers > 1 then
        type_string = table.concat(typers, ", ")
        local p1, p2 = string.partition(type_string, ",", true)
        if #typers == 2 then
            type_string = p1 .. "和" .. p2 .. "正在输入..."
        else
            type_string = p1 .. ",和" .. p2 .. "正在输入..."
        end
    else
        type_string = table.concat(typers, "") .. "正在输入..."
    end
    return type_string
end

-- credit to aaronlink127
local function split_string_chunks_respect_word(str, char_len)
    local t = {}
    local cur_str = ""
    local i = 1
    if string.contains(str, " ") then 
        local t = {}
        while #str > char_len do
            t[#t + 1] = str:sub(1, char_len)
            str = str:sub(char_len + 1)
        end
        t[#t + 1] = str
        return t
    end

    for ln in str:gmatch("([^%s]*)") do
        if (#cur_str + #ln + 1) > char_len then
            t[i] = cur_str
            i += 1
            cur_str = ""
        else
            cur_str ..= " "
        end
        cur_str ..= ln
    end
    if #cur_str ~= 0 then
        t[i] = cur_str
    end
    return t
end
local chat_box_y_scale = 0.0   
menu.toggle(next_chat, "次世代聊天", {"nextchat"}, "", function(toggle)
    gConfig.next_chat.next_chat_toggle = toggle
end,gConfig.next_chat.next_chat_toggle)


----------撕逼魔怔人---------- 

menu.toggle_loop(crosshair, "瞄准准心", {}, "", function()
    HUD.SET_TEXT_SCALE(1.0, 0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("·")
    HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(gConfig.crosshair.x,gConfig.crosshair.y,0)
end)

menu.slider(crosshair, "X", {}, "", 0, 100, gConfig.crosshair.x*100, 1, function(value)
    gConfig.crosshair.x = value / 100
end)

menu.slider(crosshair, "Y", {}, "", 0, 100, gConfig.crosshair.y*100, 1, function(value)
    gConfig.crosshair.y = value / 100
end)

------------------------------------------------------

local colour = b_colour.new()
local drawing_funcs = b_drawing_funcs.new()

local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)
local damage_numbers_target_ptr = memory.alloc(4)
local damage_numbers_tracked_entities = {}
local damage_numbers_health_colour = colour.to_stand(colour.new(20, 180, 50, 255))
local damage_numbers_armour_colour = colour.to_stand(colour.new(50, 50, 200, 255))
local damage_numbers_crit_colour = colour.to_stand(colour.new(200, 200, 10, 255))
local damage_numbers_vehicle_colour = colour.to_stand(colour.new(200, 100, 20, 255))
local damage_numbers_bone_ptr = memory.alloc(4)
local damage_numbers_target_vehicles
local damage_numbers_text_size = 0.7
menu.toggle_loop(damage_numbers_list, "显示伤害", {"damagenumbers"}, "", function()
   if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), damage_numbers_target_ptr) then
        local target = memory.read_int(damage_numbers_target_ptr)
        if ENTITY.IS_ENTITY_A_PED(target) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(target, false)
            if vehicle ~= 0 and damage_numbers_target_vehicles then
                if damage_numbers_tracked_entities[vehicle] == nil then
                    damage_numbers_tracked_entities[vehicle] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(vehicle)),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[vehicle].timer = 1
                end
            end
                if damage_numbers_tracked_entities[target] == nil then
                    damage_numbers_tracked_entities[target] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target) - 100),
                        armour = PED.GET_PED_ARMOUR(target),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[target].timer = 1
                end
        elseif ENTITY.IS_ENTITY_A_VEHICLE(target) and damage_numbers_target_vehicles then
            if damage_numbers_tracked_entities[target] == nil then
                damage_numbers_tracked_entities[target] = {
                    health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target)),
                    timer = 1
                }
            else
                damage_numbers_tracked_entities[target].timer = 1
            end
        end
   end
   for entity, data in pairs(damage_numbers_tracked_entities) do
        if  ENTITY.IS_ENTITY_A_PED(entity) then
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity) - 100)
            local current_armour = PED.GET_PED_ARMOUR(entity)
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, player_ped_id, 1) then
                if current_health < data.health then
                    data.timer = 1
                    PED.GET_PED_LAST_DAMAGE_BONE(entity, damage_numbers_bone_ptr)
                    if memory.read_int(damage_numbers_bone_ptr) == 31086 then
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_crit_colour, damage_numbers_text_size)
                    else
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_health_colour, damage_numbers_text_size)
                    end
                end
                if current_armour < data.armour then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.armour - current_armour, damage_numbers_armour_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - delta_time
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
            data.armour = current_armour
        else
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity))
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, player_ped_id, 1) then
                if current_health < data.health then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_vehicle_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - delta_time
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
        end
    end
end)

menu.toggle(damage_numbers_list, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
    damage_numbers_target_vehicles = value
end)

menu.slider(damage_numbers_list, "数字比例", {"damagenumberstextsize"}, "", 1, 100, 7, 1, function (value)
    damage_numbers_text_size = value * 0.1
end)



menu.rainbow(menu.colour(damage_numbers_colours_list, "默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
    damage_numbers_health_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "爆头颜色", {"damagenumcritcolour"}, "爆头颜色", damage_numbers_crit_colour, true, function (value)
    damage_numbers_crit_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
    damage_numbers_armour_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
    damage_numbers_vehicle_colour = value
end))

------------------------------------------------------

auto_weapon_delay = 100
menu.toggle_loop(auto_weapon, "武器连发", {}, "", function()
    local player_ped = players.user_ped()
    if PED.IS_PED_SHOOTING(player_ped) then
        local weapon <const> = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
        WEAPON.SET_CURRENT_PED_WEAPON(player_ped, util.joaat("WEAPON_UNARMED"), true)
        util.yield(auto_weapon_delay)
        WEAPON.SET_CURRENT_PED_WEAPON(player_ped, weapon, true)
    end
end)

menu.slider(auto_weapon, "延迟", {""}, "", 1, 1000, 100, 50, function(value)
    auto_weapon_delay = value
end)

------------------------------------------------------

menu.toggle_loop(session_catfight, "快速复活", {}, "", function()
    local gwobaw = memory.script_global(2672505 + 1685 + 756) -- Global_2672505.f_1685.f_756
    if PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
        GRAPHICS.ANIMPOSTFX_STOP_ALL()
        memory.write_int(gwobaw, memory.read_int(gwobaw) | 1 << 1)
    end
end,
    function()
    local gwobaw = memory.script_global(2672505 + 1685 + 756)
    memory.write_int(gwobaw, memory.read_int(gwobaw) &~ (1 << 1)) 
end)

menu.toggle_loop(session_catfight, "快速切换武器", {}, "", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 92) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(session_catfight, "[G键]自杀", {""}, "", function()
    if is_key_just_down("VK_G") then
        request_anim_dict("mp_suicide")
        WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), 453432689, 15, true, true)
        util.yield(100)
        WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), 453432689, true)
        play_animation("mp_suicide", "pistol",false)
        util.yield(1500)
        menu.trigger_commands("ewo")
    end
end)

menu.toggle_loop(session_catfight, "[E键]牛鲨睾丸", {""}, "", function()
    if is_key_just_down("VK_E") then
        menu.trigger_commands("bstonce")
    end
end)

----------获取脚本/主机---------- 

menu.action(get_host, "强制主机", {"forcehost"}, "", function()
    while true do
        if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
            if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
                menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
                util.yield(200)
            end
        else
            return
        end
        util.yield()
    end
end)

menu.action(get_host, "强制脚本主机", {"forcescripthost"}, "", function()
    menu.trigger_commands("scripthost")
end)

menu.toggle(get_host, "自动获取主机", {"alwayshost"}, "", function(toggle)
    gConfig.session.always_host = toggle
end,gConfig.session.always_host)

menu.toggle(get_host, "自动获取脚本主机", {"alwaysscripthost"}, "", function(toggle)
    gConfig.session.always_scripthost = toggle
end,gConfig.session.always_scripthost)

menu.toggle(get_host, "最高主机令牌", {""}, "一进战局你就是下一位主机", function(ob)
    if on then
        menu.trigger_command(menu.ref_by_path("Online>Spoofing>Host Token Spoofing>Presets>Aggressive"))
        menu.trigger_commands("hosttokenspoofing on")
    else
        menu.trigger_commands("hosttokenspoofing off")
    end
end)

------------------------------------------------------

menu.toggle(lobby_event, "全自动移除XiPro玩家", {}, "", function (toggle) 
    gConfig.session.remove_xipro = toggle
    if gConfig.session.remove_xipro then
        chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
            if sender ~= players.user() and (string.find(text,"XiPro玩家") or string.find(text,"正在使用") or string.find(text,"正在尝试使用")) then
                menu.trigger_commands("crash" .. players.get_name(sender))
                util.yield(1000)
                menu.trigger_commands("kick" .. players.get_name(sender))
                util.yield(1000)
            end
        end)
    end
end,gConfig.session.remove_xipro)

menu.toggle_loop(lobby_event, "全局标记为傻逼", {""}, "", function()
    for k,v in pairs(players.list(true, true, true)) do
        if ENTITY.DOES_ENTITY_EXIST(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)) then
            local headpos = PED.GET_PED_BONE_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v), 0x796e, 0,0,0)
            GRAPHICS.SET_DRAW_ORIGIN(headpos.x, headpos.y, headpos.z+0.4, 0)
            HUD.SET_TEXT_COLOUR(200,200,200,220)
            HUD.SET_TEXT_SCALE(1, 0.5)
            HUD.SET_TEXT_CENTRE(true)
            HUD.SET_TEXT_FONT(4)
            HUD.SET_TEXT_OUTLINE()
            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("傻逼")
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
            GRAPHICS.CLEAR_DRAW_ORIGIN()
        end
    end
end,function ()
    util.yield(200)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
    GRAPHICS.CLEAR_DRAW_ORIGIN()
end)

local is_open_input_box = true
menu.toggle_loop(lobby_event, "全局标记为...", {""}, "", function()
    if is_open_input_box  then
        input = InputBox("","全局标记","")
        is_open_input_box = false
    end
    for k,v in pairs(players.list(true, true, true)) do
        if ENTITY.DOES_ENTITY_EXIST(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)) then
            local headpos = PED.GET_PED_BONE_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v), 0x796e, 0,0,0)
            GRAPHICS.SET_DRAW_ORIGIN(headpos.x, headpos.y, headpos.z+0.4, 0)
            HUD.SET_TEXT_COLOUR(200,200,200,220)
            HUD.SET_TEXT_SCALE(1, 0.5)
            HUD.SET_TEXT_CENTRE(true)
            HUD.SET_TEXT_FONT(4)
            HUD.SET_TEXT_OUTLINE()
            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(input)
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
            GRAPHICS.CLEAR_DRAW_ORIGIN()
        end
    end
end,function ()
    util.yield(200)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0,0,0)
    GRAPHICS.CLEAR_DRAW_ORIGIN()
    is_open_input_box = true
end)

menu.toggle_loop(lobby_event, "攻击嘲讽", {}, "", function()
    for k,v in pairs(players.list(false, true, true)) do
        if players.is_marked_as_modder(v) then
            chat.send_message(players.get_name(v) .. "1",false,true,true)
            break
        end
    end
end)

menu.toggle_loop(lobby_event, "全局花屏", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
        local player_pos = players.get_position(v)   
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end 
end)

menu.toggle_loop(lobby_event, "全局花屏", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
        local player_pos = players.get_position(v)   
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end 
end)

menu.toggle_loop(lobby_event, "全局随机循环", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
		local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], math.random(0, 82), 1.0, true, false,0.0)
    end
end)

menu.toggle_loop(lobby_event, "全局随机循环", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
		local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], math.random(0, 82), 1.0, true, false,0.0)
    end
end)

menu.toggle(lobby_event, "全局闪屏", {}, "", function (toggle) 
    seizuretoggle  = toggle
    for k,v in pairs(players.list(false, true, true)) do
        util.create_tick_handler(function()
			local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local khanjali = util.joaat("cargobob")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_object(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(v), 0, 0, 2), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_object(khanjali, playerpos, 0)
            local vehicle3 = entities.create_object(khanjali, playerpos, 0)
            local vehicle4 = entities.create_object(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield()
            entities.delete_by_handle(vehicle1)
            entities.delete_by_handle(vehicle2)
            entities.delete_by_handle(vehicle3)
            entities.delete_by_handle(vehicle4)
            return seizuretoggle
        end)
    end
end)

menu.toggle(lobby_event, "全局套UFO", {}, "", function (toggle) 
    ufotoggle  = toggle
    for k,v in pairs(players.list(false, true, true)) do
        util.create_tick_handler(function()
			local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local khanjali = util.joaat("imp_prop_ship_01a")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_object(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(v), 0, 0, 2), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_object(khanjali, playerpos, 0)
            local vehicle3 = entities.create_object(khanjali, playerpos, 0)
            local vehicle4 = entities.create_object(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield()
            entities.delete_by_handle(vehicle1)
            entities.delete_by_handle(vehicle2)
            entities.delete_by_handle(vehicle3)
            entities.delete_by_handle(vehicle4)
            return ufotoggle
        end)
    end
end)

menu.toggle_loop(lobby_event, "震动屏幕", {}, "让每个人的屏幕震动", function()
    for k,v in pairs(players.list(false, true, true)) do
        local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
        FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], 7, 0, false, true, 5000)
        util.yield()
    end
    util.yield(1000)
end)       

menu.action(lobby_event, "匿名杀害", {"killeveryone"}, "无声地杀死所有人", function()
    for k,v in pairs(players.list(false, true, true)) do
        local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
        FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"] + 2, 7, 1000, false, true, 0)
        util.yield()
    end
end)

menu.action(lobby_event, "困住所有玩家", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
	    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(v))
		pos.z = pos.z + 0.95  
		local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(v))
		pos1.z = pos1.z - 0.90
		local cage = util.joaat("prop_feeder1_cr")
		STREAMING.REQUEST_MODEL(cage)
		OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)
	    OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)
	end
end)

menu.action(lobby_event, "防空警报", {"AirDefencesSound"}, "", function()
    local pos, exp_pos = v3(), v3()
    local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    for i = 1, #Audio_POS do
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        pos.z = 2000.00
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        pos.z = -2000.00
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        for k,v in pairs(players.list(false, true, true)) do
            local pos =	NETWORK.NETWORK_GET_LAST_PLAYER_POS_RECEIVED_OVER_NETWORK(v)
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", pos.x, pos.y, pos.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
        end
	end
end) 

menu.action(lobby_event, "噪音", {"bedsound"}, "在战局中播放大量的噪音", function()
    local pos = v3()
    local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
    for i = 1, #Audio_POS do
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
        pos.z = 2000.00
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
        pos.z = -2000.00
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "WastedSounds", true, 999999999, true)
        for k,v in pairs(players.list(false, true, true)) do
            local pos =	NETWORK.NETWORK_GET_LAST_PLAYER_POS_RECEIVED_OVER_NETWORK(v)
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 999999999, true)
        end
    end		
end)



menu.toggle_loop(lobby_crash, "耶稣的救赎", {"salvation"}, "", function ()
    request_model(util.joaat("u_m_m_jesus_01"))
    request_model(util.joaat("Ruiner2"))
    request_model(util.joaat("prop_beach_parasol_05"))
    request_model(3235319999)
    request_model(260873931)
    request_model(546252211)
    request_model(148511758)
    request_model(1381105889)
    request_model(1500925016) 
    local Pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("v_ilev_light_wardrobe_face"))
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,3235319999)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,260873931)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,546252211)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,148511758)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,260873931)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 1381105889)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,1500925016)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,util.joaat("prop_logpile_06b"))
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,util.joaat("prop_beach_parasol_03"))
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,1117917059)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
        for i = 1, 1 do      
            local Ped = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), Pos, 0)             
            ENTITY.SET_ENTITY_INVINCIBLE(Ped, true)
            local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), Pos, ENTITY.GET_ENTITY_HEADING(), true)
            PED.SET_PED_INTO_VEHICLE(Ped, Ruiner2, -1)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, Pos.x, Pos.y, 1000, false, true, true)
            util.yield(200)
            VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2,-908104950)
            VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
            util.yield(200)
            entities.delete_by_handle(Ruiner2)
            entities.delete_by_handle(Ped)
        end
end)

menu.toggle_loop(lobby_crash, "数学崩溃x3", {"mathcrash"}, "", function(on_toggle)
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local ppos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x+5
    ppos.z = ppos.z+1
    Utillitruck3 = entities.create_vehicle(2132890591, pos, 0)
    Utillitruck3_pos = ENTITY.GET_ENTITY_COORDS(Utillitruck3)
    kur = entities.create_ped(26, 2727244247, ppos, 0)
    kur_pos = ENTITY.GET_ENTITY_COORDS(kur)
    ENTITY.SET_ENTITY_INVINCIBLE(kur, true)
    newRope = PHYSICS.ADD_ROPE(pos.x, pos.y, pos.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, "Center")
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, Utillitruck3, kur, Utillitruck3_pos.x, Utillitruck3_pos.y, Utillitruck3_pos.z, kur_pos.x, kur_pos.y, kur_pos.z, 2, 0, 0, "Center", "Center")
    util.yield(100)
    ENTITY.SET_ENTITY_INVINCIBLE(kur, true)
    newRope = PHYSICS.ADD_ROPE(pos.x, pos.y, pos.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, "Center")
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, Utillitruck3, kur, Utillitruck3_pos.x, Utillitruck3_pos.y, Utillitruck3_pos.z, kur_pos.x, kur_pos.y, kur_pos.z, 2, 0, 0, "Center", "Center") 
    util.yield(100)
    PHYSICS.ROPE_LOAD_TEXTURES()
    local hashes = {2132890591, 2727244247}
    local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED())
    local veh = VEHICLE.CREATE_VEHICLE(hashes[i], pc.x + 5, pc.y, pc.z, 0, true, true, false)
    local ped = PED.CREATE_PED(26, hashes[2], pc.x, pc.y, pc.z + 1, 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
    ENTITY.SET_ENTITY_VISIBLE(ped, false, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, 0)
    local rope = PHYSICS.ADD_ROPE(pc.x + 5, pc.y, pc.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1, true, 0)
    local vehc = ENTITY.GET_ENTITY_COORDS(veh); local pedc = ENTITY.GET_ENTITY_COORDS(ped)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(rope, veh, ped, vehc.x, vehc.y, vehc.z, pedc.x, pedc.y, pedc.z, 2, 0, 0, "Center", "Center")
    util.yield(1000)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PHYSICS.DELETE_CHILD_ROPE(rope)
    PHYSICS.ROPE_UNLOAD_TEXTURES()
end)

menu.toggle_loop(lobby_crash, "Cargo崩溃", {"cargocrash"}, "", function()
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX()
    local TPpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
    local cargobob = CreateVehicle(0XFCFCB68B, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
    local veh = CreateVehicle(0X187D938D, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local vehPos = ENTITY.GET_ENTITY_COORDS(veh, true)
    local newRope = PHYSICS.ADD_ROPE(TPpos.x, TPpos.y, TPpos.z, 0, 0, 10, 1, 1, 0, 1, 1, false, false, false, 1.0, false, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, veh, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehPos.x, vehPos.y, vehPos.z, 2, false, false, 0, 0, "Center", "Center")
    util.yield(2500)
    entities.delete_by_handle(cargobob)
    entities.delete_by_handle(veh)
    PHYSICS.DELETE_CHILD_ROPE(newRope)
end)


menu.action(lobby_crash, "超级无敌宇宙崩", {}, "", function ()
    PlaySound(filesystem.store_dir() .. "\\LM\\".."zhengyi.wav", SND_FILENAME | SND_ASYNC)
    zhengyi_crash = true
    util.yield(9000)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(),players.user_ped(), 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true)
    zhengyi_crash = false
end)

local zhengyipng = directx.create_texture(filesystem.store_dir() .. "\\LM\\".."zhengyi.png")
util.create_thread(function ()
    while true do
        if zhengyi_crash then
        directx.draw_texture(zhengyipng, 0.29, 0.1, 0.0, 0.0, 0.23, 0.0, 0, 1, 1, 1, 1)
        end
        util.yield()
    end
end)    

--------------------------------
------------ 防护选项 ------------
--------------------------------

----------实体池限制---------- 

local ped_limit = 175
menu.slider(pool_limiter, "Ped池限制", {"pedslimit"}, "默认: 175", 0, 256, 175, 1, function(amount)
    ped_limit = amount
end)

local veh_limit = 150
menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "默认: 150", 0, 300, 150, 1, function(amount)
    veh_limit = amount
end)

local obj_limit = 500
menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "默认: 500", 0, 2300, 500, 1, function(amount)
    obj_limit = amount
end)

local projectile_limit = 25
menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "默认: 25", 0, 50, 25, 1, function(amount)
    projectile_limit = amount
end)

menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() then
        ped_count += 1
        end
        if ped_count >= ped_limit then
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                entities.delete_by_handle(ped)
            end
            NOTIF("Ped池达到上限,正在清理...")
        end
    end

    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
                entities.delete_by_handle(veh)
            end
            NOTIF("载具池达到上限,正在清理...")
        end
    end

    local obj_count = 0
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        obj_count += 1
        if obj_count >= obj_limit then
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(obj)
            end
            NOTIF("物体池达到上限,正在清理...")
        end
    end
end)

menu.toggle_loop(PROTECTION_LIST, "移除爆炸", {}, "范围: 10", function()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    FIRE.STOP_FIRE_IN_RANGE(pos.x, pos.y, pos.z, 10.0)
    FIRE.STOP_ENTITY_FIRE(players.user_ped())
end)

menu.toggle_loop(PROTECTION_LIST, "移除粒子效果", {}, "范围: 10", function()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(pos.x, pos.y, pos.z, 10.0)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
end)

menu.toggle_loop(PROTECTION_LIST, "移除黏弹和感应地雷", {}, "", function()
    local weaponHash = util.joaat("WEAPON_PROXMINE")
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(weaponHash, false)
    weaponHash = util.joaat("WEAPON_STICKYBOMB")
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(weaponHash, false)
end)

menu.toggle_loop(PROTECTION_LIST, "移除防空区域", {}, "", function()
    WEAPON.REMOVE_ALL_AIR_DEFENCE_SPHERES()
end)

menu.toggle_loop(PROTECTION_LIST, "移除载具上的黏弹", {}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped())
    if vehicle then
        NETWORK.REMOVE_ALL_STICKY_BOMBS_FROM_ENTITY(vehicle)
    end
end)

menu.toggle_loop(PROTECTION_LIST, "停止所有声音", {}, "", function()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end)

menu.action(PROTECTION_LIST, "移除手机铃声", {}, "", function()
    local player = PLAYER.PLAYER_PED_ID()
    menu.trigger_commands("nophonespam on")
    if AUDIO.IS_PED_RINGTONE_PLAYING(player) then
        for i = -1, 100 do
            AUDIO.STOP_PED_RINGTONE(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end
    end
    util.yield(1000)
    menu.trigger_commands("nophonespam off")
end)

menu.action(PROTECTION_LIST, "超级清除", {"superclear"}, "", function()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
        end
    end
    NOTIF("已清除" .. cleanse_entitycount .. "个NPC")

    cleanse_entitycount = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(veh)
        cleanse_entitycount += 1
        util.yield()
    end
    NOTIF("已清除".. cleanse_entitycount .."个载具")

    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
    end
    NOTIF("已清除" .. cleanse_entitycount .. "物体")

    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
    end
    NOTIF("已清除" .. cleanse_entitycount .. "可拾取物体")

    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
    end
    NOTIF("已清除所有绳索")

    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    NOTIF("已清除所有投掷物")
end)

menu.toggle_loop(PROTECTION_LIST, "连续清除世界", {"continuousclearing"}, "", function()
    MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)
end)

menu.toggle(PROTECTION_LIST, "提升帧数", {"fpsboost"}, "", function(on_toggle)
	if on_toggle then
		NOTIF("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("noidlecam ")
	else
		NOTIF("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("noidlecam ")
	end
end)

menu.toggle(PROTECTION_LIST, "昏哥模式", {"panic"}, "没错就是自闭", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        NOTIF("开启昏哥模式")
        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        NOTIF("关闭昏哥模式")
        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end)

--------------------------------
------------ 世界选项 ------------
--------------------------------
local terrain_grid_run
local terrain_grid_scale = 10
local terrain_grid_intensity = 10
local terrain_grid_cell_size = 1
menu.toggle(terrain_grid, "地形网格", {}, "在地面上渲染网格", function (value)
    GRAPHICS.TERRAINGRID_ACTIVATE(value)
    GRAPHICS.TERRAINGRID_SET_COLOURS(255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 255, 255)
    terrain_grid_run = value
    if terrain_grid_run then
        util.create_tick_handler(function ()
            coords = CAM.GET_FINAL_RENDERED_CAM_COORD()
            GRAPHICS.TERRAINGRID_SET_PARAMS(
                math.floor(coords.x * terrain_grid_cell_size) / terrain_grid_cell_size,
                math.floor(coords.y * terrain_grid_cell_size) / terrain_grid_cell_size,
                coords.z - 0.5,
                1, 0, 0,
                20 * terrain_grid_scale,
                20 * terrain_grid_scale, 
                20 * terrain_grid_scale, 
                terrain_grid_scale * 20 * 2 * terrain_grid_cell_size, 
                terrain_grid_intensity, 
                coords.z - 0.5, 0)
            return true
        end)
    end
end)
menu.slider(terrain_grid, "比例", {"terraingridscale"}, "", 1, 1000, 10, 1, function (value)
    terrain_grid_scale = value  
end)
menu.slider(terrain_grid, "网格数量", {"terraingridsize"}, "", 1, 100, 1, 1, function (value)
    terrain_grid_cell_size = value * 0.05
end)
menu.slider(terrain_grid, "亮度", {"terraingridglow"}, "", 1, 1000, 10, 1, function (value)
    terrain_grid_intensity = value
end)
local terrain_grid_colour = colour.magenta
menu.rainbow(menu.colour(terrain_grid, "颜色", {""}, "", 1, 0, 1, 1, true, function (new_colour)
    terrain_grid_colour = colour.to_rage(new_colour)
    GRAPHICS.TERRAINGRID_SET_COLOURS(
        terrain_grid_colour.r, terrain_grid_colour.g, terrain_grid_colour.b, terrain_grid_colour.a,
        terrain_grid_colour.r, terrain_grid_colour.g, terrain_grid_colour.b, terrain_grid_colour.a,
        terrain_grid_colour.r, terrain_grid_colour.g, terrain_grid_colour.b, terrain_grid_colour.a)
end))


local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
local bigball = {"生成", "删除"}
menu.textslider_stateful(WORLD_LIST, "球体", {}, "在花园银行顶部生成一个球体", bigball, function(ball)
    if ball == 1 then
        STREAMING.REQUEST_MODEL(bigasscircle)
        while not STREAMING.HAS_MODEL_LOADED(bigasscircle) do
            STREAMING.REQUEST_MODEL(bigasscircle)
            util.yield()
        end
        c1 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c2 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c3 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c4 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c5 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c6 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c7 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c8 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c9 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c10 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c11 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c12 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c13 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c14 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c15 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c16 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c17 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c18 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        c19 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
        ENTITY.FREEZE_ENTITY_POSITION(c1, true)
        ENTITY.FREEZE_ENTITY_POSITION(c2, true)
        ENTITY.FREEZE_ENTITY_POSITION(c3, true)
        ENTITY.FREEZE_ENTITY_POSITION(c4, true)
        ENTITY.FREEZE_ENTITY_POSITION(c5, true)
        ENTITY.FREEZE_ENTITY_POSITION(c6, true)
        ENTITY.FREEZE_ENTITY_POSITION(c7, true)
        ENTITY.FREEZE_ENTITY_POSITION(c8, true)
        ENTITY.FREEZE_ENTITY_POSITION(c9, true)
        ENTITY.FREEZE_ENTITY_POSITION(c10, true)
        ENTITY.FREEZE_ENTITY_POSITION(c11, true)
        ENTITY.FREEZE_ENTITY_POSITION(c12, true)
        ENTITY.FREEZE_ENTITY_POSITION(c13, true)
        ENTITY.FREEZE_ENTITY_POSITION(c14, true)
        ENTITY.FREEZE_ENTITY_POSITION(c15, true)
        ENTITY.FREEZE_ENTITY_POSITION(c16, true)
        ENTITY.FREEZE_ENTITY_POSITION(c17, true)
        ENTITY.FREEZE_ENTITY_POSITION(c18, true)
        ENTITY.FREEZE_ENTITY_POSITION(c19, true)
        ENTITY.SET_ENTITY_ROTATION(c2, 0.0, 0.0, 10.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c3, 0.0, 0.0, 20.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c4, 0.0, 0.0, 30.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c5, 0.0, 0.0, 40.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c6, 0.0, 0.0, 50.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c7, 0.0, 0.0, 60.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c8, 0.0, 0.0, 70.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c9, 0.0, 0.0, 80.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c10, 0.0, 0.0, 90.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c11, 0.0, 0.0, 100.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c12, 0.0, 0.0, 110.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c13, 0.0, 0.0, 120.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c14, 0.0, 0.0, 130.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c15, 0.0, 0.0, 140.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c16, 0.0, 0.0, 150.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c18, 0.0, 0.0, 160.0, 1, true)
        ENTITY.SET_ENTITY_ROTATION(c19, 0.0, 0.0, 170.0, 1, true)
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), -75.14637, -818.67236, 326.1751)
    end
    if ball == 2 then
        entities.delete_by_handle(c1)
        entities.delete_by_handle(c2)
        entities.delete_by_handle(c3)
        entities.delete_by_handle(c4)
        entities.delete_by_handle(c5)
        entities.delete_by_handle(c6)
        entities.delete_by_handle(c7)
        entities.delete_by_handle(c8)
        entities.delete_by_handle(c9)
        entities.delete_by_handle(c10)
        entities.delete_by_handle(c11)
        entities.delete_by_handle(c12)
        entities.delete_by_handle(c13)
        entities.delete_by_handle(c14)
        entities.delete_by_handle(c15)
        entities.delete_by_handle(c16)
        entities.delete_by_handle(c17)
        entities.delete_by_handle(c18)
        entities.delete_by_handle(c19)
    end
end)

local island = {"生成", "删除"}
island_block = 0
menu.textslider_stateful(WORLD_LIST, "天空岛", {}, "", island, function(on_click)
    if on_click == 1 then
        local c = {}
        c.x = 0
        c.y = 0
        c.z = 500
        PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z+5)
        if island_block == 0 or not ENTITY.DOES_ENTITY_EXIST(island_block) then
            request_model(1054678467)
            island_block = entities.create_object(1054678467, c)
        end
    end
    if on_click == 2 then
        entities.delete_by_handle(island_block)
    end
end)

menu.action(WORLD_LIST, "战局雪天", {}, "本地可见", function () 
    memory.write_int(memory.script_global(262145+4752), 1)
end)

local weather_hash <const> = {
    {"天气: 阳光明媚", -1750463879},
    {"天气: 晴朗", 916995460},
    {"天气: 多云", 821931868},
    {"天气: 环境污染", 282916021},
    {" 雾天", -1368164796},
    {" 阴天", -1148613331},
    {" 雨天", 1420204096},
    {" 雷雨天", -1233681761},
    {" 雨晴天", 1840358669},
    {" 温室天气", -1530260698},
    {" 雪天", -273223690},
    {" 暴风雪", 669657108},
    {" 雪雾天", 603685163},
    {" 圣诞节", -1429616491},
    {" 万圣节", -921030142},

    {" 雷雨天", 3061285535},
    {"天气: 阳光明媚", 2544503417},
    --{"环境污染", -1750463879},
    {" 雾天", 2926802500},
    {" 阴天", 3146353965},
    {" 温室天气", 2764706598},
    {" 圣诞节", -2865350805},
    {" 万圣节", 3373937154},
}
--[[if next_weather == "1420204096" then
    NOTIF("雨天")
elseif next_weather == "1840358669" then
    NOTIF("雨晴天")
elseif next_weather == "282916021,-1750463879" then
    NOTIF("环境污染")
end]]

menu.textslider_stateful(WORLD_LIST, "发送位置", {""}, "单击以修改", {"通知", "公屏"}, function(value)
    send_weather_location = value
end)
local weather_forecast = true
menu.toggle_loop(WORLD_LIST, "天气预报", {""}, "", function()
    if weather_forecast then
        nextw_weather = MISC.GET_NEXT_WEATHER_TYPE_HASH_NAME()
        for _, weather in pairs(weather_hash) do
            if nextw_weather == weather[2] then
                if send_weather_location == 2 then
                    chat.send_message("----------洛圣都天气预报----------", false, true, true)
                    chat.send_message("即将迎来" .. weather[1], false, true, true)
                else
                    NOTIF("-------洛圣都天气预报-------\n即将迎来" .. weather[1])
                end
                get_next_weather = true
                weather_forecast = false
            end
        end
    end
    if get_next_weather then
        if nextw_weather ~= MISC.GET_NEXT_WEATHER_TYPE_HASH_NAME() then
            weather_forecast = true
            get_next_weather = false
        end
    end
end,function ()
    weather_forecast = true
end)

menu.toggle_loop(WORLD_LIST, "生成闪电", {""}, "", function()
    MISC.FORCE_LIGHTNING_FLASH()
end)

local num = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35"
}
local ufo = util.joaat("sum_prop_dufocore_01a")
menu.toggle_loop(WORLD_LIST, "外星人入侵", {}, "", function(toggle)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = num[math.random(#num)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5
    c.z = c.z + r + 8 
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c)
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo)
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y)
        util.yield()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false)
    util.yield(1500)
    entities.delete_by_handle(spawnedufo)
    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        NOTIF("无法加载模型")
    end
end)

menu.toggle(WORLD_LIST, "安全的战局", {}, "全战局幽灵", function(on)
	if on then
		for k,v in pairs(players.list(false, true, true)) do
			if players.exists(v) then
				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(v,true)
			end
		end
	else
		for k,v in pairs(players.list(false, true, true)) do
			if players.exists(v) then
				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(v,false)
			end
		end
	end 
end)

--------------------------------
------------ 其他选项 ------------
--------------------------------
----------音乐播放器---------- 

local music_dir <const> = filesystem.store_dir() .. "LM\\Music\\"
all_musics = {}
local load_music_action = menu.list_action(music_player, "音乐目录", {}, "不支持中文名称\n停止脚本可停止播放", all_musics, function(index, value)
    local path = music_dir .. "\\" .. value
    playmusic(path)
end)    

function get_all_musics_in_dir()
    local temp_musics = {}
    for i, path in ipairs(filesystem.list_files(music_dir)) do
        if string.match(path:gsub(music_dir, ""), ".wav") then
            temp_musics[#temp_musics + 1] = path:gsub(music_dir, "")   
        end
    end
    all_musics = temp_musics
    menu.set_list_action_options(load_music_action, all_musics)
end

util.create_tick_handler(function ()
    get_all_musics_in_dir()
    util.yield(5000)
end)
----------移动电视---------- 
menu.toggle_loop(tv_list, "播放电视", {""}, "", function()
    GRAPHICS.SET_TV_AUDIO_FRONTEND(true)
    GRAPHICS.SET_SCRIPT_GFX_DRAW_ORDER(4)
    GRAPHICS.SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(true)
    GRAPHICS.DRAW_TV_CHANNEL(gConfig.tv.x, gConfig.tv.y, gConfig.tv.size, gConfig.tv.size, 0.0, 255, 255, 255, 250)
end)

menu.slider(tv_list, "X", {}, "", 0, 100, gConfig.tv.x*100, 1, function(value)
    gConfig.tv.x = value / 100
end)

menu.slider(tv_list, "Y", {}, "", 0, 100, gConfig.tv.y*100, 1, function(value)
    gConfig.tv.y = value / 100
end)

menu.slider(tv_list, "比例", {}, "", 0, 100, gConfig.tv.size*100, 1, function(value)
    gConfig.tv.size = value / 100
end)

menu.divider(tv_list,"电视节目")

for _, tv in pairs(tv_name) do
    menu.action(tv_list, tv, {}, "播放电视节目: " .. tv, function()
        GRAPHICS.SET_TV_CHANNEL(-1)
        GRAPHICS.SET_TV_CHANNEL_PLAYLIST(0, tv, true)
        GRAPHICS.SET_TV_CHANNEL(0)
    end)
end

----------过场动画---------- 
menu.action(cutscenes_list, "停止动画", {}, "", function ()
    menu.trigger_commands("skipcutscene")
end)

menu.divider(cutscenes_list, "动画列表")

function Finish()
    local tripped = false
    repeat
        util.yield(0)
        if (CUTSCENE.GET_CUTSCENE_TOTAL_DURATION() - CUTSCENE.GET_CUTSCENE_TIME() <= 250) then
            CAM.DO_SCREEN_FADE_OUT(250)
        tripped = true
        end
    until not CAM.DO_SCREEN_FADE_OUT()
    if (not tripped) then
        CAM.DO_SCREEN_FADE_OUT(100)
        util.yield(150)
    end
    return
end


menu.action(cutscenes_list, "死亡动画", {""}, "线上第一次死亡动画", function()
    CUTSCENE.SET_CUTSCENE_TRIGGER_AREA(0.0, 0.0, 0.0, 0.0, 121.6249, 0.0)
    x = PATHFIND.ADD_NAVMESH_BLOCKING_OBJECT(-1314.997, -1721.084, 1.1493, 100.0, 100.0, 100.0, 0.0, false, 7)
    MISC.SET_OVERRIDE_WEATHER("CLEARING")
    --GRAPHICS.SET_TRANSITION_TIMECYCLE_MODIFIER("Kifflom", 1.0)
    NETWORK.NETWORK_ALLOW_GANG_TO_JOIN_TUTORIAL_SESSION(1, PLAYER.PLAYER_ID() + 32)
    MISC.SET_RAIN(0.0)
    while not CUTSCENE.HAS_CUTSCENE_LOADED("MP_INT_MCS_18_A1") do
        CUTSCENE.REQUEST_CUTSCENE_WITH_PLAYBACK_LIST("MP_INT_MCS_18_A1", 29, 8)
        util.yield()
    end
    CUTSCENE.START_CUTSCENE_AT_COORDS(-1314.997, -2021.084, 1.1493, 0)
    CAM.DO_SCREEN_FADE_IN(250)
    Finish()
    CUTSCENE.REMOVE_CUTSCENE()
    CAM.DO_SCREEN_FADE_IN(500)
    --GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
    PED.CLEAR_PED_NON_CREATION_AREA()
    PATHFIND.REMOVE_NAVMESH_BLOCKING_OBJECT(x)
end)

for _, cutscene in pairs(cutscene_name) do
    menu.action(cutscenes_list, cutscene, {cutscene}, "播放动画: " .. cutscene, function()
        while not CUTSCENE.HAS_CUTSCENE_LOADED(cutscene) do
            CUTSCENE.REQUEST_CUTSCENE(cutscene, 8)
            util.yield()
        end
        CUTSCENE.START_CUTSCENE(cutscene)
    end)
end

----------音乐事件---------- 

for _, music_event in pairs(music_event_name) do
    menu.action(music_event_list, music_event, {music_event}, "播放音乐事件: " .. music_event, function()
        AUDIO.PREPARE_MUSIC_EVENT(music_event)
        AUDIO.TRIGGER_MUSIC_EVENT(music_event)
    end)
end

----------屏幕特效---------- 
menu.toggle(screen_effect, "洛圣都今日快报", {}, "", function(state)
    loop = state
    local news = GRAPHICS.REQUEST_SCALEFORM_MOVIE("BREAKING_NEWS")
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(news, "SET_TEXT")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("洛圣都今日快报")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(players.get_name(players.user()).."  已成为洛圣都首要通缉罪犯")
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD(news)
    while loop do
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(news, 255, 255, 255, 255, 0)
        util.yield(0)
    end
end)

----------主机序列---------- 
--local host_queue_pos = {x = 0.17 ,y = 0.788}
--local gConfig.host_queue.size = 0.4
menu.toggle(host_queue, "主机序列", {"hostqueue"}, "", function(toggle)
    gConfig.host_queue.toggle = toggle
end,gConfig.host_queue.toggle)
menu.slider(host_queue, "X轴", {}, "", 0, 1000, gConfig.host_queue.x*1000, 1, function(value)
    gConfig.host_queue.x = value / 1000
end)

menu.slider(host_queue, "X轴", {}, "", 0, 1000, gConfig.host_queue.y*1000, 1, function(value)
    gConfig.host_queue.y = value / 1000
end)

menu.slider(host_queue, "比例", {}, "", 0, 100, gConfig.host_queue.size*100, 1, function(value)
    gConfig.host_queue.size = value / 100
end)

------------------------------------------------------

menu.toggle(MISC_LIST, "玩家栏", {""}, "", function(toggle)
    gConfig.other.playerbar = toggle
end,gConfig.other.playerbar)
 
menu.toggle(MISC_LIST, "时速表", {""}, "", function(toggle)
    gConfig.other.speedometer = toggle
end,gConfig.other.speedometer)

menu.toggle(MISC_LIST, "显示时间", {""}, "", function(toggle)
    gConfig.other.timeos = toggle
end,gConfig.other.timeos)

menu.toggle(MISC_LIST, "显示脚本名称", {"scriptname"}, "", function(toggle)
    gConfig.other.show_script_name = toggle
end,gConfig.other.show_script_name)

menu.action(MISC_LIST, "保存设置", {}, "", function()
	ini.save(configFile, gConfig)
    NOTIF("设置已保存")
end)

--save
util.create_thread(function ()  
    while true do
        if gConfig.next_chat.next_chat_toggle then
            HUD.MP_TEXT_CHAT_DISABLE(true)
            local min_rect_width = 0.3
            local chat_box_x = gConfig.next_chat.pos_x
            local chat_box_y = gConfig.next_chat.pos_y
            local max_chat_box_x = min_rect_width - 0.025    
            if PAD.IS_CONTROL_JUST_RELEASED(245, 245) then 
                chat.send_message(InputBox("","全部",""), false, true, true)
            elseif PAD.IS_CONTROL_JUST_RELEASED(246, 246) then 
                chat.send_message(InputBox("","团队",""), true, true, true)
            end
            if pos_x_slider_focused or pos_y_slider_focused or tag_scale_slider_focused or text_scale_slider_focused then 
                last_chat_time = os.time()
            end
            if gConfig.next_chat.show_typing then
                local typers = get_all_typers_string()
                if typers ~= "" then 
                    if gConfig.next_chat.wake_typing then 
                        last_chat_time = os.time()
                    end
                end
                if #all_visible_chats > 0 then
                    directx.draw_text(chat_box_x + (max_chat_box_x / 2), chat_box_y - 0.01, typers, 5, gConfig.next_chat.text_scale, typing_color, true)
                end
            end
            if #all_visible_chats > 0 then
                if os.time() - last_chat_time < gConfig.next_chat.display_time then
                    directx.draw_rect(chat_box_x, chat_box_y, min_rect_width, chat_box_y_scale, bg_color)
                    local y_offset = 0.0
                    for index, c in all_visible_chats do
                        local concat_text = ": " .. c.text:gsub("\n", "")
                        local concat_tag = " [" .. c.tag .. "]"
                        local concat_name = "" .. c.player_name
                        local name_measure_x, name_measure_y = directx.get_text_size(concat_name, gConfig.next_chat.text_scale)
                        local tag_measure_x, tag_measure_y = directx.get_text_size(concat_tag, gConfig.next_chat.tag_scale)
                        local text_measure_x, text_measure_y = directx.get_text_size(concat_text, gConfig.next_chat.text_scale)
                        local guesstimate_width = (name_measure_x + tag_measure_x + text_measure_x) -- for spaces between the name, tag, and then text
                        if guesstimate_width > min_rect_width then 
                            min_rect_width = guesstimate_width
                        end
                        local segments = {}
                        segments[1] = concat_text
                        if guesstimate_width > max_chat_box_x then
                            local string_limit = 65
                            for i=1, 254 do
                                local scale_x, _ = directx.get_text_size(concat_text:sub(1, i), gConfig.next_chat.text_scale)
                                guesstimate_width = (name_measure_x + tag_measure_x + scale_x)
                                if guesstimate_width <= max_chat_box_x then
                                    string_limit = i 
                                else 
                                    break
                                end
                            end
                            segments = split_string_chunks_respect_word(concat_text, string_limit)
                        end
                        for i, line in pairs(segments) do
                            local _, guesstimate_height = directx.get_text_size(line, gConfig.next_chat.text_scale)
                            local x_offset = chat_box_x
                            if  i == 1 then
                                directx.draw_text(x_offset, chat_box_y + y_offset, concat_name, 3, gConfig.next_chat.text_scale, c.player_color)
                                x_offset = chat_box_x + name_measure_x
                                if c.tag ~= "" then
                                    directx.draw_text(x_offset, chat_box_y + y_offset + (tag_measure_y/10), concat_tag, 3, gConfig.next_chat.tag_scale, tag_color)
                                    x_offset += name_measure_x
                                    directx.draw_text(chat_box_x + name_measure_x + tag_measure_x, chat_box_y + y_offset, line, 3, gConfig.next_chat.text_scale, msg_text_color, true)
                                else 
                                    directx.draw_text(chat_box_x + name_measure_x, chat_box_y + y_offset, line, 3, gConfig.next_chat.text_scale, msg_text_color, true)
                                end
                            else
                                directx.draw_text(x_offset, chat_box_y + y_offset, line, 3, gConfig.next_chat.text_scale, msg_text_color, true)
                            end
                            y_offset += guesstimate_height + 0.001
                            chat_box_y_scale = y_offset
                        end
                    end
                end
            end
        else
            HUD.MP_TEXT_CHAT_DISABLE(false)
        end 
        if gConfig.host_queue.toggle then
            inviciamountint = 0
            for pid = 0, 31 do
                if players.exists(pid) and pid ~= players.user() then
                    local pped = players.user_ped(pid)
                    if pped ~= 0 then
                        if players.is_marked_as_modder(pid) then
                            inviciamountint = inviciamountint + 1
                        end
                    end
                end
                local ente
                local ent1e = players.user_ped()
                local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
                local speede = ENTITY.GET_ENTITY_SPEED(ente)
                local speedcalce = speede * 3.6
                myspeed1e = math.ceil(speedcalce)
            end
            inviciamountintt = inviciamountint
            draw_string(string.format("~h~~o~"..myspeed1e.." ~w~KM/H"), gConfig.host_queue.x, gConfig.host_queue.y, gConfig.host_queue.size, 0)
            draw_string(string.format("~h~"..os.date("%X")), gConfig.host_queue.x,gConfig.host_queue.y+0.027, gConfig.host_queue.size,0)    
            draw_string(string.format("~h~战局玩家: ~g~"..#players.list()), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027, gConfig.host_queue.size, 0) 
            draw_string(string.format("~h~作弊玩家: ~r~"..inviciamountintt), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027, gConfig.host_queue.size, 0) 
            if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
                draw_string(string.format("~h~战局主机: ~y~没有人"), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027+0.027, gConfig.host_queue.size, 0)
            else
                draw_string(string.format("~h~战局主机: ~y~"..players.get_name(players.get_host())), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027+0.027, gConfig.host_queue.size, 0)
            end
            if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
                draw_string(string.format("~h~脚本主机: ~b~没有人"), gConfig.host_queue.x,gConfig.host_queue.y+0.027+0.027+0.027+0.027+0.027, gConfig.host_queue.size,0)
            else
                draw_string(string.format("~h~脚本主机: ~b~"..players.get_name(players.get_script_host())), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027+0.027+0.027, gConfig.host_queue.size, 0)
            end
            local is_host = players.get_host_queue_position(players.user())
            if is_host == 0 then
                draw_string(string.format("~h~~q~你现在是战局主机"), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027+0.027+0.027+0.027, gConfig.host_queue.size, 0) 
            else
                draw_string(string.format("~h~~p~你的主机优先度:~q~ "..is_host), gConfig.host_queue.x, gConfig.host_queue.y+0.027+0.027+0.027+0.027+0.027+0.027, gConfig.host_queue.size, 0) 
            end
        end
        if gConfig.session.always_host then
            if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
                if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
                    menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
                    util.yield(200)
                end
            end
        end
        if gConfig.session.always_scripthost then
            if not (players.get_script_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
                if not (PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**") then
                    menu.trigger_commands("scripthost")
                    util.yield(200)
                end
            end 
        end
        if gConfig.other.playerbar then
            posx = 0.001
            posy = 0.00
            for pid = 0,31 do
                if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                    color =  {["r"] = 255/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
                    tags = ""
                    network = memory.alloc(13*4)
                    name = PLAYER.GET_PLAYER_NAME(pid)
                    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid,network,13)
                    if players.is_marked_as_modder(pid) then
                        tags = tags .. "[作弊者]"
                        color = {["r"] = 255/255,["g"] = 0/255,["b"] = 0/255,["a"] = 255/255}   
                    end
                    if players.is_godmode(pid) then 
                        tags = tags .. "[无敌]"
                        color = {["r"] = 255/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
                    end
                    if players.is_in_interior(pid) then
                        tags = tags .. "[室内]"
                        color = {["r"] = 0/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
                    end
                    if players.is_marked_as_attacker(pid) then
                        tags = tags .. "[攻击过你]"
                        color = {["r"] = 255/255,["g"] = 255/255,["b"] = 128/255,["a"] = 255/255} 
                    end
                    if NETWORK.NETWORK_IS_FRIEND(network) then
                        tags = tags .. "[好友]"
                        color = {["r"] = 7/255,["g"] = 55/255,["b"] = 99/255,["a"] = 255/255}
                    end
                    if players.get_host() == pid then
                        tags = tags .. "[主机]"
                        color = {["r"] = 0/255,["g"] = 255/255,["b"] = 0/255,["a"] = 255/255} 
                    end
                    if players.get_script_host() == pid then
                        tags = tags .. "[脚本主机]"
                        color = {["r"] = 153/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
                    end
                    memory.free(network)
                    directx.draw_text(posx,posy,name.." "..tags,ALIGN_TOP_LEFT,0.5,color)
                    posx = posx + 0.145
                    if posx > 0.96 then
                        posy = posy + 0.0175
                        posx = 0.001
                    end
                end
            end
        end
        if gConfig.other.speedometer then
            local ent
            local ent1 = players.user_ped()
            local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
            if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = ENTITY.GET_ENTITY_SPEED(ent)
            local speedcalc = speed * 3.6
            myspeed1 = math.ceil(speedcalc)    
            draw_string(string.format("~bold~~italic~~o~"..myspeed1 .. "  ~w~KM/H"), 0.84,0.8, 1,5)
        end
        if gConfig.other.timeos then
            draw_string(string.format(os.date("~bold~~italic~%Y-%m-%d %H:%M:%S", os.time())), 0.83,0.1, 0.5,5)
        end
        if gConfig.other.show_script_name then
            rainbow_color()
            draw_string(string.format("     <i>¦-∑\n ~h~<i> VIP ["..players.get_name(players.user()).."]"), 0.43,0.1, 0.60,5)
        end
        util.yield()
    end
end)

--------------------------------
------------ 玩家选项 ------------
--------------------------------
Player_functions = function(PlayerID)

    menu.divider(menu.player_root(PlayerID), "Heezy二代目")
    local Heezy <const> = menu.player_root(PlayerID):list("Heezy二代目")
        local crash_player <const> = Heezy:list("移除")
        local troll_player <const> = Heezy:list("恶搞")
            local classic_troll <const> = troll_player:list("经典恶搞")
                local blurred_screen <const> = classic_troll:list("花屏玩家")
                local seizures <const> = classic_troll:list("闪屏玩家")
            local script_event <const> = troll_player:list("脚本事件")
            local vehicle_troll <const> = troll_player:list("载具恶搞")
            local cage_troll <const> = troll_player:list("笼子恶搞")
            local cpu_burn <const> = troll_player:list("CPU攻击")
    
    ----------移除---------- 
    menu.divider(crash_player, "踢出")
    menu.action(crash_player, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()
        menu.trigger_commands("historyblock " .. players.get_name(PlayerID))
        menu.trigger_commands("breakup " .. players.get_name(PlayerID))
    end)

    menu.divider(crash_player, "崩溃")

    menu.action(crash_player,"旅行者崩溃", {""}, "", function()

        util.create_thread(function ()
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local coords = ENTITY.GET_ENTITY_COORDS(ped)
            local model =  {1492612435, 3517794615, 3889340782, 3253274834,1591739866,1748565021,1550581940,3253274834}
            for vehicle, value in pairs(model) do
                local invalid = {}
                invalid[vehicle] = CreateVehicle(value,coords,0)
                VEHICLE.SET_VEHICLE_MOD_KIT(invalid[vehicle], 0)
                ENTITY.SET_ENTITY_COLLISION(invalid[vehicle], false, true)
                VEHICLE.SET_VEHICLE_GRAVITY(invalid[vehicle], 0)
                for i=0, 49 do
                    local max_mod = VEHICLE.GET_NUM_VEHICLE_MODS(invalid[vehicle], i)-1
                    VEHICLE.SET_VEHICLE_MOD(invalid[vehicle], i, max_mod, false)
                end
            end
        end)
        util.create_thread(function ()
            local model_array <const> = {0x58f77553,0x1446590a}
            local crash_c <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) crash_c.x = crash_c.x + 3
            local ped_ <const> = CreatePed(26,util.joaat("A_C_Rabbit_02"),crash_c,0)
            for spawn, vel in pairs(model_array) do
                local ves <const> = {}
                ves[spawn] = CreateVehicle(vel,crash_c,0)
                ENTITY.SET_ENTITY_VISIBLE(ves[spawn], false, false)
                for key, value in pairs(ves) do
                    PED.SET_PED_INTO_VEHICLE(ped_,value,-1)
                    TASK.TASK_VEHICLE_HELI_PROTECT(ped_,value,players.user_ped(),1,1,100,10,1)
                end
            end
            util.yield(2000)
            local vels_ <const> = entities.get_all_vehicles_as_handles()
            for delete, value in pairs(vels_) do
                entities.delete_by_handle(value)
                entities.delete_by_handle(ped_)
            end
        end,nil)
        util.create_thread(function ()
            local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
            position.x = position.x + 3
            local sb_ped <const> = CreatePed(26,util.joaat("a_c_rat"),position,0)
            crash_plane  = CreateVehicle(0x9c5e5644,position,0)
            ENTITY.SET_ENTITY_VISIBLE(crash_plane, false, false)
            PED.SET_PED_INTO_VEHICLE(sb_ped,crash_plane,-1)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(),crash_plane,-1)
            ENTITY.FREEZE_ENTITY_POSITION(crash_plane,true)
            local time <const> = util.current_time_millis() + 3500
            TASK.TASK_OPEN_VEHICLE_DOOR(players.user_ped(), crash_plane, 9999, -1, 2)
            while time > util.current_time_millis() do
                TASK.TASK_LEAVE_VEHICLE(sb_ped, crash_plane, 0)
                util.yield(5)
            end
            entities.delete_by_handle(sb_ped)
       end,nil)
        util.create_thread(function ()
            local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
            position.x = position.x + 3
            local rat <const> = CreatePed(26,util.joaat("a_c_rat"),position,0)
            ENTITY.SET_ENTITY_VISIBLE(rat,false)
            obs  = OBJECT.CREATE_OBJECT_NO_OFFSET(1888301071,position.x,position.y,position.z,true,false)
            util.create_thread(function ()
                local time <const> = util.current_time_millis() + 3500
                while time > util.current_time_millis() do
                    TASK.TASK_CLIMB_LADDER(0xB6C987F9285A3814,rat)	
                    util.yield(100)
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(rat)
                end
            end,nil)
        end,nil)
        util.create_thread(function ()
            local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) 
            local model = {util.joaat("cs_wade"),util.joaat("a_c_rat"),util.joaat("cs_beverly"),util.joaat("cs_fabien"),util.joaat("cs_manuel"),util.joaat("cs_taostranslator"),util.joaat("cs_taostranslator2"),util.joaat("cs_tenniscoach")}
            for _spawn, value in pairs(model) do
                local task_crash = {}
                task_crash[_spawn] = CreatePed(26,value,position,0)

                ENTITY.FREEZE_ENTITY_POSITION(task_crash[_spawn],true)
                for start, value1 in pairs(task_crash) do
                    local play = {}
                    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(value1, util.joaat("weapon_pistol"), 0, true)
                    util.yield(200)
                    pos = ENTITY.GET_ENTITY_COORDS(value1)
                    play[start] = MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x,pos.y,pos.z,pos.x,pos.y,pos.z+0.1, 0, true,453432689, players.user_ped(), false, true, 100)
                    util.yield(500)
                    ENTITY.FREEZE_ENTITY_POSITION(value1,false)
                    ENTITY.SET_ENTITY_HEALTH(value1,0)
                    util.yield(500)
                    entities.delete_by_handle(value1)
                end
            end
        end,nil)
        util.create_thread(function ()
            local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)) position.y = position.y + 8
            local PED1  = CreatePed(28,-1011537562,position,0)
            local PED2  = CreatePed(28,-541762431,position,0)
            ENTITY.SET_ENTITY_INVINCIBLE(PED1,true)
            ENTITY.SET_ENTITY_INVINCIBLE(PED2,true)
            WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
            WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
            util.yield(1000)
            TASK.TASK_THROW_PROJECTILE(PED1,position.x,position.y,position.z,0,0)
            TASK.TASK_THROW_PROJECTILE(PED2,position.x,position.y,position.z,0,0)
        end,nil)
        util.yield(2000)
        util.create_thread(function ()
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local user = PLAYER.GET_PLAYER_PED(players.user())
            local pos = ENTITY.GET_ENTITY_COORDS(ped)
            local my_pos = ENTITY.GET_ENTITY_COORDS(user)
            local anim_dict = ("anim@mp_player_intupperstinker")
            request_anim_dict(anim_dict)
            BlockSyncs(PlayerID, function()
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
                util.yield(100)
                TASK.TASK_SWEEP_AIM_POSITION(user, anim_dict, "toma", "puto", "tonto", -1, 0.0, 0.0, 0.0, 0.0, 0.0)
                util.yield(100)
            end)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, my_pos.x, my_pos.y, my_pos.z, false, false, false)
        end,nil)
        util.yield(1000)
        util.create_thread(function ()
            local user = players.user()
            local user_ped = players.user_ped()
            local pos = players.get_position(user)
            BlockSyncs(PlayerID, function() 
                util.yield(100)
                PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
                TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
                util.yield()
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
                util.yield(250)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
                PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
                util.yield(1000)
                for i = 1, 5 do
                    util.spoof_script("freemode", SYSTEM.WAIT)
                end
                ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
                NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
            end)
        end)
        util.yield(1000)
        util.create_thread(function ()
            local stupid_pos <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) stupid_pos.x = stupid_pos.x +1
            local mod_vel = {184361638,642617954,586013744,920453016,3186376089,1030400667,240201337}
                for _spawn, value in pairs(mod_vel) do
                    local s = {}
                    for i = 1, 10, 1 do  
                        s[_spawn] = CreateVehicle(value,stupid_pos,0)
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(s[_spawn], true, false)
                        util.yield(0)
                        end
                    end
                    util.yield(1000)
                    local ar_vs = entities.get_all_vehicles_as_handles()
                    for key, value in pairs(ar_vs) do
                    entities.delete_by_handle(value)
                end
        end,nil)
    end)

    menu.action(crash_player, "MDS", {""}, "", function()
        local plauuepos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        plauuepos.x = plauuepos.x + 10
        plauuepos.z = plauuepos.z + 10
        local hunter = {}
        for i = 1 ,3 do
            for n = 0,120 do
                hunter[n] = CreateVehicle(0x9c5e5644,plauuepos,0)
                ENTITY.SET_ENTITY_VISIBLE(hunter[n],false,false)
                util.yield(0)
                ENTITY.FREEZE_ENTITY_POSITION(hunter[n],true)
                util.yield(0)
                request_ptfx_asset("scr_xm_orbital")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
                start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", plauuepos, v3_2t1(0, 180, 0), 4.5, true, true, false)
                FIRE.ADD_EXPLOSION(plauuepos.x, plauuepos.y, plauuepos.z, 59, 5000, false, false, 1.0, false)
            end
            util.yield(190)
            for i = 1,#hunter do
                if hunter[i] ~= nil then
                    entities.delete_by_handle(hunter[i])
                end
            end
        end
    end)


    menu.action(crash_player, "Crash Xipro", {""}, "", function()
        util.request_model("a_m_y_beach_04", 300)
		util.request_model("raketrailer", 300)
		util.yield(1000)
        local player_ped_location = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))     
        local ped_to_collect = entities.create_ped(0 , util.joaat("a_m_y_beach_04"), player_ped_location, 0)
        for j = 1,50,1 do
            local model = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer")}
            ENTITY.SET_ENTITY_VISIBLE(ped_to_collect, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ped_to_collect, player_ped_location.x, player_ped_location.y, player_ped_location.z)
            for spawn, value in pairs(model) do
                local vels = {}
                vels[spawn] = entities.create_vehicle(value, player_ped_location, 0)
                for value,value1 in pairs(vels) do
                    ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value1, ped_to_collect, 0, 0, true, true)
                end
            end
        end
        util.yield(300)
        menu.trigger_commands("explode" ..  players.get_name(PlayerID)) 
        menu.trigger_commands("explode" ..  players.get_name(PlayerID))
        menu.trigger_commands("explode" ..  players.get_name(PlayerID))
        util.yield(1000)
    end)
    ----------经典恶搞---------- 

    menu.list_select(classic_troll, "爆炸类型", {"explosiontype"}, "", explosion_types, 0, function(value)
        explosion_type = value
    end)

    menu.action(classic_troll, "爆炸玩家", {""}, "", function()
        if players.exists(PlayerID) then
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
            FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], explosion_type, 1.0, true, false, 0.0)
        end
    end)

    menu.toggle_loop(classic_troll, "循环爆炸", {""}, "", function()
        if players.exists(PlayerID) then
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
            FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], explosion_type, 1.0, true, false, 0.0)
        end
    end)

    menu.toggle_loop(classic_troll, "循环喷火", {"flameloop"}, "经典恶搞之一", function(on_click)
        if players.exists(PlayerID) then
            local player_pos = players.get_position(PlayerID)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 12, 1, true, false, 1, false)
            util.yield(5)
        end
    end)

    menu.toggle_loop(classic_troll, "循环喷水", {"waterloop"}, "经典恶搞之一", function(on_click)
        if players.exists(PlayerID) then
            local player_pos = players.get_position(PlayerID)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 13, 1, true, false, 1, false)
            util.yield(5)
        end
    end)

    menu.toggle_loop(classic_troll, "随机循环", {"randomloop"}, "经典恶搞之一", function(on)
        if players.exists(PlayerID) then
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
            FIRE.ADD_EXPLOSION(coords["x"], coords["y"], coords["z"], math.random(0, 82), 1.0, true, false, 0.0)
        end
    end)

	menu.toggle_loop(classic_troll, "折腾玩家", {"tossplayers"}, "在玩家身上循环无损伤的爆炸", function()
        if players.exists(PlayerID) then
            local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), true)
            FIRE.ADD_EXPLOSION(playerCoords["x"], playerCoords["y"], playerCoords["z"], 1, 1, false, false, 0, true)
        end
    end)

    menu.toggle_loop(classic_troll,"火箭雨", {"rockets"}, "", function()
        if players.exists(PlayerID) then
            local user_ped = PLAYER.PLAYER_PED_ID()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
            local owner
            local hash = util.joaat("weapon_airstrike_rocket")
            if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
                WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
            end
            pos.x = pos.x + math.random(-6,6)
            pos.y = pos.y + math.random(-6,6)
            local ground_ptr = memory.alloc(32); MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ground_ptr, false, false); pos.z = memory.read_float(ground_ptr); memory.free(ground_ptr)
            if owned then owner = user_ped else owner = 0 end
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+50, pos.x, pos.y, pos.z, 200, true, hash, owner, true, false, 2500.0)
        util.yield(100)
        end
    end)

    menu.toggle_loop(classic_troll, "大风车", {"Windmills"}, "", function(on_toggle)
        if players.exists(PlayerID) then
            BlockSyncs(PlayerID, function()
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                entities.delete_by_handle(object)
                local object = entities.create_object(util.joaat("prop_windmill_01"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
                OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, true)
                util.yield(1000)
                entities.delete_by_handle(object)
            end)
        end
    end)

    menu.toggle_loop(classic_troll, "外星人爆炸循环", {"ufoloop"}, "模拟外星人入侵", function()
        if players.exists(PlayerID) then
            local ufo = util.joaat("sum_prop_dufocore_01a")
            local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local c = ENTITY.GET_ENTITY_COORDS(p)
            STREAMING.REQUEST_MODEL(ufo)
            while not STREAMING.HAS_MODEL_LOADED(ufo) do
                STREAMING.REQUEST_MODEL(ufo)
                util.yield()
            end
            c.z = c.z + 10
            local spawnedufo = entities.create_object(ufo, c)
            util.yield(2000)
            c = ENTITY.GET_ENTITY_COORDS(p)
            FIRE.ADD_EXPLOSION(c.x, c.y, c.z, exp, 100.0, true, false, 3.0, false)
            util.yield(1000)
            entities.delete_by_handle(spawnedufo)
            menu.trigger_commands("freeze".. players.get_name(PlayerID).. " off")
        end
    end)

    menu.toggle_loop(classic_troll,"海市蜃楼?", {""}, "", function()
        if players.exists(PlayerID) then
			local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local mirage_model = util.joaat("dt1_lod_slod3")
            request_model(mirage_model)
            local mirage1 = entities.create_object(mirage_model, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), -100, 0, 100), ENTITY.GET_ENTITY_HEADING(id))
            local mirage2 = entities.create_object(mirage_model, playerpos, 0)
            local mirage3 = entities.create_object(mirage_model, playerpos, 0)
            local mirage4 = entities.create_object(mirage_model, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(mirage1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(mirage2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(mirage3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(mirage4)
            Set_Entity_Networked(mirage1,false)
            Set_Entity_Networked(mirage2,false)
            Set_Entity_Networked(mirage3,false)
            Set_Entity_Networked(mirage4,false)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(mirage2, mirage1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(mirage3, mirage1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(mirage4, mirage1, 0, 0, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(mirage1, true)
            util.yield()
            entities.delete_by_handle(mirage1)
            entities.delete_by_handle(mirage2)
            entities.delete_by_handle(mirage3)
            entities.delete_by_handle(mirage4)
        end
    end)

    ----------花屏---------- 

    menu.toggle_loop(blurred_screen, "花屏 V1", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "ent_ray_heli_aprtmnt_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V2", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "ent_sht_paint_cans", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V3", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "ent_dst_inflatable", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V4", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "ent_sht_extinguisher_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V5", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_sum2_hal_rider_death_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V6", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_sum2_hal_rider_death_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V7", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_sum2_hal_rider_death_greyblack", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V8", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_sum2_hal_rider_death_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    menu.toggle_loop(blurred_screen, "花屏 V9", {""}, "请远离该玩家", function()
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." on")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." on")
        local player_pos = players.get_position(PlayerID)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    end,function ()
        util.yield(100)
        menu.trigger_commands("freeze "..players.get_name(PlayerID).." off")
        menu.trigger_commands("confuse "..players.get_name(PlayerID).." off")
	end)

    ----------闪屏---------- 

    menu.toggle_loop(seizures, "闪屏 V1", {""}, "", function()
        if players.exists(PlayerID) then
            local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local khanjali = util.joaat("cargobob")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1)
            local khanjali = util.joaat("kosatka")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(seizures, "闪屏 V2", {""}, "", function()
        if players.exists(PlayerID) then
            local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local khanjali = util.joaat("cargoplane")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, 180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1)
            local id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local playerpos = ENTITY.GET_ENTITY_COORDS(id)
            playerpos.z = playerpos.z + 3
            local khanjali = util.joaat("cargoplane")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1)
            local khanjali = util.joaat("cargobob")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1) 
            local khanjali = util.joaat("kosatka")
            STREAMING.REQUEST_MODEL(khanjali)
            while not STREAMING.HAS_MODEL_LOADED(khanjali) do
                util.yield()
            end       
            local vehicle1 = entities.create_vehicle(khanjali, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PlayerID), 0, 2, 3), ENTITY.GET_ENTITY_HEADING(id))
            local vehicle2 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle3 = entities.create_vehicle(khanjali, playerpos, 0)
            local vehicle4 = entities.create_vehicle(khanjali, playerpos, 0)           
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle1)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle2)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle3)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle4)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
            ENTITY.SET_ENTITY_VISIBLE(vehicle1, true)
            util.yield(0)
            entities.delete_by_handle(vehicle1)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)



    menu.action(classic_troll, "掉帧", {""}, "", function()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)  
        for i = 0, 180 do 
            attachmentveh1 = CreateVehicle(353883353,TargetPlayerPos,0)   
        end
    end)

    menu.action(classic_troll, "核弹", {""}, "", function(on_click)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)
        local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)
        TargetPlayerPos.y = TargetPlayerPos.y + 2
        TargetPlayerPos.z = TargetPlayerPos.z + 70 
        ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)
        ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)
        util.yield(5000)
	    for i = 0, 30 do 
            pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
            for j = -2, 2 do 
                for k = -2, 2 do 
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
                    FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pos.x + j, pos.y + j, pos.z + (30 - i), 29, 999999.99, true, false, 8)
                end
            end
            util.yield(20)
        end
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
    end)


    ----------笼子恶搞---------- 

    cages = {} 
    function cage_player(pos)
        local object_hash = util.joaat("prop_gold_cont_01b")
        pos.z = pos.z-0.9
        request_model(object_hash)
        local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
        cages[#cages + 1] = object1																			
        local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
        cages[#cages + 1] = object2
        ENTITY.FREEZE_ENTITY_POSITION(object1, true)
        ENTITY.FREEZE_ENTITY_POSITION(object2, true)
        local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
        rot.x = -180
        rot.y = -180
        ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
    end

    menu.action(cage_troll, "笼子", {""}, "", function ()
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				NOTIF("未能将玩家踢出载具")
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
		end
		cage_player(pos)
    end)
    menu.action(cage_troll, "七度空间", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = 1089807209
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false)
        local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false)
        local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false)
        local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false)
        cages[#cages + 1] = cage_object
        local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
        rot.y = 90
        ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
        ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
        ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
        ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
        ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
        util.yield(15)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "钱笼子", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = util.joaat("bkr_prop_moneypack_03a")
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false)
        local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false)
        local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false)
        local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false)
        local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false)
        local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false)
        cages[#cages + 1] = cage_object
        cages[#cages + 1] = cage_object
        util.yield(15)
        local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
        rot.y = 90
        ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "垃圾箱", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = 684586828
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
        cages[#cages + 1] = cage_object
        util.yield(15)
        local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
        rot.y = 90
        ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "小车车", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = 4022605402
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
        cages[#cages + 1] = cage_object
        util.yield(15)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "圣诞快乐", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = 238789712
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
        cages[#cages + 1] = cage_object
        util.yield(15)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "圣诞快乐pro", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = util.joaat("ch_prop_tree_02a")
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false)
        local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false)
        local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false)
        local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false)
        cages[#cages + 1] = cage_object
        cages[#cages + 1] = cage_object
        util.yield(15)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "圣诞快乐promax", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        local hash = util.joaat("ch_prop_tree_03a")
        request_model(hash)
        local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false)
        local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false)
        local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false)
        local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false)
        local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false)
        cages[#cages + 1] = cage_object
        cages[#cages + 1] = cage_object
        util.yield()
        local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
        rot.y = 90
        ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)
    
    menu.action(cage_troll, "电击笼", {""}, "", function ()
        local number_of_cages = 4
        local elec_box = util.joaat("prop_elecbox_12")
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z -= 0.5
        request_model(elec_box)
        local temp_v3 = v3.new(0, 0, 0)
        for i = 1, number_of_cages do
            local angle = (i / number_of_cages) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(2.1)
            obj_pos:add(pos)
            for offs_z = 1, 5 do
                local spawned_objects = {}
                local electric_cage = entities.create_object(elec_box, obj_pos)
                spawned_objects[#spawned_objects + 1] = electric_cage
                ENTITY.SET_ENTITY_ROTATION(electric_cage, 90, 0, angle, 2, 0)
                obj_pos.z += 0.75
                ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
            end
        end
    end)
    
    menu.action(cage_troll, "竞技管", {""}, "", function ()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
        request_model(2081936690)
        local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
        cages[#cages + 1] = cage_object
        util.yield(15)
        local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
        rot.y = 90
        ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
    end)

    menu.toggle(cage_troll, "新世纪全自动化套笼", {"autocage"}, "自动套笼子", function(state)
        cage_loop = state
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					NOTIF("踢出载具失败")
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(PlayerID).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)) 
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				NOTIF(PLAYER.GET_PLAYER_NAME(PlayerID).."跑出来了，再次套住")
				::continue::
			end
			util.yield(1000)
		end
	end)

    menu.action(cage_troll, "删除笼子", {""}, "只能删除简单的笼子", function() 
        for key, value in pairs(cages) do
            entities.delete_by_handle(value)
        end
    end)

    ----------载具恶搞---------- 

    menu.action(vehicle_troll,"传送载具到我", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		if not PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
			return
		end
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or
		not VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) then
		elseif request_control(vehicle, 1000) then
			ENTITY.SET_ENTITY_COORDS(vehicle, pos.x,pos.y,pos.z, false, false, false, false)
		else
			NOTIF("未能获取载具控制权")
		end
    end)
    
    menu.action(vehicle_troll, "变成小恐龙", {""}, "", function(on_click)
        give_car_addon(PlayerID, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
    end)
    
    menu.action(vehicle_troll, "将墙放在玩家面前", {}, "在玩家面前放置墙壁,半秒后删除", function ()
        local ped = PLAYER.GET_PLAYER_PED(PlayerID)
        local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
        local pheading = ENTITY.GET_ENTITY_HEADING(ped)
        local hash = 309416120
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
        local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
        ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
        fastNet(a1, PlayerID)
        local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
        ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
        fastNet(b1, PlayerID)
        util.yield(500)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(b1)
    end)
    
    menu.action(vehicle_troll, "将玩家传送到花园银行", {""}, "将玩家的车辆传送到花园银行的塔上", function()
        local ped = PLAYER.GET_PLAYER_PED(PlayerID)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(), pc.x, pc.y, pc.z + 10, false, false, false)
            util.yield(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                util.yield(100)
            end
            NOTIF("传送 " .. players.get_name(PlayerID) .. " 上去花园银行塔!")
        else
            NOTIF("玩家 " .. players.get_name(PlayerID) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
    end)
    
    menu.action(vehicle_troll, "将玩家传送到高空", {""}, "", function()
        local ped = PLAYER.GET_PLAYER_PED(PlayerID)
        local pc = ENTITY.GET_ENTITY_COORDS(ped)
        local oldcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        for o = 0, 10 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pc.x, pc.y, pc.z + 10, false, false, false)
            util.yield(50)
        end
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
            for a = 0, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -75, -818, 2400, false, false, false)
                util.yield(100)
            end
            NOTIF("传送 " .. players.get_name(PlayerID) .. " 上去高空!")
        else
            NOTIF("玩家 " .. players.get_name(PlayerID) .. " 不在车内!")
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
    end)
    local unlocked_lock = {"不上锁","上锁"}

    menu.textslider_stateful(vehicle_troll, "劫持车辆", {"hijack"}, "随机 NPC 劫持他们的车辆", unlocked_lock, function(hijackLevel)
        control_vehicle(PlayerID, function(vehicle)
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -2.0, 0.0, 0.1)
            ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 0)
            local ped = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true)
            TASK.TASK_ENTER_VEHICLE(ped, vehicle, -1, -1, 5.0, 16, 0)
            if hijackLevel == 1 then
                util.yield(20)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
            end
            for _ = 1, 20 do
                TASK.TASK_VEHICLE_DRIVE_WANDER(ped, vehicle, 100.0, 2883621)
                util.yield(50)
            end
        end)
    end)
    
    menu.toggle_loop(vehicle_troll, "随机升级", {}, "", function()
        control_vehicle(PlayerID, function(vehicle)
            VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
            for x = 0, 49 do
                local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
                VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
            end
            VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
            for x = 17, 22 do
                VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
            end
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(128, 255), math.random(128, 255), math.random(128, 255))
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(128, 255), math.random(128, 255), math.random(128, 255))
        end)
        util.yield(200)
    end)
    
    menu.toggle_loop(vehicle_troll, "让他以为自己能走", {""}, "假象", function ()
        local ped = PLAYER.GET_PLAYER_PED(PlayerID)
        if PED.IS_PED_IN_ANY_VEHICLE(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
            local oldcoords = ENTITY.GET_ENTITY_COORDS(ped)
            util.yield(500)
            local nowcoords = ENTITY.GET_ENTITY_COORDS(ped)
            for a = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
            util.yield(200)
            for b = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
            for c = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
            for d = 1, 10 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                util.yield()
            end
            ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
            util.yield(500)
        else
            NOTIF("玩家 " .. players.get_name(PlayerID) .. " 不在车内")
        end
    end)

    
    ----------CPU攻击---------- 

	fish_options = menu.list(cpu_burn, "CPU V1", {}, "")
	menu.divider(fish_options, "炸鱼")
    Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20

    menu.action(fish_options, "炸鱼", {""}, "卡死", function ()
        local targetped = PLAYER.GET_PLAYER_PED(PlayerID)
        local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)
        local hash = util.joaat("tug")
        STREAMING.REQUEST_MODEL(hash)
        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
        for i = 1, Ptools_FishPan do
            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, PlayerID, true)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
            Ptools_PanCount = Ptools_PanCount + 1
        end
    end)

    menu.slider(fish_options, "数量", {""}, "鱼的数量1-300", 1, 300, 20, 1, function(value)
        Ptools_FishPan = value
    end)

    menu.action(fish_options, "删除", {""}, "Yep", function ()
        for x = 1, 5, 1 do
            for i = 1, #Ptools_PanTable do
                entities.delete_by_handle(Ptools_PanTable[i])
                util.yield(10)
            end
        end
        Ptools_PanCount = 1
        Ptools_PanTable = {}
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))
    end)

    menu.action(cpu_burn,"CPU V2", {}, "CPU v2", function() 
        request_model(447548909)
		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
		NOTIF("开始干他")
		menu.trigger_commands("anticrashcamera on")
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 300
		while spam_amount >= 1 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 1
			util.yield(10)
		end
		NOTIF("干完") 
		menu.trigger_commands("anticrashcamera off")
		util.yield(5000)
	end)

    menu.toggle_loop(cpu_burn, "CPU V3", {}, "请远离该玩家", function()
		local player_pos = players.get_position(PlayerID)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_ch_finale")
       GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
			"scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        request_ptfx_asset("scr_ch_finale")
        while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			end
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 1000
		while spam_amount >= 2 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 2
		end
        util.yield(100)
	end)

    menu.action(cpu_burn, "DDoS", {}, "通过向其路由器发送数据包对玩家进行DDoS攻击", function()
        NOTIF("成功发送DDoS攻击到" ..players.get_name(PlayerID))
            local percent = 0
            while percent <= 100 do
                util.yield(100)
                NOTIF(percent.. "% done")
                percent = percent + 1
            end
            util.yield(3000)
            NOTIF("开个玩笑你个笨比")
        end)


end


players.on_join(Player_functions)

local PlayersList = players.list(true, true, true)
for i = 1, #PlayersList do
    Player_functions(PlayersList[i])
end