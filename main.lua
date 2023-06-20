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

-- code for basic shapes using lovr.-- to be put inside lovr.draw():
-- -- local t = lovr.headset.getTime()
-- pass:text('Ana fine',2,-2,-5)
-- -- Plane
-- local x, y, z = -.6, 1.7, -1.5
-- pass:setColor(.53, .522, .52)
-- --color set
-- pass:plane(x, y, z, 1, 1)

-- using the rounded corner ui--> https://github.com/jmiskovic/chui



require 'mousearm'
UI = require "ui/ui"

local dashboard_transform = lovr.math.newMat4( vec3( 0, 1.5, -1 ) )

-- https://lovr.org/docs/v0.16.0/Pass:plane

function lovr.load()
	UI.Init(nil, nil, true, 0)
	lovr.graphics.setBackgroundColor( 0.4, 0.4, 1 )
end

function lovr.update(dt)
    UI.InputInfo()
end

function lovr.draw(pass)
    pass:setColor( .1, .1, .12 )
	pass:plane( 0, 0, 0, 25, 25, -math.pi / 2, 1, 0, 0 )
	pass:setColor( .2, .2, .2 )
	pass:plane( 0, 0, 0, 25, 25, -math.pi / 2, 1, 0, 0, 'line', 50, 50 )

    -- print("HARI 0")
    UI.NewFrame(pass)
    -- -- NOTE: Should be called on lovr.draw(). Windows and widgets should be called after this function, and a UI.RenderFrame(main_pass) finalizes the whole UI.
    -- print("HARI 1")
    UI.Begin("dashboard",dashboard_transform)
    -- --NOTE: Starts a new window. Every widget call after this function will belong to this window, until UI.End(main_pass) is called. If this is set as a modal window (by passing true to the last argument) it should always call UI.EndModalWindow before closing it physically. (see example in main.
    -- print("HARI 2")
    UI.ImageButton("monado_logo_no_bkg.png",64,64)
    -- print("HARI3")
    UI.SameLine()
    -- --NOTE: Places the next widget beside the last one, instead of bellow
    UI.Label(os.date())
    -- print("HARI4")
    UI.SameLine()
    -- print("HARI5")
    -- --contionusly we have to keep writing this.
    -- UI.Label("battery%ent goes here")
    -- -- UI.ProgressBar() may also be used instead
    -- print("HARI6")
    UI.Dummy(500,0)
    -- print("HARI 7")
    UI.SameLine()
    print("HARI 8")
    UI.ImageButton("monado_logo_no_bkg.png",64,64)
    -- print("HARI 9")
    UI.SameLine()
    -- print("HARI 10")
    UI.ImageButton("triple_dot (1).png",62,62)
    -- print("HARI 11")
    UI.End(pass)
    -- print("HARI 12")
    local ui_passes = UI.RenderFrame(pass)
    table.insert(ui_passes,pass)
    return lovr.graphics.submit(ui_passes)
end


    
