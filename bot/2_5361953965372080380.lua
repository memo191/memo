-- BY MOHAMMED HISHAM
-- BY @TH3BOSS
-- BY @lBOSSl
package.path = package.path ..';.luarocks/share/lua/5.2/?.lua' .. ';./bot/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

tdcli = dofile('./libs/tdcli.lua')
serpent = require('serpent')
serp = require 'serpent'.block
feedparser = (loadfile "./libs/feedparser.lua")()
require('./bot/utils')
require('./bot/locks')
require('./libs/lua-redis')
URL = require "socket.url"
http = require("socket.http")
https = require("ssl.https")
http.TIMEOUT = 9
ltn12 = require "ltn12"
json = (loadfile "./libs/JSON.lua")()
mimetype = (loadfile "./libs/mimetype.lua")()
--redis = (loadfile "./libs/redis.lua")()
redis = Redis.connect('127.0.0.1', 6379)
JSON = (loadfile "./libs/dkjson.lua")()
local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
chats = {}
plugins = {}


function do_notify (user, msg)
	local n = notify.Notification.new(user, msg)
	n:show ()
end

function dl_cb (arg, data)
	-- vardump(data)
end

function vardump(value)
	print(serpent.block(value, {comment=false}))
end

function load_data(filename)
	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)
	return data
end

function save_data(filename, data)
	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()
end
print('\27[0;33m>>'..[[







88888888888 888    888  .d8888b.  888888b.    .d88888b.   .d8888b.   .d8888b.  
    888     888    888 d88P  Y88b 888  "88b  d88P" "Y88b d88P  Y88b d88P  Y88b 
    888     888    888      .d88P 888  .88P  888     888 Y88b.      Y88b.      
    888     8888888888     8888"  8888888K.  888     888  "Y888b.    "Y888b.   
    888     888    888      "Y8b. 888  "Y88b 888     888     "Y88b.     "Y88b. 
    888     888    888 888    888 888    888 888     888       "888       "888 
    888     888    888 Y88b  d88P 888   d88P Y88b. .d88P Y88b  d88P Y88b  d88P 
    888     888    888  "Y8888P"  8888888P"   "Y88888P"   "Y8888P"   "Y8888P"      

]]..'\27[0;31m'..[[@XBMBX]]..'\27[m'..[[ 
                                              
]]..'\27[0;31m'..[[@lBOSSl]]..'\27[m'..[[   
                                            
]]..'\27[0;31m'..[[@TH3BOSS]]..'\27[m'..[[  
                                             
]]..'\27[0;31m'..[[@TH3BOSSBOT]]..'\27[m'..[[                                               


]])
function whoami()
	local usr = io.popen("whoami"):read('*a')
	usr = string.gsub(usr, '^%s+', '')
	usr = string.gsub(usr, '%s+$', '')
	usr = string.gsub(usr, '[\n\r]+', ' ') 
	if usr:match("^root$") then
		tcpath = '/root/.telegram-cli'
	elseif not usr:match("^root$") then
		tcpath = '/home/'..usr..'/.telegram-cli'
	end
  print('\27[0;32m>> Download Path = \27[0;32m\27[31m'..tcpath..'\27[39m')
end

function match_plugins(msg)
	for name, plugin in pairs(plugins) do
		match_plugin(plugin, name, msg)
	end
end



function create_config( )
io.write('\n\27[1;33m￤دخل ايدي حسابك لتصبح مطور ↓  \n￤Enter your ID SUDO : \27[0;39;49m')
local SUDO = tonumber(io.read())
if not tostring(SUDO):match('%d+') then
SUDO = 60809019
end
io.write('\n\27[1;33m￤ارسل توكن البوت الان ↓  \n￤Enter TOKEN your BOT : \27[0;39;49m')
local token = io.read()
io.write('\n\27[1;33m￤ادخل الان اسم البوت الذي تريده ↓  \n￤Enter Name Your BOT : \27[0;39;49m')
local botname = io.read()
if botname =="" then
botname = "الزعيم"
end
io.write('\n\27[1;33m￤ادخل معرف المطور ↓  \n￤Enter your USERNAME SUDO : \27[0;39;49m')
local sudouser = io.read()
if sudouser =="" then
sudouser = "@TH3BOSS"
end
redis:set(string.sub(token,0,9)..'bot:name',botname)
	config = {
    enabled_plugins = {
	"banhammer",
    "groupmanager",
    "msg-checks",
    "plugins",
    "tools",
	"replay",
	"zhrf",
	"dell",


	},
    token = token,
    sudo_users = {{SUDO,check_markdown(sudouser)}},
	SUDO = SUDO,
	sudouser = check_markdown(sudouser),
	info_text = [[❖￤ اهلا بك في سورس الزعيم 🔎


❖￤ Version 𝟐𝟓 ⇔ 𝟐𝟓 الاصدار  

❖￤ المطور ⇔
❖￤ @TH3BOSS 

❖￤ قناه السورس ⇔
❖￤ Channel ⇔ @lBOSSl

❖￤ رابط Github Api ⇔
❖￤ https://github.com/moody2020/TH3BOSS

❖￤ رابط Github ⇔
❖￤ https://github.com/moody2020 ]]
	
	,
  }

file = io.open("TH3BOSS.sh", "w")
file:write([[
token="]]..token..[["
if [ ! -f ./libs/tg ]; then
    echo "tg not found"
    echo "Run install.sh"
    exit 1
fi
if [ $token == "" ]; then
    echo "token not found"
    echo "Run install.sh again"
    exit 1
fi
 
COUNTER=1
while(true) do

curl "https://api.telegram.org/bot"$token"/sendmessage" -F
./libs/tg -s ./bot/bot.lua $@ --bot=$token

let COUNTER=COUNTER+1 
done


]])
file:close()

serialize_to_file(config, './data/config.lua')
print ('saved config into config.lua')
if token=="" then
print("❖￤ لم تقم بوضع التوكن يجب عليك وضع التوكن في ملف البوت ليعمل السورس\n")
os.execute(' rm -fr data/config.lua && lua bot/TH3BOSS.lua ')
print ('\n\n\n you did not Enter token \n i delete file launch and config.lua \n\n\n now Run file instal.sh\n ')
return
end
end

function load_config( )
	local f = io.open('./data/config.lua', "r")
		-- If config.lua doesn't exist
	if not f then
		--print ("Created new config file: ./data/config.lua")
		create_config()
	else
		f:close()
	end
	print("")
	local config = loadfile ("./data/config.lua")()
	for v,user in pairs(config.sudo_users) do
		print("\27[0;32mSUDO USER: \27[1;34m" ..user[2]:gsub('\\','')..'\27[0;33m ('..user[1]..')\27[m')
	end
  os.execute(' rm -fr ../.telegram-cli')

	return config
end
whoami()
_config = load_config()

function save_config( )
	serialize_to_file(_config, './data/config.lua')
	print ('saved config into ./data/config.lua')
end
th3boss = string.sub(_config.token,0,9)
sudouser =_config.sudouser 
SUDO = _config.SUDO 

if redis:get(th3boss..'bot:name') then
bot_name = redis:get(th3boss..'bot:name') 
else
bot_name = 'الزعيم'
end

function load_plugins()
	local config = loadfile ("./data/config.lua")()
	print("")
	for k, v in pairs(config.enabled_plugins) do
		print("\27[0;36mLoaded Plugin  ", v..'\27[m')
		local ok, err =  pcall(function()
		local t = loadfile("plugins/"..v..'.lua')()
		plugins[v] = t
		end)
		if not ok then
			print('\27[31mError loading plugins '..v..'\27[39m')
			print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
			print('\27[31m'..err..'\27[39m')
		end
	end
	print('\n\27[0;32m'..#config.enabled_plugins..' Plugins Are Active\n\n\27[0;31mStarting TH3BOSS V25 Robot...\n\27[m')
end

load_plugins()

function msg_valid(msg)
	 if tonumber(msg.date_) < (tonumber(os.time()) - 60) then
        print('\27[36m>>-- OLD MESSAGE --<<\27[39m')
		 return false
	 end

 if is_gbanned(msg.sender_user_id_) then
 del_msg(msg.chat_id_, tonumber(msg.id_))
     kick_user(msg.sender_user_id_, msg.chat_id_)
    return false
   end
   
    return true
end

function match_pattern(pattern, text, lower_case)
	if text then
		local matches = {}
		if lower_case then
			matches = { string.match(text:lower(), pattern) }
		else
			matches = { string.match(text, pattern) }
		end
		if next(matches) then
			return matches
		end
	end
end


function match_plugin(plugin, plugin_name, msg)
	if plugin.pre_process then
        --If plugin is for privileged users only
		local result = plugin.pre_process(msg)
		if result then
			print("pre process: ", plugin_name)
         tdcli.sendMessage(msg.chat_id_, "", 0, result, 0, "md")
		end
	end
	for k, pattern in pairs(plugin.patterns) do
		matches = match_pattern(pattern, msg.content_.text_ or msg.content_.caption_)
		if matches then

			print("Message matches: ", pattern..' | Plugin: '..plugin_name)
			if plugin.run then
				local result = plugin.run(msg, matches)
					if result then
						tdcli.sendMessage(msg.chat_id_, msg.id_, 0, result, 0, "md")
                 end
			end
			return
		end
	end
end

function tdcli_update_callback (data)
	if data.message_ then
		if msg_caption ~= get_text_msg() then
			msg_caption = get_text_msg()
		end
	end
	if (data.ID == "UpdateNewMessage") then
		local msg = data.message_
		local d = data.disable_notification_
		local chat = chats[msg.chat_id_]
		if ((not d) and chat) then
			if msg.content_.ID == "MessageText" then
				do_notify (chat.title_, msg.content_.text_)
			else
				do_notify (chat.title_, msg.content_.ID)
			end
		end
		if msg_valid(msg) then
		var_cb(msg, msg)
	if msg.content_.ID == "MessageText" then
		msg.text = msg.content_.text_
		msg.edited = false
		msg.pinned = false
	elseif msg.content_.ID == "MessagePinMessage" then
		msg.pinned = true
	elseif msg.content_.ID == "MessagePhoto" then
		msg.photo_ = true 
	elseif msg.content_.ID == "MessageVideo" then
		msg.video_ = true
	elseif msg.content_.ID == "MessageAnimation" then
		msg.animation_ = true
	elseif msg.content_.ID == "MessageVoice" then
		msg.voice_ = true
	elseif msg.content_.ID == "MessageAudio" then
		msg.audio_ = true
	elseif msg.content_.ID == "MessageForwardedFromUser" or msg.content_.ID  == "MessageForwardedPost"  then
	    msg.forward_info_ = true
    	msg.forward = {}
    	msg.forward.from_id = data.forward_info_.sender_user_id_
    	msg.forward.msg_id = data.forward_info_.data_
	elseif msg.content_.ID == "MessageSticker" then
		msg.sticker_ = true
	elseif msg.content_.ID == "MessageContact" then
		msg.contact_ = true
	elseif msg.content_.ID == "MessageDocument" then
		msg.document_ = true
	elseif msg.content_.ID == "MessageLocation" then
		msg.location_ = true
	elseif msg.content_.ID == "MessageGame" then
		msg.game_ = true
	elseif msg.content_.ID == "MessageChatAddMembers" then
	for i=0,#msg.content_.members_ do
		msg.adduser = msg.content_.members_[i].id_
	end
	elseif msg.content_.ID == "MessageChatJoinByLink" then
		msg.joinuser = msg.sender_user_id_
	elseif msg.content_.ID == "MessageChatDeleteMember" then
		msg.deluser = true
      end
	end
	elseif data.ID == "UpdateMessageContent" then  
		cmsg = data
		local function edited_cb(arg, data)
			msg = data
			msg.media = {}
			if cmsg.new_content_.text_ then
				msg.text = cmsg.new_content_.text_
			end
			if cmsg.new_content_.caption_ then
				msg.media.caption = cmsg.new_content_.caption_
			end
			msg.edited = true
		if msg_valid(msg) then
			var_cb(msg, msg)
        end
		end
	tdcli_function ({ ID = "GetMessage", chat_id_ = data.chat_id_, message_id_ = data.message_id_ }, edited_cb, nil)
	elseif data.ID == "UpdateFile" then
		file_id = data.file_.id_
	elseif (data.ID == "UpdateChat") then
		chat = data.chat_
		chats[chat.id_] = chat 
	elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
		tdcli_function ({ID="GetChats", offset_order_="9223372036854775807", offset_chat_id_=0, limit_=20}, dl_cb, nil)    
	end
end
