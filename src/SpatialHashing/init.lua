local DEFAULT_BIT_SHIFT: number? = 2
local BinaryValues: {number} = {2048,1024,512,256,128,64,32,16,8,4,2,1}
local OctalToBits: {[string]: {number}} = {
	['0'] = {0,0,0},
	['1'] = {0,0,1},
	['2'] = {0,1,0},
	['3'] = {0,1,1},
	['4'] = {1,0,0},
	['5'] = {1,0,1},
	['6'] = {1,1,0},
	['7'] = {1,1,1}
}

local SpatialHashing = {
	bits = 0,
	minSize = 0,
	totalVoxelsX = 0,
	totalVoxelsY = 0,
	totalVoxelsZ = 0,
	offsetVoxelsX = 0,
	offsetVoxelsY = 0,
	offsetVoxelsZ = 0,
}

SpatialHashing.__index = SpatialHashing


-- CONSTRUCTORS
function SpatialHashing.new(bits: number?)
	local self = {}
	setmetatable(self, SpatialHashing)

	self.bits = bits or DEFAULT_BIT_SHIFT
	self.minSize = math.pow(2, self.bits)

	self.totalVoxelsX = math.pow(2, 10 + self.bits)
	self.totalVoxelsY = math.pow(2, 10 + self.bits)
	self.totalVoxelsZ = math.pow(2, 10 + self.bits)

	self.offsetVoxelsX = bit32.rshift(self.totalVoxelsX, 1)
	self.offsetVoxelsY = bit32.rshift(self.totalVoxelsY, 1)
	self.offsetVoxelsZ = bit32.rshift(self.totalVoxelsZ, 1)

	self.hashAreaSizes = {}
	for k = 1,12 do 
		local v = BinaryValues[k] * self.minSize 
		table.insert(self.hashAreaSizes, Vector3.new(v,v,v)) 
	end
	return self
end

function SpatialHashing:PositionToSpace(position: Vector3): string
	local px: number = bit32.rshift(position.X + self.offsetVoxelsX, self.bits)
	local py: number = bit32.rshift(position.Y + self.offsetVoxelsY, self.bits)
	local pz: number = bit32.rshift(position.Z + self.offsetVoxelsZ, self.bits)

	local key: {number} = {0,0,0,0,0,0,0,0,0,0,0,0}

	for i = 12,1,-1 do
		local v: number = BinaryValues[i]
		local c: string = nil
		if bit32.btest(py, v) then
			if bit32.btest(px, v) then
				if bit32.btest(pz, v) then
					c = '7'
				else
					c = '6'
				end
			else
				if bit32.btest(pz, v) then
					c = '5'
				else
					c = '4'
				end
			end
		else
			if bit32.btest(px, v) then
				if bit32.btest(pz, v) then
					c = '3'
				else
					c = '2'
				end
			else
				if bit32.btest(pz, v) then
					c = '1'
				else
					c = '0'
				end
			end
		end
		key[i] = c
	end
	local s: string = ''
	for i = 1,12 do
		s = s .. key[i]
	end
	return s
end

function SpatialHashing:SpaceToCoordinates(space: string): (number, number, number)
	local n: number = string.len(space)
	local x: number = 0
	local y: number = 0
	local z: number = 0
	for i = 1, n do	
		local ch: string = space:sub(i, i)
		local v: number = BinaryValues[i]
		local bits: {number} = OctalToBits[ch]
		if bits[1] == 1 then
			y = bit32.bor(y, v)
		end
		if bits[2] == 1 then
			x = bit32.bor(x, v)
		end
		if bits[3] == 1 then
			z = bit32.bor(z, v)
		end
	end
	x = bit32.lshift(x, self.bits) - self.offsetVoxelsX
	y = bit32.lshift(y, self.bits) - self.offsetVoxelsY
	z = bit32.lshift(z, self.bits) - self.offsetVoxelsZ
	return x, y, z
end

function SpatialHashing:SpaceToPosition(space: string): Vector3
	return Vector3.new(self:SpaceToCoordinates(space))
end

function SpatialHashing:SpaceToRegion3(space: string): Region3?
	local n: number = string.len(space)
	if n < 1 or n > 12 then return nil end

	local x: number = 0
	local y: number = 0
	local z: number = 0

	for i = 1, n do	
		local ch: string = space:sub(i, i)
		local v: number = BinaryValues[i]
		local bits: {number} = OctalToBits[ch]
		if bits[1] == 1 then
			y = bit32.bor(y, v)
		end
		if bits[2] == 1 then
			x = bit32.bor(x, v)
		end
		if bits[3] == 1 then
			z = bit32.bor(z, v)
		end
	end

	local size = self.hashAreaSizes[n]
	local x1: number = bit32.lshift(x, self.bits) - self.offsetVoxelsX
	local y1: number = bit32.lshift(y, self.bits) - self.offsetVoxelsY
	local z1: number = bit32.lshift(z, self.bits) - self.offsetVoxelsZ
	local lower: Vector3 = Vector3.new(x1, y1, z1)
	local upper: Vector3 = lower + size
	return Region3.new(lower, upper)
end

function SpatialHashing:GetChildSpaces(space: string): {string}
	local results: {string} = {}
	local n: number = string.len(space)
	if n < 12 then
		for ch, bits in pairs(OctalToBits) do
			table.insert(results, space .. ch)
		end
	end
	return results
end

function SpatialHashing:GetParentSpaces(space: string, levels: number?): {string}
	local results: {string} = {}
	local m: number = 12 - math.min(11, levels or 1)
	local n: number = string.len(space)
	if n > 0 and m <= 12 then
		for i = n-1, m, -1 do
			local p: string = space:sub(1, i)
			table.insert(results, p)
		end
	end
	return results
end

return SpatialHashing
