@tool
class_name NodeGeometryOperation

extends Node2D

@export var op: Geometry2D.PolyBooleanOperation = Geometry2D.PolyBooleanOperation.OPERATION_UNION

func build() -> PackedVector2Array:
    var children = get_children()
    
    if children.size() == 0:
        return []

    if children.size() == 1:
        return children[0].build()
    
    if children.size() > 2:
        printerr("NodeGeometryOperation can only have 2 children")
        return []
    
    var a = children[0].build()
    var b = children[1].build()
    
    return GeometryOperation.build_static(op, a, b)[0] # always assume no holes
