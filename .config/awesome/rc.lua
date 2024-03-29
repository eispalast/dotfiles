-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local freedesktop = require("freedesktop")

local theme_name = "polytheme"
local theme_path = "/home/timo/.config/awesome/"..theme_name.."/"
local icons_path = theme_path.."icons/"

local colors = dofile(theme_path.."colors.lua")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. theme_name .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

--mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                    { "open terminal", terminal }
--                                  }
--                        })

mymainmenu = freedesktop.menu.build({
	before={
		{"Awesome", myawesomemenu, beautiful.awesome_icon},

	}, 
	after ={
		{"Terminal",terminal},	
	}
})
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

--sophisticated battery widget
local mybetterbattery = wibox.widget{
    
    {
        image   = icons_path.."icon_bat_plugged.png",
        resize  = true,
        widget  = wibox.widget.imagebox,
        id      = "bat_icon",
    },
    {
    
        id      = "bat_text",
        text    = "100%",
        widget  = wibox.widget.textbox,
    },
    layout      = wibox.layout.align.horizontal
    -- set_battery = function(self, val, plugged_in)
    --     self.bat_text.text  = tonumber(val).."%"
    --     if plugged_in then

    --     self.m.value = tonumber(val)
    
}
-- corresponding timer
gears.timer{
    timeout     = 30,
    call_now    = true,
    autostart   = true,
    callback    = function()
        local capacity_file = io.open("/sys/class/power_supply/BAT0/capacity","r")
        io.input(capacity_file)
        local capacity = tonumber(io.read())
        io.close(capacity_file)
        
        local status_file = io.open("/sys/class/power_supply/BAT0/status","r")
        io.input(status_file)
        local status = io.read()
        
        mybetterbattery.bat_text.text = capacity.."%"
        if status == "Charging" then
            mybetterbattery.bat_icon.image = icons_path.."icon_bat_plugged.png"
        else
            if capacity > 90 then 
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_100.png"
            elseif capacity > 80 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_90.png"
            elseif capacity > 70 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_80.png"
            elseif capacity > 60 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_70.png"
            elseif capacity > 50 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_60.png"
            elseif capacity > 40 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_50.png"
            elseif capacity > 30 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_40.png"
            elseif capacity > 20 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_30.png"
            elseif capacity > 10 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_20.png"
            elseif capacity > 5 then
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_10.png"
            else
                mybetterbattery.bat_icon.image = icons_path.."/bat/icon_bat_0.png"
            end
        end
    end 
}

local acpi = [[bash -c 'acpi']]
local better_battery_tt = awful.tooltip{
		objects = {mybetterbattery},
		timeout = 5.0,
		timer_function = function()
				return awful.spawn.easy_async(acpi, function(stdout, stderr, reason, exit_code)
    naughty.notify { text = stdout }
end)
		end,
}


-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mytextclock.format=" %d.%m. %H:%M"


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
			awful.button({},2,function(c)
					c:kill()							
			end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    awful.tag.add("dev",{
        layout = awful.layout.layouts[1],
        screen = s,
        icon = icons_path.."tag_dev.png",
        selected           = true
    })
    awful.tag.add("web",{
        layout = awful.layout.layouts[1],    
        screen = s,
        icon = icons_path.."tag_surf.png"
    })
      
    awful.tag.add("uni",{
        layout = awful.layout.layouts[1],
        screen = s,
        icon = icons_path.."tag_uni.png"
    })

    awful.tag.add("msg",{
        layout = awful.layout.layouts[1],
        screen = s,
        icon = icons_path.."tag_message.png"
    })
    
    awful.tag.add("music",{
        layout = awful.layout.layouts[1],
        screen = s,
        icon = icons_path.."tag_music.png"
    })
    
    awful.tag.add("Kee",{
        layout = awful.layout.layouts[1],
        screen = s,
        icon = icons_path.."tag_key.png"
    })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
	   -- start add style of buttons
        style   = {
            --shape = gears.shape.rounded_rect
        },
        layout   = {
            spacing = 10,
            spacing_widget = {
                color  = colors.bg_normal,
                --shape  = gears.shape.powerline,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template={
            {
                -- {
                --     {
                --         id     = 'text_role',
                --         widget = wibox.widget.textbox,
                --     },
                --     layout = wibox.layout.fixed.horizontal
                -- },
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 1,
                    widget  = wibox.container.margin,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        }
        
        -- end style of buttons

    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
		style={
				--shape=gears.shape.rounded_rect,
				--align="center",
				disable_task_name=true,
		},
		--align="center"
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height=35})
    s.mywibox.bg= colors.bg_normal
    s.mywibox.fg= colors.fg_normal
    s.mywibox.opacity=0.97


    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
		expand="none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
		s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mykeyboardlayout,
            wibox.widget.systray(),
	    wibox.widget.textbox('  |  '),
            mytextclock,
	    wibox.widget.textbox('  |  '),
	    mybetterbattery,
	    --wibox.widget.textbox('  |  '),
            --s.mylayoutbox,
	    --wibox.widget.textbox('  |  '),
            --mylauncher,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local function volume_control(device, updown)
    awful.spawn.with_shell("amixer -c 0 set "..device.." '3%"..updown.."' -M 1>/dev/null");
	awful.spawn.with_shell("amixer -c 0 set Master unmute ");
	awful.spawn.with_shell("amixer -c 0 set "..device.." unmute");
end

local function volume_toggle_mute(device)
	awful.spawn.with_shell("amixer -c 0 set "..device.." toggle");
	awful.spawn.with_shell("amixer -c 0 set Master unmute ");
end
-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ "Mod1",           }, "Tab", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ "Mod1", "Shift"           }, "Tab", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey,           }, "Pause", function () awful.spawn.with_shell("/home/timo/scripts/lock") end,
              {description = "show main menu", group = "awesome"}),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "v", function () awful.spawn(terminal.." -e nvim") end,
              {description = "open Vim", group = "launcher"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("firefox") end,
              {description = "open Browser", group = "launcher"}),
    awful.key({ modkey,"Shift"           }, "s", function () awful.spawn("ksnip") end,
              {description = "open Browser", group = "launcher"}),
    awful.key({ modkey,           }, "e", function () awful.spawn(terminal.." -e ranger") end,
              {description = "open Ranger", group = "launcher"}),
    awful.key({ modkey,           }, "g", function () awful.spawn(terminal.." -e gomuks") end,
              {description = "open Gomuks", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({    }, "XF86MonBrightnessUp", function () awful.spawn.with_shell("~/.config/awesome/brightness_up.sh")                end,
              {description = "Increse screen brightness", group = "Utility"}),
    awful.key({    }, "XF86MonBrightnessDown", function () awful.spawn.with_shell("~/.config/awesome/brightness_down.sh")                end,
              {description = "Decrease screen brightness", group = "Utility"}),
     awful.key({    }, "XF86AudioRaiseVolume", function() volume_control("Headphone","+") end,
              {description = "Increse Headphone volume", group = "Utility"}),
     awful.key({    }, "XF86AudioLowerVolume", function() volume_control("Headphone","-") end,
              {description = "Lower Headphone volume", group = "Utility"}),
     awful.key({"Shift"    }, "XF86AudioRaiseVolume",function() volume_control("Speaker","+") end,
              {description = "Increse Speaker volume", group = "Utility"}),
     awful.key({"Shift"    }, "XF86AudioLowerVolume",function() volume_control("Speaker","-") end, 
              {description = "Lower Speaker volume", group = "Utility"}),
    awful.key({    }, "XF86AudioMute", function() volume_toggle_mute("Headphone") end,
              {description = "Toggle Headphone Mute", group = "Utility"}),
    awful.key({"Shift"    }, "XF86AudioMute", function() volume_toggle_mute("Speaker") end,
              {description = "Toggle Speaker Mute", group = "Utility"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },
    { rule = {name = "KeePassXC"},
      properties = { tag = "Kee" }
    },
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
		  "ksnip",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--client.connect_signal("manage", function (c)
    --c.shape = function(cr,w,h)
        --gears.shape.rounded_rect(cr,w,h,15)
    --end
--end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
awful.spawn.with_shell("lxpolkit")
