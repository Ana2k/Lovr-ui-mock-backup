require 'example'
-- also does not work if the headset is set to false.

-- this only works if the monado-service is running else gives an error
-- and if i run the monado-service the visual elements are non accesible.

-- require 'mousearm'
--> Yes we cant use this with the example lua.
--> not sure why but some things dont align.
--?

-- advise from the team to 

-- something about not needing a mousearm possibly.
-- so for now removing this. and focusing on getting example.lua functionality working.

-- duality --> either example.lua works or mousearm.lua works.
-- both not working together??
-- then how do we get the example.lua to work inside our dashboard?
-- and display the results?
-- lets start by printing all the client values that example.lua is capable of 
-- inside the terminal.

UI = require "ui/ui"

local ffi = require("ffi")

-- Checking all the commands from example.lua
print("Client Count EXAMPLES LUA",get_client_count())
print("Example lua for loop prints all of the needed attributes.")
local client_count = get_client_count()

-- Now how to show them on the screen?
-- And what about the weird floating screen with our dashboard?

-- >> show this in text inside our UI dashboard.
-->> first run the app to understand how to put a textbox under the current codes.
-- how? 
-- print("Client id access:",get_client_id_at_index(0))

local dashboard_transform = lovr.math.newMat4( vec3( 0, 1.5, -1 ) )
-- Maybe we will need to alter these values a bit? Check this out later. 

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
    -- --NOTE: Starts a new window. Every widget call after this function will belong to this window, until UI.End(main_pass) is called. 
    -- If this is set as a modal window (by passing true to the last argument) it should always call UI.EndModalWindow before closing it physically. (see example in main.
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
    -- print("HARI 8")
    UI.ImageButton("VR_3D.png",64,64)
    -- print("HARI 9")
    UI.SameLine()
    
    -- UI.Label("Client Count"...client_count)
    UI.SameLine()
    -- print("HARI 10")
    UI.ImageButton("triple_dot (1).png",62,62)
    -- UI.
    -- print("HARI 11")
    UI.End(pass)
    -- print("HARI 12")
    local ui_passes = UI.RenderFrame(pass)
    table.insert(ui_passes,pass)
    return lovr.graphics.submit(ui_passes)
end


    
