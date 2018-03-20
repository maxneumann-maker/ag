#!/usr/bin/python3
	
# Beispiel aus Kofler e.a., raspberry pi - das umfassende handbuch, S. 723f.
# erst installieren: python3-picamera


import smtplib, sys
from email.mime.text import MIMEText
from email.header import Header
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart

import time

import picamera

# ------ Hier stehen die Zugangsdaten: --------------------------
login  = "schulimkerei@gmail.com"
passwd = "apis-mellifera"
# ---------------------------------------------------------------
# Das funktioniert nur, wenn in den google-Einstellungen die "weniger sicheren Apps" zugelassen werden!

frm   = login
to    = 'met@gemsger.eu'
subj  = 'Bild'
msg   = 'Melde gehorsamst: Foto aufgenommen.'
dateiname = 'autobild.jpg'


    
# ---- Unterprogramme: -----------------------------------------

def mail_schicken():
    try:
        mime = MIMEMultipart()
        mime['From'] = frm
        mime['To'] = to
        mime['Subject'] = Header(subj, 'utf8')
        mime.attach(MIMEText(msg, 'plain', 'utf-8'))

        f = open (dateiname, 'rb')
        image = MIMEImage(f.read())
        f.close()
        mime.attach(image)
    
        smtp = smtplib.SMTP("smtp.gmail.com")
        smtp.starttls()
        smtp.login(login, passwd)
        smtp.sendmail(frm, [to], mime.as_string())
        smtp.quit()
    
    except:
        print ("Mist", sys.exc_info())

def bild_machen():
    camera = picamera.PiCamera()
    camera.capture(dateiname, resize=(640,480))
    camera.close()
    
#    dateiname =  "autobild"
#    system("raspistill -v -ex night -q 50 -o autobild.jpg")



# Endlosschleife, die alle 15 Minuten durchläuft:

while 1 > 0 :
    schrott = bild_machen()
    schrott = mail_schicken()
    print ("Bild aufgenommen und verschickt")
    time_sleep (900)


