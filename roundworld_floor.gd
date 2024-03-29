@tool

extends StaticBody2D

'''@export var inner: Shape2D:
	set(shape):
		inner = shape
		update_shapes()

@export var outer: Shape2D:
	set(shape):
		outer = shape
		update_shapes()

func update_shapes():
	print("Updating shapes")
	if not Engine.is_editor_hint():
		return
	$CollisionPolygon2D.polygon = Geometry2D.clip_polygons(outer, inner)
'''

@export var inner_radius = 750:
	set(value):
		print("updated inner")
		inner_radius = value
		update_area()

@export var outer_radius = 800:
	set(value):
		outer_radius = value
		update_area()

var segments = 20

func update_area():
	for child in get_children():
		child.queue_free()
	print("Updating area...")
	var median_radius = lerp(inner_radius, outer_radius, 0.5)
	var segment_width = 2 * PI * outer_radius / segments
	var segment_height = outer_radius - inner_radius
	for i in range(segments):
		var rect = RectangleShape2D.new()
		rect.size = Vector2(segment_width, segment_height)
		var segment = CollisionShape2D.new()
		segment.rotation = i * 2 * PI / segments
		segment.shape = rect
		segment.position = Vector2(0, median_radius).rotated(i * 2 * PI / segments)
		add_child(segment)
		print("Added segment " + str(i))
		print(segment)
