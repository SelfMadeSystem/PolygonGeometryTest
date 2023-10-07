class_name GeometryOperation

extends Resource

@export var type: int
@export var poly_a: PackedVector2Array
@export var op_a: GeometryOperation
@export var poly_b: PackedVector2Array
@export var op_b: GeometryOperation

func get_a() -> PackedVector2Array:
    if op_a != null:
        return op_a.build()
    return poly_a

func get_b() -> PackedVector2Array:
    if op_b != null:
        return op_b.build()
    return poly_b

static func build_static(op: int, poly_a: PackedVector2Array, poly_b: PackedVector2Array) -> Array[PackedVector2Array]:
    match op:
        Geometry2D.PolyBooleanOperation.OPERATION_UNION:
            return Geometry2D.merge_polygons(poly_a, poly_b)
        Geometry2D.PolyBooleanOperation.OPERATION_DIFFERENCE:
            return Geometry2D.clip_polygons(poly_a, poly_b)
        Geometry2D.PolyBooleanOperation.OPERATION_INTERSECTION:
            return Geometry2D.intersect_polygons(poly_a, poly_b)
        Geometry2D.PolyBooleanOperation.OPERATION_XOR:
            return Geometry2D.exclude_polygons(poly_a, poly_b)
        _:
            printerr("Invalid operation type.")
            return PackedVector2Array()

func build() -> PackedVector2Array:
    return GeometryOperation.build_static(type, get_a(), get_b())
