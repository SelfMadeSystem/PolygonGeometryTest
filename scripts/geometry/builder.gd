class_name GeometryBuilder

extends Resource

@export var operations: Array[GeometryOperation]

func build() -> PackedVector2Array:
    var vertices: Array[PackedVector2Array] = []

    if operations.size() == 0:
        return PackedVector2Array()

    for operation in operations:
        vertices.append(operation.build())
    
    var result: PackedVector2Array = vertices[0]

    for i in range(1, vertices.size()):
        result = Geometry2D.merge_polygons(result, vertices[i])
    
    return result
