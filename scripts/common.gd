extends Node

var DataLayer_Shade = "shade"
var DataLayer_Shade_Light = "light"
var DataLayer_Shade_Dark = "dark"

var ChocolateEntityName_Light = "chocolate_light"
var ChocolateEntityName_Dark = "chocolate_dark"

var ChocolateColor_Light = "light"
var ChocolateColor_Dark = "dark"

enum PlayerState {
	IDLE, RUNNING, JUMPING, FALLING
}

enum GuardState {
	IDLE, WALKING, RETURNING, ALARMED, STUNNED
}
