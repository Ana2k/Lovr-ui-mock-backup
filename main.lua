require 'example'
--OUR WORKING APP
UI = require "ui/ui"

local ffi = require("ffi")

local status, lib = pcall(ffi.load, "libmonado.so")


--     return root_ptr[0]
-- end

-- local root = create_root()

-- function update_clients()
--     local ret = lib.mnd_root_update_client_list(root)
--     if ret ~= 0 then
--         error("Could not update clients")
--     end
-- end

-- function get_client_count()
--     client_count_ptr = ffi.new("uint32_t[1]")
--     ret = lib.mnd_root_get_number_clients(root, client_count_ptr)
--     if ret ~= 0 then
--         error("Could not get number of clients")
--     end
--     return client_count_ptr[0]
-- end

-- function get_client_id_at_index(index)
--     client_id_ptr = ffi.new("uint32_t[1]")
--     local ret = lib.mnd_root_get_client_id_at_index(root, index, client_id_ptr)
--     if ret ~= 0 then
--         error("Could not get client id at index.")
--     end
--     return client_id_ptr[0]
-- end

-- function get_client_name(client_id)
--     name_ptr = ffi.new("const char*[1]")
--     local ret = lib.mnd_root_get_client_name(root, client_id, name_ptr)
--     if ret ~= 0 then
--         error("Could not get client name.")
--     end
--     return name_ptr[0]
-- end

-- function get_client_flags(client_id)
--     flags_ptr = ffi.new("uint32_t[1]")
--     local ret = lib.mnd_root_get_client_state(root, client_id, flags_ptr)
--     if ret ~= 0 then
--         error("Could not get client flags.")
--     end
--     return flags_ptr[0]
-- end

-- function set_primary(client_id)
--     local ret = lib.mnd_root_set_client_primary(root, client_id)
--     if ret ~= 0 then
--         error("Failed to set primary client to client id", client_id)
--     end
-- end

-- function set_focused(client_id)
--     ret = lib.mnd_root_set_client_focused(root, client_id)
--     if ret ~= 0 then
--         error("Failed to set focused client to client id", client_id)
--     end
-- end

-- function toggle_io(client_id)
--     ret = lib.mnd_root_toggle_client_io_active(root, client_id)
--     if ret ~= 0 then
--         error("Failed to toggle io for client client id", client_id)
--     end
-- end

-- if args_primary then
--     set_primary(args_primary)
-- end
-- if args_focused then
--     set_focused(args_focused)
-- end
-- if args_input then
--     toggle_io(args_input)
-- end

-- update_clients(root)
-- print("Client count:", get_client_count())

-- for i = 0, get_client_count() - 1 do
--     local client_id = get_client_id_at_index(i)
--     local name = get_client_name(client_id)
--     local flags = get_client_flags(client_id)
--     local primary = bit.band(flags, lib.MND_CLIENT_PRIMARY_APP) ~= 0
--     local active = bit.band(flags, lib.MND_CLIENT_SESSION_ACTIVE) ~= 0
--     local visible = bit.band(flags, lib.MND_CLIENT_SESSION_VISIBLE) ~= 0
--     local focused = bit.band(flags, lib.MND_CLIENT_SESSION_FOCUSED) ~= 0
--     local overlay = bit.band(flags, lib.MND_CLIENT_SESSION_OVERLAY) ~= 0
--     local io_active = bit.band(flags, lib.MND_CLIENT_IO_ACTIVE) ~= 0
--     print(string.format("INSIDE MAIN.LUA id: %d primary: %5s active: %5s visible: %5s focused: %5s io: %5s overlay: %5s name: %s",
--           client_id, tostring(primary), tostring(active), tostring(visible), tostring(focused),
--           tostring(io_active), tostring(overlay), ffi.string(name)))
-- end



-- local table = []

-- print("Client id access:",get_client_id_at_index(0))
-- we are able to get the id. 
-- but not able to execute the other variable values. 

local dashboard_transform = lovr.math.newMat4( vec3( 0, 1.5, -1 ) )
    
function lovr.load()
	UI.Init(nil, nil, true, 0)
	lovr.graphics.setBackgroundColor( 0.4, 0.4, 1 )
    --this works here. 
    -- but. we need this data at the starting points. 
end

function if_checker(bool_check,img_true,img_false)
    if(bool_check=="true")
    then
        UI.ImageButton(img_true,64,64)
        UI.SameLine()
        print(bool_check,"TRUE")
        UI.Dummy(50,0)
        UI.SameLine()
    else
        UI.ImageButton(img_false,64,64)
        UI.SameLine()
        print(bool_check,"FALSE")
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
    -- This works. 
    UI.SameLine()
    --DUMMY WIDTH AFAIN WHY?
    UI.Dummy(500,0)
    
    UI.SameLine()
    -- print("FOR LOOP next line")
    -- local client_count = get_client_count()
        
    -- UI.SameLine()
    UI.ImageButton("png_assets/monado_logo_no_bkg.png",64,64)
    -- QUESTION TO SELF
    -- should the for loop be in the update??????
    -- should be in load. 
    --lets do an experiment.
    -- maybe this a wrong place to ask these things 
    -- maybe this for loop should not be in the lovr.draw()

    local client = get_client_count()
    -- print("CLIENT INSIDE LOAD", client)
    -- THE HEADINGS
    UI.Dummy(300,0)
    UI.SameLine()
    -- UI.Dummy(250,0)
    UI.Label("primary ")
    UI.SameLine()
    UI.Label("focused ")
    UI.SameLine()
    UI.Label("  io  ")
    UI.SameLine()
    -- UI.Label("active "..active)
    -- for this one, we have to use a different coloured text and that is it. 
    -- UI.SameLine()
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

        -- print(string.format("id: %d primary: %5s active: %5s visible: %5s focused: %5s io: %5s overlay: %5s name: %s",
        --     client_id, tostring(primary), tostring(active), tostring(visible), tostring(focused),
        --     tostring(io_active), tostring(overlay), ffi.string(name)))
        -- -- local str_name = tostring(name)
        -- local bool_primary = tostring(primary)
        -- local bool_visible = tostring()

        -- Name of the device.
        --UI.GetColor() --> Something related to this for 
        -- button_bg --> Explore the color tweaker test.
        local name_str = ffi.string(name)
        UI.Label(""..name_str)
        local len_name = string.len(name_str)
        -- print(len_name," ",name_str)
        UI.SameLine()
        -- UI.Dummy(width, height)
        local space = 400-len_name
        print("space",space)
        print("len_name",len_name)
        -- UI.Dummy(len_name,0)
        -- UI.SameLine()
        UI.Dummy(space,0)
        UI.SameLine()

        --PRIMARY
        if_checker(bool_primary,"png_assets/primary_selected.png","png_assets/primary_unselected.png")
        -- UI.SameLine()

        --FOCUSSED
        if_checker(bool_focused,"png_assets/focused_selected.png","png_assets/focused_unselected.png")
        -- UI.SameLine()

        --IO
        if_checker(bool_io_active,"png_assets/io_selected.png","png_assets/io_unselected.png")
        -- UI.SameLine()

        --VISIBLE
        if_checker(bool_visible,"png_assets/visibilty_selected.png","png_assets/visibility_unselected.png")
        -- UI.SameLine()

        --OVERLAY
        if_checker(bool_overlay,"png_assets/overlay_selected.png","png_assets/overlay_unselected.png")
        UI.Dummy(0,0)

        --COLOR CHANGE THE TEXT FOR ACTIVE

        -- UI.ImageButton("png_assets/io_selected.png",64,64)
        -- -- -- try these and then UI.Label("name: "..str_name.."primary: "..bool_primary)
        
        

        -- UI.Label("")
    end
    
    UI.End(pass)
    -- print("HARI 12")
    local ui_passes = UI.RenderFrame(pass)
    table.insert(ui_passes,pass)
    return lovr.graphics.submit(ui_passes)
end
-- lib.mnd_root_destroy(root_ptr)


