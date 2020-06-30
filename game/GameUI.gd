# OpenTabletop
# Copyright (c) 2020 drwhut
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends Control

signal piece_requested(path)

onready var _objectsDialog = $ObjectsDialog
onready var _objectsTree = $ObjectsDialog/ObjectsTree

var _d6_node: TreeItem = null

func add_d6(name, path):
	var node = _objectsTree.create_item(_d6_node)
	node.set_text(0, name)
	node.set_metadata(0, path)

func _ready():
	var root = _objectsTree.create_item()
	_objectsTree.set_hide_root(true)
	
	var ott_node = _objectsTree.create_item(root)
	ott_node.set_text(0, "OpenTabletop")
	
	var dice_node = _objectsTree.create_item(ott_node)
	dice_node.set_text(0, "Dice")
	
	_d6_node = _objectsTree.create_item(dice_node)
	_d6_node.set_text(0, "D6")

func _on_ObjectsButton_pressed():
	_objectsDialog.popup_centered()

func _on_ObjectsTree_item_activated():
	var selected = _objectsTree.get_selected()
	
	# Check the selected item has metadata.
	if selected.get_metadata(0):
		emit_signal("piece_requested", selected.get_metadata(0))