@tool
class_name NodeGeometryBuilder

extends CollisionPolygon2D

@export var build_now = false:
    set(val):
        if val:
            polygon = build()

func build() -> PackedVector2Array:
    var children = get_children()

    if children.size() == 0:
        return []
    
    var points = PackedVector2Array()

    for child in children:
        var child_points = child.build()

        points = Geometry2D.merge_polygons(points, child_points)[0]
    
    return points
