## Construtors

#### new
```lua
local spatialHashing = SpatialHashing.new(container)
```
This is a summary of the class. 

----



## Methods

----
#### PositionToSpace(position: Vector3): string
```lua
local space = spatialHashing:PositionToSpace(position)
```

----
#### SpaceToCoordinates(space: string): (number, number, number)
```lua
local x, y, z = spatialHashing:SpaceToCoordinates(space)
```

----
#### SpaceToPosition(space: string): Vector3
```lua
local position = spatialHashing:SpaceToPosition(space)
```

----
#### SpaceToRegion3(space: string): Region3?
```lua
local region = spatialHashing:SpaceToRegion3(space)
```

----
#### GetChildSpaces(space: string): {string}
```lua
local childSpacesArray = spatialHashing:GetChildSpaces(space)
```

----
#### GetParentSpaces(space: string, levels: number?): {string}
```lua
local parentSpacesArray = spatialHashing:GetParentSpaces(space, 12)
```

