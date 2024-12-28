--------------------------
-- FILE
--------------------------
gConfig = {
    session = {
        remove_xipro = false,
        always_host = false,
        always_scripthost = false,
        best_host_token = false
    },
    next_chat = {
        next_chat_toggle = true,
        classification = true,
        tag_mode = 1,
        max_chat_len = 254,
        max_chats = 5,
        display_time = 5,
        chat_cooldown_ms = 1000,
        pos_x = 0.68,
        pos_y = 0.35,
        text_scale = 0.5,
        tag_scale = 0.4,
        uwuify = false,
        show_typing = true,
        wake_typing = true
    },
    crosshair = {
        x = 0.5,--0.49997,
        y = 0.48,--0.479
        scale = 1.0
    },
	host_queue = {
        toggle = false,
		x = 0.17, 
		y = 0.788,
        size = 0.4
	},
    tv = {
        x = 0.5,
        y = 0.18,
        size = 0.26
    },
    other = {
        playerbar = false,
        speedometer = false,
        timeos = false,
        show_script_name = false
	},
}
ini = {}
function ini.save(file, t)
	file = io.open(file, 'w')
	local contents = ""
	for section, s in pairsByKeys(t) do
		contents = contents .. string.format("[%s]\n", section)
		for key, value in pairs(s) do
			if string.len(key) == 1 then 
				key = string.upper(key)
			end
			contents = contents .. ('%s = %s\n'):format(key, tostring(value))
		end
		contents = contents .. '\n'
	end
	file:write(contents)
	file:close()
end

function ini.load(file)
	local instance = {}
	local section
	for line in io.lines(file) do
		local strg = line:match('^%[([^%]]+)%]$')
		if strg then
			section = strg
			instance[ section ] = instance[ section ] or {}
		end
		local key, value = line:match('^([%w_]+)%s*=%s*(.+)$')
		if key and value ~= nil then
			if string.len(key) == 1 then 
				key = string.lower(key)
			end
			if value == "true" then 
				value = true 
			elseif value == "false" then 
				value = false 
			elseif tonumber(value) then
				value = tonumber(value)
			end
			instance[ section ][ key ] = value
		end
	end
	return instance
end
--------------------------
-- 通知
--------------------------
b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.006 --长度往上
    self.notif_text_size = 0.5 --文本大小
    self.notif_title_size = 0.6 --题头大小
    self.notif_spacing = 0.015 --间隔
    self.notif_width = 0.15 --宽度
    self.notif_flash_duration = 1 --闪光持续时间
    self.notif_anim_speed = 1 --动画速度
    self.notif_banner_colour = {r = 1, g = 0.71, b = 0.75, a = 1}
    self.notif_flash_colour = {r = 1, g = 0.98, b = 0.80, a = 1}
    self.max_notifs = 10
    self.notif_banner_height = 0.002 --长度往下
    local split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    local cut_string_to_length = function(input, length, fontSize)
        input = split(input, " ")
        local output = {}
        local line = ""
        for i, word in ipairs(input) do
            if directx.get_text_size(line..word, fontSize) >= length then
                if directx.get_text_size(word, fontSize) > length then
                    while directx.get_text_size(word , fontSize) > length do
                        local word_lenght = string.len(word)
                        for x = 1, word_lenght, 1 do
                            if directx.get_text_size(line..string.sub(word ,1, x), fontSize) > length then
                                output[#output+1] = line..string.sub(word, 1, x - 1)
                                line = ""
                                word = string.sub(word, x, word_lenght)
                                break
                            end
                        end
                    end
                else
                    output[#output+1] =  line
                    line = ""
                end
            end
            if i == #input then
                output[#output+1] = line..word
            end
            line = line..word.." "
        end
        return table.concat(output, "\n")
    end

    local draw_notifs = function ()
        local aspect_16_9 = 1.777777777777778
        util.create_tick_handler(function ()
            local total_height = 0.2 --y轴
            local delta_time = MISC.GET_FRAME_TIME()
            for i = #active_notifs, 1, -1 do
                local notif = active_notifs[i]
                local notif_body_colour = notif.colour
                if notif.flashtimer > 0 then
                    notif_body_colour = self.notif_flash_colour
                    notif.flashtimer = notif.flashtimer - delta_time
                end
                if notif.current_y_pos == -10 then
                    notif.current_y_pos = total_height
                end
                notif.current_y_pos = lerp(notif.current_y_pos, total_height, 5 * delta_time * self.notif_anim_speed)
                if not notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 1, 10 * delta_time * self.notif_anim_speed)
                end
                --#region
                    directx.draw_rect(
                        0.16 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        (notif.text_height + notif.title_height + self.notif_padding * 2 * aspect_16_9) * notif.animation_state,
                        notif_body_colour
                    )
                    directx.draw_rect(
                        0.16 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        self.notif_banner_height * aspect_16_9 * notif.animation_state,
                        self.notif_banner_colour
                    )
                    directx.draw_text(
                        0.16 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos,
                        notif.title,
                        ALIGN_TOP_LEFT,
                        self.notif_title_size,
                        {r = 0.54 * notif.animation_state, g = 0.411 * notif.animation_state, b = 0.411 * notif.animation_state, a = 1 * notif.animation_state}
                    )
                    directx.draw_text(
                        0.16 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos + notif.title_height,
                        notif.text,
                        ALIGN_TOP_LEFT,
                        self.notif_text_size,
                        {r = 0 * notif.animation_state, g = 0 * notif.animation_state, b = 0 * notif.animation_state, a = 1 * notif.animation_state}
                    )

                total_height = total_height + ((notif.total_height + self.notif_padding * 2 + self.notif_spacing) * notif.animation_state)
                if notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 0, 10 * delta_time)
                    if notif.animation_state < 0.05 then
                        table.remove(active_notifs, i)
                    end
                elseif notif.duration < 0 then
                    notif.marked_for_deletetion = true
                end
                notif.duration = notif.duration - delta_time
            end
            return #active_notifs > 0
        end)
    end

    self.notify = function (title,text, duration, width, colour)
        title = cut_string_to_length(title, self.notif_width, self.notif_title_size)
        text = cut_string_to_length(text, self.notif_width, self.notif_text_size)
        local x, text_heigth = directx.get_text_size(text, self.notif_text_size)
        local xx, title_height = directx.get_text_size(title, self.notif_title_size)
        local hash = util.joaat(title..text)
        local new_notification = {
            title = title,
            flashtimer = self.notif_flash_duration,
            colour = colour or {r = 1, g = 0.98, b = 0.80, a = 1}, --框内颜色
            duration = duration or 3, --持续时间
            current_y_pos = -0.1, --从哪里生成
            marked_for_deletetion = false,
            animation_state = 0,
            text = text,
            hash = hash,
            text_height = text_heigth,
            title_height = title_height,
            total_height = title_height + text_heigth
        }
        for i, notif in ipairs(active_notifs) do
            if notif.hash == hash then
                notif.flashtimer = self.notif_flash_duration * 0.5
                notif.marked_for_deletetion = false
                notif.duration = duration or 3
                return
            end
        end
        active_notifs[#active_notifs+1] = new_notification
        if #active_notifs > self.max_notifs then
            table.remove(active_notifs, 1)
        end
        if #active_notifs == 1 then draw_notifs() end
    end

    return self
end

local notification = b_notifications.new()
function NOTIF(input, duration)
    notification.notify("Heezy二代目", input, duration)
end

--------------------------
-- EFFECT
--------------------------

Effect = {asset = "", name = ""}
Effect.__index = Effect

function Effect.new(asset, name)
	local inst = setmetatable({}, Effect) 
	inst.name = name
	inst.asset = asset
	return inst
end
--------------------------
-- SOUND
--------------------------
Sound = {Id = nil, name = "", reference = ""}
Sound.__index = Sound

function Sound.new(name, reference)
	local inst = setmetatable({}, Sound)
	inst.Id = -1
	inst.name = name
	inst.reference = reference
	return inst
end

function Sound:play()
	if self.Id == -1 then
        self.Id = AUDIO.GET_SOUND_ID()
        AUDIO.PLAY_SOUND_FRONTEND(self.Id, self.name, self.reference, true)
    end
end

function Sound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end

function Sound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end

function Sound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end

--------------------------
-- VECTOR
--------------------------

--------------------------
-- Timer
--------------------------

function newTimer()
	local self = {
		start = util.current_time_millis(),
		m_enabled = false,
	}

	local function reset()
		self.start = util.current_time_millis()
		self.m_enabled = true
	end

	local function elapsed()
		return util.current_time_millis() - self.start
	end

	local function disable() self.m_enabled = false end
	local function isEnabled() return self.m_enabled end

	return
	{
		isEnabled = isEnabled,
		reset = reset,
		elapsed = elapsed,
		disable = disable,
	}
end

--------------------------
-- ENTITY
--------------------------
function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end

function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

--将本地实体同步给玩家
function Set_Entity_Networked(ent, canMigrate)
    if ENTITY.DOES_ENTITY_EXIST(ent) then
        if canMigrate == nil then canMigrate = true end

        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(obj, true, 1)
        ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(ent, true)

        NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(ent)
        local net_id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(net_id, canMigrate)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(net_id, true)
        for _, player in pairs(players.list(true, true, true)) do
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(net_id, player, true)
        end
        return NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ent)
    end
    return false
end

vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
function mod_uses(type, incr)
        if type == "vehicle" then
            if vehicle_uses <= 0 and incr < 0 then
                return
            end
            vehicle_uses = vehicle_uses + incr
        elseif type == "pickup" then
            if pickup_uses <= 0 and incr < 0 then
                return
            end
            pickup_uses = pickup_uses + incr
        elseif type == "ped" then
            if ped_uses <= 0 and incr < 0 then
                return
            end
            ped_uses = ped_uses + incr
        elseif type == "player" then
            if player_uses <= 0 and incr < 0 then
                return
            end
            player_uses = player_uses + incr
        elseif type == "object" then
            if object_uses <= 0 and incr < 0 then
                return
            end
            object_uses = object_uses + incr
        end
    end

function setBit(bitfield, bitNum)
	return (bitfield | (1 << bitNum))
end

function clearBit(bitfield, bitNum)
	return (bitfield & ~(1 << bitNum))
end

function set_explosion_proof(entity, value)
	local pEntity = entities.handle_to_pointer(entity)
	if pEntity == 0 then return end
	local damageBits = memory.read_uint(pEntity + 0x0188)
	damageBits = value and setBit(damageBits, 11) or clearBit(damageBits, 11)
	memory.write_uint(pEntity + 0x0188, damageBits)
end

local draw_line = function (start, to, colour)
	GRAPHICS.DRAW_LINE(start.x, start.y, start.z, to.x, to.y, to.z, colour.r, colour.g, colour.b, colour.a)
end

local draw_rect = function (pos0, pos1, pos2, pos3, colour)
	GRAPHICS.DRAW_POLY(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z, pos3.x, pos3.y, pos3.z, colour.r, colour.g, colour.b, colour.a)
	GRAPHICS.DRAW_POLY(pos3.x, pos3.y, pos3.z, pos2.x, pos2.y, pos2.z, pos0.x, pos0.y, pos0.z, colour.r, colour.g, colour.b, colour.a)
end

function draw_bounding_box(entity, showPoly, colour)
	if not ENTITY.DOES_ENTITY_EXIST(entity) then
		return
	end
	colour = colour or {r = 255, g = 0, b = 0, a = 255}
	local min = v3.new()
	local max = v3.new()
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), min, max)
	min:abs(); max:abs()

	local upperLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, max.z)
	local upperRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, max.z)
	local lowerLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, -min.z)
	local lowerRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, -min.z)

	draw_line(upperLeftRear, upperRightRear, colour)
	draw_line(lowerLeftRear, lowerRightRear, colour)
	draw_line(upperLeftRear, lowerLeftRear, colour)
	draw_line(upperRightRear, lowerRightRear, colour)

	local upperLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, max.z)
	local upperRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, max.z)
	local lowerLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, -min.z)
	local lowerRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, -min.z)

	draw_line(upperLeftFront, upperRightFront, colour)
	draw_line(lowerLeftFront, lowerRightFront, colour)
	draw_line(upperLeftFront, lowerLeftFront, colour)
	draw_line(upperRightFront, lowerRightFront, colour)

	draw_line(upperLeftRear, upperLeftFront, colour)
	draw_line(upperRightRear, upperRightFront, colour)
	draw_line(lowerLeftRear, lowerLeftFront, colour)
	draw_line(lowerRightRear, lowerRightFront, colour)

	if type(showPoly) ~= "boolean" or showPoly then
		draw_rect(lowerLeftRear, upperLeftRear, lowerLeftFront, upperLeftFront, colour)
		draw_rect(upperRightRear, lowerRightRear, upperRightFront, lowerRightFront, colour)

		draw_rect(lowerLeftFront, upperLeftFront, lowerRightFront, upperRightFront, colour)
		draw_rect(upperLeftRear, lowerLeftRear, upperRightRear, lowerRightRear, colour)

		draw_rect(upperRightRear, upperRightFront, upperLeftRear, upperLeftFront, colour)
		draw_rect(lowerRightFront, lowerRightRear, lowerLeftFront, lowerLeftRear, colour)
	end
end

function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min = memory.read_vector3(minptr)
    max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])
    memory.free(minptr)
    memory.free(maxptr)
    return size
end


function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)
    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        NOTIF("玩家距离太远")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end
    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end

function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        NOTIF("玩家不在车内或不在范围内.")
    end
end

function fastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                util.yield(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    NOTIF("有控制权.")
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    util.yield(10)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, false)
    util.yield(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    util.yield(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        util.yield()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        util.yield()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end

--------------------------
-- CAM
--------------------------
function get_offset_from_cam(dist)
	local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
	local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local dir = rot:toDir()
	dir:mul(dist)
	local offset = v3.new(pos)
	offset:add(dir)
	return offset
end

function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = v3(direction)
    destination:mul(distance)
    destination:add(cam_pos)

    return destination
end

function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end

local ent_types = {"无", "Ped", "车辆", "物体"}
function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
end

thrust_cam_dir_add = 1.25
before_vel = {x = 1, y = 1, z = 1}
function cam_direction()
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    local inst = v3.new()
    v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local tmp = v3.toDir(inst)
    v3.set(inst, v3.get(tmp))
    v3.mul(inst, 10)
    v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
    v3.add(inst, tmp)
    local aim_pos = inst
    local car_pos = ENTITY.GET_ENTITY_COORDS(player_cur_car)
    local c = {}
    c.x = before_vel.x+thrust_cam_dir_add + (aim_pos.x - car_pos.x)
    c.y = before_vel.y+thrust_cam_dir_add + (aim_pos.y - car_pos.y)
    ENTITY.SET_ENTITY_VELOCITY(player_cur_car, c.x, c.y, -0.002)
end

--------------------------
-- RAYCAST
--------------------------
TraceFlag =
{
	everything = 4294967295,
	none = 0,
	world = 1,
	vehicles = 2,
	pedsSimpleCollision = 4,
	peds = 8,
	objects = 16,
	water = 32,
	foliage = 256,
}

function getRaycastResult(dist, flag)
	local result = {}
	flag = flag or TraceFlag.everything
	local didHit 		= memory.alloc(8)
	local endCoords 	= v3.new()
	local surfaceNormal = v3.new()
	local hitEntity 	= memory.alloc_int()
	local origin 		= CAM.GET_FINAL_RENDERED_CAM_COORD()
	local destination 	= get_offset_from_cam(dist)

	SHAPETEST.GET_SHAPE_TEST_RESULT(
		SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
			origin.x, 
			origin.y, 
			origin.z, 
			destination.x,
			destination.y,
			destination.z,
			flag,
			PLAYER.PLAYER_PED_ID(), -- the shape test ignores the local ped 
			1
		), didHit, endCoords, surfaceNormal, hitEntity
	)
	result.didHit 			= toBool(memory.read_byte(didHit))
	result.endCoords 		= vect.new(v3.get(endCoords))
	result.surfaceNormal 	= vect.new(v3.get(surfaceNormal))
	result.hitEntity 		= memory.read_int(hitEntity)

	memory.free(didHit)
	v3.free(endCoords)
	v3.free(surfaceNormal)
	memory.free(hitEntity)
	return result
end

function get_raycast_result(dist, flag)
	local result = {}
	flag = flag or TraceFlag.everything
	local didHit = memory.alloc(1)
	local endCoords = v3.new()
	local normal = v3.new()
	local hitEntity = memory.alloc_int()
	local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local offset = get_offset_from_cam(dist)

	local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
		camPos.x, camPos.y, camPos.z,
		offset.x, offset.y, offset.z,
		flag,
		players.user_ped(), 7
	)
	SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, endCoords, normal, hitEntity)

	result.didHit = memory.read_byte(didHit) ~= 0
	result.endCoords = endCoords
	result.surfaceNormal = normal
	result.hitEntity = memory.read_int(hitEntity)
	return result
end

--------------------------
-- STREAMING
--------------------------

function request_weapon_asset(hash)
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do util.yield_once() end
end

function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function request_model(model)
	if STREAMING.IS_MODEL_VALID(model) and not STREAMING.HAS_MODEL_LOADED(model) then
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			util.yield()
		end
	end
end

function remove_ptfx_asset(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end

function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end

function request_scaleform_movie(scaleform)
    while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) do
        GRAPHICS.REQUEST_SCALEFORM_MOVIE(scaleform)
        util.yield()
    end
end

function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end

function request_control_once(entity)
	if not NETWORK.NETWORK_IS_IN_SESSION() then
		return true
	end
	local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end

function request_control(entity, timeOut)
	if not ENTITY.DOES_ENTITY_EXIST(entity) then
		return false
	end
	timeOut = timeOut or 500
	local start = newTimer()
	while not request_control_once(entity) and start.elapsed() < timeOut do
		util.yield_once()
	end
	return start.elapsed() < timeOut
end

--------------------------
-- MEMORY
--------------------------
write_global = {
	byte = function(global, value)
		local address = memory.script_global(global)
		memory.write_byte(address, value)
	end,
	int = function(global, value)
		local address = memory.script_global(global)
		memory.write_int(address, value)
	end,
	float = function(global, value)
		local address = memory.script_global(global)
		memory.write_float(address, value)
	end
}


read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return memory.read_byte(address)
	end,
	int = function(global)
		local address = memory.script_global(global)
		return memory.read_int(address)
	end,
	float = function(global)
		local address = memory.script_global(global)
		return memory.read_float(address)
	end,
	string = function(global)
		local address = memory.script_global(global)
		return memory.read_string(address)
	end
}

--------------------------
-- MISC
--------------------------


function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end

function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2

    if res[1] != 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end

    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end

function draw_string(s, x, y, scale, font)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.SET_TEXT_FONT(font or 0)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(s)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end

function rainbow_color()
    local mcxh=1
    local mcr=255
    local mcg=0
    local mcb=0
    if mcxh==1 and mcg<256 then
        HUD.SET_TEXT_COLOUR(mcr, mcg, mcb, 255)	
        if mcg == 255 then
            mcxh=2
        else
            mcg=mcg+1
        end
    elseif mcxh==2 and mcr>-1 then
        HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
        if mcr == 0 then
            mcxh=3
        else
            mcr=mcr-1
        end
    elseif mcxh==3 and mcb<256 then
        HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
        if mcb == 255 then
            mcxh=4
        else
            mcb=mcb+1
        end    
    elseif mcxh==4 and mcg>-1 then
        HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
        if mcg == 0 then
            mcxh=5
        else
            mcg=mcg-1
        end
    elseif mcxh==5 and mcr<256 then
        HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
        if mcr == 255 then
            mcxh=6
        else
            mcr=mcr+1
        end
    elseif mcxh==6 and mcb>-1 then
        HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)
        if mcb == 0 then
            mcxh=1
        else
            mcb=mcb-1
        end
    end
end

function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end

function executeLittle_Boy(pos)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y, pos.z, 29, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y+10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y+10, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y-10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y-10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y-10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y+10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+20, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y+20, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+20, pos.y+20, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-20, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y-20, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-20, pos.y-20, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+20, pos.y-20, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-20, pos.y+20, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y+30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y+30, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-30, pos.y, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y-30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-30, pos.y-30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y-30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-30, pos.y+30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y+30, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y+10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-30, pos.y-10, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y-30, pos.z, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-30, pos.y+10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y-30-10, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y-30, pos.z , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+30, pos.y-30, pos.z , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z-10 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y+10, pos.z-10 , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y+10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y+10, pos.z-10, 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+5, 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+10 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+15 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+20 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+25 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+30 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+35 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+40 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+45 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+50 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+55 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+57 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+75 , 59, 5000, true, false, 1.0, false)
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    start_networked_ptfx_non_looped_at_coord_2t1("scr_xm_orbital_blast", pos, v3_2t1(0, 180, 0), 4.5, true, true, true)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
        STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
        util.yield()
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y+10, pos.z-10 , 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y+10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x+10, pos.y-10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x-10, pos.y+10, pos.z-10, 59, 5000, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z+50 , 59, 5000, true, false, 1.0, false)
end

--------------------------
-- PLAYER
--------------------------
function BlockSyncs(pid, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    util.yield(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true)
    end
end