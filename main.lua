require 'example'

UI = require "ui/ui"

local ffi = require("ffi")

local status, lib = pcall(ffi.load, "libmonado.so")

local dashboard_transform = lovr.math.newMat4( vec3( 0, 1.5, -1 ) )
    
function lovr.load()
	UI.Init(nil, nil, true, 0)
	lovr.graphics.setBackgroundColor( 0.4, 0.4, 1 )
end

function if_checker(bool_check,img_true,img_false)
    if(bool_check=="true")
    then
        UI.ImageButton(img_true,64,64)
        UI.SameLine()
        UI.Dummy(50,0)
        UI.SameLine()
    else
        UI.ImageButton(img_false,64,64)
        UI.SameLine()
        UI.Dummy(50,0)
        UI.SameLine()
    end
end


function lovr.update(dt)
    UI.InputInfo()
    
end

function lovr.draw(pass)
    pass:setColor( .1, .1, .12 )
	pass:plane( 0, 0, 0, 25, 25, -math.pi / 2, 1, 0, 0 )
	pass:setColor( .2, .2, .2 )
	pass:plane( 0, 0, 0, 25, 25, -math.pi / 2, 1, 0, 0, 'line', 50, 50 )

    local client_count = get_client_count()
    
    UI.NewFrame(pass)
    -- -- NOTE: Should be called on lovr.draw(). Windows and widgets should be called after this function, and a UI.RenderFrame(main_pass) finalizes the whole UI.
    UI.Begin("dashboard",dashboard_transform)
    -- --NOTE: Starts a new window. Every widget call after this function will belong to this window, until UI.End(main_pass) is called. If this is set as a modal window (by passing true to the last argument) it should always call UI.EndModalWindow before closing it physically. (see example in main.
    UI.ImageButton("png_assets/monado_logo_no_bkg.png",64,64)
    UI.SameLine()
    -- --WHY ADD DUMMY HEIGHT?
    -- UI.Dummy(0,245)

    -- UI.SameLine()
    UI.ImageButton("png_assets/VR_3D.png",64,64)
    UI.SameLine()
    -- --NOTE: Places the next widget beside the last one, instead of bellow
    UI.Label("Client count : "..client_count)
    UI.SameLine()
    UI.Dummy(500,0)
    
    UI.SameLine()
    UI.ImageButton("png_assets/monado_logo_no_bkg.png",64,64)

    local client = get_client_count()

    -- THE HEADINGS
    UI.Dummy(200,0)
    UI.SameLine()
    UI.Label("primary ")
    UI.SameLine()
    UI.Label("focused ")
    UI.SameLine()
    UI.Label("  io  ")
    UI.SameLine()
    UI.Label("visible ")
    UI.SameLine()
    UI.Label("overlay ")
    UI.Separator()

    for i = 0, get_client_count() - 1 do
        local client_id = get_client_id_at_index(i)
        local name = get_client_name(client_id)
        local flags = get_client_flags(client_id)
        local bool_primary = tostring(bit.band(flags, lib.MND_CLIENT_PRIMARY_APP) ~= 0)
        local bool_focused = tostring(bit.band(flags, lib.MND_CLIENT_SESSION_FOCUSED) ~= 0)
        local bool_io_active = tostring(bit.band(flags, lib.MND_CLIENT_IO_ACTIVE) ~= 0)        
        local bool_visible = tostring(bit.band(flags, lib.MND_CLIENT_SESSION_VISIBLE) ~= 0)
        local bool_overlay = tostring(bit.band(flags, lib.MND_CLIENT_SESSION_OVERLAY) ~= 0)
        local bool_active = tostring(bit.band(flags, lib.MND_CLIENT_SESSION_ACTIVE) ~= 0)

        local name_str = ffi.string(name)
        UI.Label(""..name_str)
        local len_name = string.len(name_str)
        
        UI.SameLine()
        -- UI.Dummy(width, height)
        local space = 200-len_name
        
        UI.Dummy(space,0)
        UI.SameLine()

        --PRIMARY
        if_checker(bool_primary,"png_assets/primary_selected.png","png_assets/primary_unselected.png")

        --FOCUSSED
        if_checker(bool_focused,"png_assets/focused_selected.png","png_assets/focused_unselected.png")

        --IO
        if_checker(bool_io_active,"png_assets/io_selected.png","png_assets/io_unselected.png")

        --VISIBLE
        if_checker(bool_visible,"png_assets/visibilty_selected.png","png_assets/visibility_unselected.png")

        --OVERLAY
        if_checker(bool_overlay,"png_assets/overlay_selected.png","png_assets/overlay_unselected.png")
        UI.Dummy(5,5)
    end
    
    UI.End(pass)
    local ui_passes = UI.RenderFrame(pass)
    table.insert(ui_passes,pass)
    return lovr.graphics.submit(ui_passes)
end
-- lib.mnd_root_destroy(root_ptr)


