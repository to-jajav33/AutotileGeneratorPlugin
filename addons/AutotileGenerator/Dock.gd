tool
extends Control


signal signal_file_selected(path)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$VBoxContainer/Button.hide();
	$VBoxContainer/FileDialog.show();
	print("Show Dialog", $VBoxContainer/FileDialog.visible);
	pass # Replace with function body.


func _on_FileDialog_dir_selected(path):
	$VBoxContainer/Button.show();
	$VBoxContainer/FileDialog.hide();
	emit_signal("signal_file_selected", path + 'tileImage.png');
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	$VBoxContainer/Button.show();
	$VBoxContainer/FileDialog.hide();
	emit_signal("signal_file_selected", path + '.png');
	pass # Replace with function body.


func _on_FileDialog_hide():
	$VBoxContainer/Button.show();
	pass # Replace with function body.
