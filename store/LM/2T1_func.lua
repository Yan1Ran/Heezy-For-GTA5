
--[[
 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |    _____     | || |  _________   | || |      __      | || |  ___  ____   | || |  _________   | || |     __       | |
| |   / ___ `.   | || | |  _   _  |  | || |     /  \     | || | |_  ||_  _|  | || | |_   ___  |  | || |    /  |      | |
| |  |_/___) |   | || | |_/ | | \_|  | || |    / /\ \    | || |   | |_/ /    | || |   | |_  \_|  | || |    `| |      | |
| |   .'____.'   | || |     | |      | || |   / ____ \   | || |   |  __'.    | || |   |  _|  _   | || |     | |      | |
| |  / /____     | || |    _| |_     | || | _/ /    \ \_ | || |  _| |  \ \_  | || |  _| |___/ |  | || |    _| |_     | |
| |  |_______|   | || |   |_____|    | || ||____|  |____|| || | |____||____| | || | |_________|  | || |   |_____|    | |
| |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 
--]]

local split_2t1 = function (input, sep)
    local t={}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end


local v3_meta_2t1 = {
	__is_const = true,
	__sub=function (self, other)
		if type(other) == "table" then
			return v3(	self.x - other.x,
						self.y - other.y,
						self.z - (other.z or 0))
		elseif type(other) == "number" then
			return v3(	self.x - other,
						self.y - other,
						self.z - other)
		end
	end,
	__add=function (self, other)
		if type(other) == "table" then
			return v3(	self.x + other.x,
						self.y + other.y,
						self.z + (other.z or 0))
		elseif type(other) == "number" then
			return v3(	self.x + other,
						self.y + other,
						self.z + other)
		end
	end,
	__mul=function (self, other)
		if type(other) == "table" then
			return v3(	self.x * other.x,
						self.y * other.y,
						self.z * (other.z or 0))
		elseif type(other) == "number" then
			return v3(	self.x * other,
						self.y * other,
						self.z * other)
		end
	end,
	__div=function (self, other)
		if type(other) == "table" then
			return v3(	self.x / other.x,
						self.y / other.y,
						self.z / (other.z or 0))
		elseif type(other) == "number" then
			return v3(	self.x / other,
						self.y / other,
						self.z / other)
		end
	end,
	__eq=function (self, other)
		return self.x == other.x and self.y == other.y and self.z == other.z
	end,
	__lt=function (self, other)
		return self.x + self.y + self.z < other.x + other.y + other.z
	end,
	__le=function (self, other)
		return self.x + self.y + self.z <= other.x + other.y + other.z
	end,
	__tostring=function (self)
		return "x:"..self.x.." y:"..self.y.." z:"..self.z
	end,
}

v3_2t1 = function (x, y, z)
	x = x or 0.0
	y = y or 0.0
	z = z or 0.0
	local vec =
	{	x = x, y = y or x, z = z or x,

		magnitude = function (self, other)
			local end_vec = other and (self - other) or self
			return math.sqrt(end_vec.x^2 + end_vec.y^2 + end_vec.z^2)
		end,
		transformRotToDir = function(self, deg_z, deg_x)
			local rad_z = deg_z * math.pi / 180;
			local rad_x = deg_x * math.pi / 180;
			local num = math.abs(math.cos(rad_x));
			self.x = -math.sin(rad_z) * num
			self.y = math.cos(rad_z) * num
			self.z = math.sin(rad_x)
		end,
		degToRad = function (self)
			self.x = self.x * math.pi / 180
			self.y = self.y * math.pi / 180
			self.z = self.z * math.pi / 180
		end,
		radToDeg = function (self)
			self.x = self.x * 180 / math.pi
			self.y = self.y * 180 / math.pi
			self.z = self.z * 180 / math.pi
		end
	}
	setmetatable(vec, v3_meta)
	return vec
end
--------------------------
-- utils
--------------------------
get_all_files_in_directory_2t1 = function (path, extension)
    local files = filesystem.list_files(path)
    local result = {}
    for _, file in ipairs(files) do
        if filesystem.is_regular_file(file) then
             local split_file = split_2t1(file, ".")
            if #split_file > 1 and split_file[#split_file] == extension then
                local file_subs = split_2t1(file, "\\")
                result[#result+1] = file_subs[#file_subs]
            end
        end
    end
    return result
end

--------------------------
-- ped
--------------------------

--------------------------
-- entity
--------------------------
set_entity_coords_no_offset_2t1 = function (ent, pos)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, pos.x, pos.y, pos.z)
    return true
end

set_entity_rotation_2t1 = function (ent, rot)
	ENTITY.SET_ENTITY_ROTATION(ent, rot.x, rot.y, rot.z, 2, true)
end

attach_entity_to_entity_2t1 = function (subject,  target,  boneIndex,  offset,  rot,  softPinning,  collision,  isPed,  vertexIndex,  fixedRot)
	ENTITY.ATTACH_ENTITY_TO_ENTITY(subject, target, boneIndex, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, false,  softPinning, collision, isPed, vertexIndex, fixedRot)
	return true
end

set_entity_velocity_2t1 = function (ent, veh)
	ENTITY.SET_ENTITY_VELOCITY(ent, veh.x, veh.y, veh.z)
end
--------------------------
-- fire
--------------------------
add_explosion_2t1 = function (pos, type, isAudible, isInvis, fCamShake, owner)
	FIRE.ADD_EXPLOSION(pos.x, pos.y ,pos.z, type, isAudible, isInvis, fCamShake, owner)
end

--------------------------
-- graphics
--------------------------
start_networked_ptfx_non_looped_at_coord_2t1 = function (name, pos, rot, scale, xAxis, yAxis, zAxis)
	GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(name, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, scale, xAxis, yAxis, zAxis)
end
--------------------------
-- scripts
--------------------------

