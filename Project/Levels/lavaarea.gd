extends Area2D

func onready():
	$RichTextLabel.hide()
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		print('hello')
		$RichTextLabel.show()
		
