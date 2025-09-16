# NtfyOnJoin
A simple script that can be dropped into the Workspace of your Roblox game to send notifications using [ntfy](https://ntfy.sh) when players join the game. Either the main public instance (ntfy.sh) or your own self-hosted instance can be used.

Minimal configuration is required, just make sure that you enable "Allow HTTP Requests" in `Game Settings > Security` within the Roblox Studio. The default topic is `roblox_feed_ctype-creatorid` with `ctype` being the creator type (`usr/grp`) and `creatorid` being the numerical ID of the creator. You can change this by modifying the `ntfy_topic` variable in the script. If you're confused about the automatic topic generation, the topic is printed to the output when the game starts.

Once the script is in your game and HTTP requests are enabled, simply subscribe to the topic on the ntfy website or using an ntfy client (such as their mobile apps) to start receiving notifications when players join your game.

The script does not support email or phone notifications by default so that the script does not contain your information, especially useful for group-owned games where multiple people may have access to the script. I seriously recommend using desktop clients, the web UI, or ntfy's mobile apps for notifications. The JSON structure can be readily modified to include email or phone if you want to add it yourself, or modify the notifications in any other way.

## Credits
ntfy is open source (see repository [binwiederhier/ntfy](https://github.com/binwiederhier/ntfy)).

See main README for information about other scripts included in this repository.