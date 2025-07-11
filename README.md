⚡ Lightning Tracker in R

Track real-time lightning strikes across the globe using R, WebSockets, and a touch of curiosity.

📸 Preview

Live logging of lightning strikes in your R console in real-time.



Map visualization using leaflet (optional).

🛠 Features

Connects to Blitzortung.org live lightning strike feed

WebSocket communication via websocket package

Decodes compressed strike data using custom LZW logic

Real-time updates to a data.frame

Optional live map using leaflet

📦 Requirements

Make sure you have the following installed:

R

RStudio

R packages:
<img width="658" height="49" alt="image" src="https://github.com/user-attachments/assets/fb41a42d-1238-4cd0-9a3e-40ef68bb7722" />

🚀 How to Run

1. Clone this repo or download the lightning_tracker.R file.

2. Open it in RStudio.

3. Run the script.

4. You’ll see messages like:
<img width="321" height="75" alt="image" src="https://github.com/user-attachments/assets/73fbf875-476a-481b-80b3-1cc5a81cab27" />

5. To stop it anytime:
<img width="159" height="52" alt="image" src="https://github.com/user-attachments/assets/e708e716-4f78-4a40-94e9-ccf6d1ff4270" />

6. View your data:
<img width="232" height="44" alt="image" src="https://github.com/user-attachments/assets/9eaa2bf3-316c-4285-bb32-16595ffc39ad" />

🧠 How It Works (Explained Simply)

Imagine eavesdropping on lightning. This R script connects to a secret WebSocket where lightning data comes flying in — compressed, nerdy, and fast. We say “Hello!” using a handshake ({"a":111}), and boom — strikes start flowing. We decode them, log them, and store them in a table. It’s basically a storm-chasing control center, all inside RStudio.

📂 Sample Output Table

time

lat

lon

delay

pol

2025-07-11 16:42:11

30.7

-78.5

4.2

0

2025-07-11 16:42:12

56.0

32.1

4.3

1

🗺 Optional: Visualize Lightning on a Map

