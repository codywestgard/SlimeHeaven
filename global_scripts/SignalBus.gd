extends Node

## UI stuff
signal item_selected(item)
signal weapon_selected(weapon)

## UI to game
signal weapon_equipped(data, slot_number)

#
signal choice_made(data)



## Game signals
signal combat_start
signal combat_end
signal pause_request
signal unpause_request
