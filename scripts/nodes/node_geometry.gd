@tool
class_name NodeGeometry

extends CollisionShape2D

func get_local_poly_points() -> PackedVector2Array:
    if shape is ConvexPolygonShape2D:
        return shape.points
    elif shape is ConcavePolygonShape2D:
        var segments = shape.segments # PackedVector2Array, but in pairs
        var points: PackedVector2Array = []

        for i in range(0, segments.size()):
            if !points.has(segments[i]):
                points.append(segments[i])

        return points
    elif shape is CircleShape2D:
        var points: PackedVector2Array = []

        const segments = 32
        
        for i in range(0, segments):
            var angle = i * 2 * PI / segments
            points.append(Vector2(cos(angle), sin(angle)) * shape.radius)

        return points
    elif shape is RectangleShape2D:
        var points: PackedVector2Array = []

        var extents = shape.extents

        points.append(Vector2(-extents.x, -extents.y))
        points.append(Vector2(extents.x, -extents.y))
        points.append(Vector2(extents.x, extents.y))
        points.append(Vector2(-extents.x, extents.y))

        return points
    # elif shape is CapsuleShape2D:
        # TODO
    else:
        printerr("Unsupported shape type: " + str(shape))
        return PackedVector2Array()

func get_global_poly_points() -> PackedVector2Array:
    var points = get_local_poly_points()

    for i in range(0, points.size()):
        points.set(i, to_global(points[i]))

    return points

func build() -> PackedVector2Array:
    return get_global_poly_points()
