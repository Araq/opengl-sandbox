# Package

version       = "0.1.0"
author        = "Arne Döring"
description   = "nice way of handling render code"
license       = "MIT"
bin           = @["fancygl"]

skipDirs = @["examples"]

# Dependencies

requires @["nim >= 0.12.1", "sdl2 >= 1.1.0", "opengl >= 1.0", "glm >= 0.1.0", "arnelib >= 0.1.0"]

