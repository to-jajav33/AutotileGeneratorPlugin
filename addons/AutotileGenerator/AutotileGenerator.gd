tool

extends Control


# Declare member variables here. Examples:
const ORIG_TILE_SIZES = {
	FLOOR = Vector2(64, 64),
	WALLS = Vector2(64, 64),
	THICK_WALLS = Vector2(64, 88),
	TALL_WALLS = Vector2(64, 184)
};
const ROWS = 4;
const COLS = 12;

var _mapType = "FLOOR";
export (String, "FLOOR", "WALLS", "THICK_WALLS", "TALL_WALLS") var mapType = _mapType setget _set_mapType,_get_mapType;
export (Vector2) var tileSize = ORIG_TILE_SIZES[mapType] setget _set_tile_size,_get_tile_size;
export (float, 0.0, 1.0, 0.001) var templateAlpha = 0.25 setget _set_templateAlpha, _get_templateAlpha;



# Called when the node enters the scene tree for the first time.
func _ready():
	$Dock.visible = not Engine.editor_hint;
	print(Engine.editor_hint);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _get_mapType():
	return self._mapType;
func _set_mapType(val):
	if (self.is_inside_tree() == false):
		return;
	self._mapType = val;
	var TEMPLATES = {
		TALL_WALLS = self.get_node("templates/tallWalls_tiles64w184h_offset0x-120y"),
		THICK_WALLS = $templates/topDownThickWalls_tiles64w88h,
		WALLS = $templates/topDownWalls_tiles64w64h,
		FLOOR = $templates/topDownFloor_tiles64w64h
	};
	
	for templatename in TEMPLATES:
		if (templatename == val):
			TEMPLATES[templatename].show();
		else:
			TEMPLATES[templatename].hide();
	return;

func _get_templateAlpha():
	if (self.is_inside_tree() == false):
		return 0.7;
	return $templates.modulate.a;
func _set_templateAlpha(val):
	if (self.is_inside_tree() == false):
		return;
	
	$templates.modulate.a = val;
	return;

func _get_tile_size():
	var currCanvasSize = self.rect_size;
	if (self.is_inside_tree() == false || !currCanvasSize):
		return ORIG_TILE_SIZES.FLOOR;
	
	return Vector2(currCanvasSize.x / self.COLS, currCanvasSize.y / self.ROWS);
func _set_tile_size(val : Vector2):
	if (self.is_inside_tree() == false || !self.ORIG_TILE_SIZES.get(mapType) || !self.has_node("ViewportContainer/Viewport2/Camera2D") || !self.get_node("ViewportContainer/Viewport2/Camera2D")):
		return;
	
	var origtileSize = self.ORIG_TILE_SIZES.get(mapType, self.ORIG_TILE_SIZES.FLOOR);
	val.x = origtileSize.x if val.x == 0 else val.x;
	val.y = origtileSize.y if val.y == 0 else val.y;
	
	var vectorScale = val / origtileSize;
	self.rect_size = Vector2(val.x * self.COLS, val.y * self.ROWS);
	self.get_node("ViewportContainer/Viewport2/Camera2D").offset.x = self.rect_size.x * 0.5;
	self.get_node("ViewportContainer/Viewport2/Camera2D").offset.y = self.rect_size.y * 0.5;
	$templates.scale = vectorScale;
	return;


func on_FileDialog_dir_selected(dir : String):
	if (self.is_inside_tree()):
		return;
	
	var texture = $ViewportContainer/Viewport2.get_texture();
	var img = texture.get_data();
	img.flip_y();
	
	if (dir.empty()):
		return;
	
	img.save_png(dir)
	pass # Replace with function body.


func _on_Dock_signal_file_selected(path):
	if (self.is_inside_tree() == false):
		return;
	
	self.on_FileDialog_dir_selected(path);
	pass # Replace with function body.
