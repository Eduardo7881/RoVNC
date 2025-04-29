# RoVNC
My try to create a Roblox VNC Client using ScreenGui's and Frames.

# I think i'm the first person doing that (29/04/2025)

# My goal
- In Roblox we'll have a 100x100 screen grid for rendering. (I'LL CHANGE LATER)
- Every pixel is a FRAME with colors.
- My real goal is make it really work, for now, we are just testing with random pixels

# How it works?
## So, connecting VNC Server (TCP) directly to Roblox using the `HttpService` isn't possible.
## We need to have a WebSocket Server tho.
## But Roblox DOENS'T allow WebSockets too!
## Then, we need a intermediate server to convert RAW Encoding Pixels to JSON!
## And finally, on Roblox, connect to that Server and Render Pixels if need.

