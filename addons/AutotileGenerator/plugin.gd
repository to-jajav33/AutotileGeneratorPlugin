tool
extends EditorPlugin


var autotileScene = preload("res://addons/AutotileGenerator/AutotileGenerator.tscn").instance();


func _enter_tree():
	get_editor_interface().get_editor_viewport().add_child(self.autotileScene);
	make_visible(false);
	pass

func _exit_tree():
	if (self.autotileScene):
		self.autotileScene.queue_free();
	pass

func handles(object):
	return true;

func has_main_screen():
	return true;

func get_plugin_name():
	return "Autotile Generator";

func get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")
