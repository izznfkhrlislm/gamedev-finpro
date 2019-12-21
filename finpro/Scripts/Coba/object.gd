extends Node2D

enum CELL_TYPES{ EMPTY = -1, WALL, LAVA, PATH}
export (CELL_TYPES) var type = CELL_TYPES.EMPTY