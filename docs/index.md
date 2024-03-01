[SpatialHashing]: https://scottbea.github.io/SpatialHashing/api/SpatialHashing/

## Summary

Create Spaces (e.g. spatial hashes) by converting world positions to 12 octal characters and vice versa within a defined cubic size in studs. This size can be configured by using the SetBits() function to specificy the number of bits (k) used in the voxel size. The size in studs is given by n = 2**k.  The default size in bits is 2, so the default voxel size is Vector3(4, 4, 4). This library allows you to map multiple nearby world positions in space to the same hash to understand their proximity in time O(1). The main use for this library is to implement very high-speed geofencing and proximity detection features. For example, any given 3D bounds could be represented by 1 or more  spatial hashes which could be tracked in a table.

Creating a spatial hash is as simple as:

``` lua
-- Assuming we place SpatialHashing in ReplicatedStorage
local SpatialHashing = require(game:GetService("ReplicatedStorage").SpatialHashing)
local spatialHashing = SpatialHashing.new()
```

SpatialHashing take one optional argument: **bits**. This is for... 

!!! info
    Alert
    
More ...

!!! info
    Alert

Once constructed, you can use SpatialHashing for ...

