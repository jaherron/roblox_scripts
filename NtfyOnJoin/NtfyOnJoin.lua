-- NtfyOnJoin by LittleBit
-- Send notifications through an ntfy server when a player joins the game
-- Before using, go to Game Settings -> Security in the Studio and enable "Allow HTTP Requests"

ntfy_topic = "auto" -- Set to "auto" to automatically generate a topic, or set to a specific topic name
ntfy_server = "https://ntfy.sh" -- The public server is ntfy.sh, private servers must be accessible to the Internet
allow_studio = true -- set to false to produce no notification in Studio

function topic_gen()
	local topic
	if game.CreatorType == Enum.CreatorType.Group then
		topic = "roblox_feed_grp-" .. game.CreatorId
	else
		topic = "roblox_feed_usr-" .. game.CreatorId
	end
	return topic
end

game.Players.PlayerAdded:Connect(function(player: Player)
	local ltopic = ""

	-- Auto topic generation
	if ntfy_topic == "auto" or ntfy_topic == "" then
		ltopic = topic_gen()
	else
		ltopic = ntfy_topic
	end

	local MarketplaceService = game:GetService("MarketplaceService")
	-- Fetch place name
	local gameName = "Unknown Game"
	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId)
	end)
	if success and info and info.Name then
		gameName = info.Name
	end

	local http = game:GetService("HttpService")

	-- Prepare data to send to ntfy
	local data
	if not game:GetService("RunService"):IsStudio() then
		data = {
			topic = ltopic,
			title = "Player Joined Game",
			message = player.DisplayName .. " (@" .. player.Name .. ") is playing " .. gameName
		}
	else
		data = {
			topic = ltopic,
			title = "[In Studio] Player Joined Game",
			message = player.DisplayName .. " (@" .. player.Name .. ") is playing " .. gameName,
			priority = 1
		}
	end

	-- Send the notification
	if game:GetService("RunService"):IsStudio() and allow_studio then
		http:PostAsync(ntfy_server, http:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
		print("NtfyOnJoin: Sent notification for " .. player.Name .. " to topic " .. ltopic)
	elseif not game:GetService("RunService"):IsStudio() then
		http:PostAsync(ntfy_server, http:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
		print("NtfyOnJoin: Sent notification for " .. player.Name .. " to topic " .. ltopic)
	else
		warn("NtfyOnJoin: Not sending notification because game is in Studio and allow_studio is false")
	end
end)

-- Determine topic string before printing
local topicString = ""
if ntfy_topic == "auto" or ntfy_topic == "" then
	topicString = topic_gen()
else
	topicString = ntfy_topic
end
print("NtfyOnJoin loaded | Server: " .. ntfy_server .. " | Topic: " .. topicString)

