# Fabcaria
We record what you had and how much it is in your fridge and then we suggest what dishes for your dinner. If there are missing ingredients, you will be suggested to buy it from the most convenient grocery.

# Folders
- mobileapp: Containing mobile app code for iOS devices
- scale_firmware: Arduino code, use with Arduino IDE
- scale_windowsapp: An application runs on Windows natively using to communicate with physical scale hardware
- webapi: A backend webserver to store data related to foods, boxes, recipes, markets, marketfoods

# Functions:
- mobileapp: Display foods currently stored in fridge, user uses to keep track of foods and to pick recipe to cook
- scale_firmware: An Arduino sketch to read RFID tag and load sensor, send data to computer via UART
- scale_windowsapp: A small application is used to push data, such as: food type, weight, from hardware to webapi
- webapi: A nodejs backend server storing data related to foods, boxes, recipes, markets, marketfoods. Push recipes to mobileapp

# Team Members
- Son Vu, Giang Nguyen: An mechatronic engineer working on scale_firmware and scale_windowsapp
- Thanh Pham: Frontend iOS developer who made mobileapp
- Hai Nguyen: UI/UX designer for mobileapp
- Nhan Nguyen: An electrical and electronic engineer, web backend developer an entrepreneur created webapi
