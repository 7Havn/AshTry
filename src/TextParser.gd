class_name TextParser

var InstructionS = load("res://src/InstructionSet.gd")
var object = null

# Parse input string to instruction.
func parse(text):
	# Convert the input text to lowercase
	var lowerText = text.to_lower()

	# Check commands - return instruction from InstructionSet.gd
	if lowerText == 'start':
		return InstructionS.START
	if lowerText in ['go north', 'north']:
		return InstructionS.NORTH
	elif lowerText in ['go south', 'south']:
		return InstructionS.SOUTH
	elif lowerText in ['go east', 'east']:
		return InstructionS.EAST
	elif lowerText in ['go west', 'west']:
		return InstructionS.WEST

	elif lowerText in ['look around', 'look']:
		return InstructionS.LOOK
	elif lowerText in ['help', 'help me']:
		return InstructionS.HELP

	elif lowerText == 'reset game':
		return InstructionS.RESET
	elif lowerText in ['quit', 'exit']:
		return InstructionS.QUIT

	# If "get" used then extract the object
	if lowerText.begins_with('get '):
		var regex = RegEx.new()
		regex.compile("get\\s(?<object>.*(\\s.*)?)")
		var results = regex.search(text.to_lower())
		object = results.get_string('object')
		return InstructionS.GET

	# If "open" command then extract the object
	if lowerText.begins_with('open '):
		var regex = RegEx.new()
		regex.compile("open\\s(?<object>.*(\\s.*)?)")
		var results = regex.search(text.to_lower())
		object = results.get_string('object')
		return InstructionS.OPEN

	# If "close" used then extract the object using
	if lowerText.begins_with('close '):
		var regex = RegEx.new()
		regex.compile("close\\s(?<object>.*(\\s.*)?)")
		var results = regex.search(text.to_lower())
		object = results.get_string('object')
		return InstructionS.CLOSE

	# Return NOT_FOUND from InstructionSet if comment non-existent
	return InstructionS.NOT_FOUND

# Function to get the parsed object
func get_object():
	return object
