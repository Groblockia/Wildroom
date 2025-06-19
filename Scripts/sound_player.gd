extends Node

@onready var audioPlayer = $AudioStreamPlayer3D

func _ready() -> void:
    pass

func playSound():
    audioPlayer.play()