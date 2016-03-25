# delphi-android-datawedge
Send Intent START_SCANNING and get results over Broadcastreceive

Working with Android on a Barcodescanner with Datawedge and get Data with Intent:

Steps to get this demo working:

1.) Downloaad and install "Broadcastreceiver from Baris Atalay"
brsatalay.blogspot.com.tr/2014/10/delphi-android-broadcast-receiver.html

2.) Open and compile Demo

3.) Setup your Datawedge on barcodescanner as follows:
 - Create a profile in Datawedge for your application as follows:
 - Select your application as connected app
 - Enable barcode-input checkbox
 - Enable msr checkbox
 - Enable Intent checkbox
 - Define your Intent-Aktion = org.mein.intent.name
 - leave Intent-Category EMPTY (!)
 - Select Send-Intent

Thats all. Now you have a app which can work i.e. on MC3200 from Motorola and can read the barcodes very fast! 

Good luck with your projects.