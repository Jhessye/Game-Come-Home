# inventory_ui.gd (SIMPLIFICADO)
extends CanvasLayer
# No seu inventory_ui.gd, adicione:
func _ready():
	print("DEBUG: CanvasLayer do inventário INICIADO")
	
	# 🔥🔥🔥 DESATIVE COMPLETAMENTE 🔥🔥🔥
	self.visible = false  # Esconde tudo
	# OU
	self.process_mode = Node.PROCESS_MODE_DISABLED  # Desativa completamente
	
	# Se quiser manter só os slots visíveis:
	# for child in get_children():
	#     if child is Control:
	#         child.visible = true
	#     else:
	#         child.visible = false
