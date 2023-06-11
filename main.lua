-- Starter code file for floating rectangle like shown in the lovr-ui
--**How to use:**
--  - Put the ui folder inside your project and require it: `UI = require "ui/ui"`
--  - Initialize the library by calling `UI.Init()` on `lovr.load()`
--  - Handle controller input by calling `UI.InputInfo()` on `lovr.update()`
    --x works like the usual axis. 
    --x positive brings right and negative brings left 

    --y works like the usual axis. 
    --y positive above and the negative one down

    --z axis positive increase the font size and 
    --z axis negative decreases the font size.
    
    --for all 
require 'mousearm'
UI = require "ui/ui"

function lovr.draw(pass)
    -- local t = lovr.headset.getTime()
    pass:text('Ana fine',2,-2,-5)
    -- Plane
    local x, y, z = -.6, 1.7, -1.5
    pass:setColor(.53, .522, .52)
    --color set
    pass:plane(x, y, z, 1, 1)
    
end

    
