#!/usr/bin/python3

# Beispiel aus Kofler e.a., raspberry pi - das umfassende handbuch, S. 723f.

import smtplib, sys
from email.mime.text import MIMEText
from email.header import Header

# ------ Hier stehen die Zugangsdaten: --------------------------
login  = "ADRESSE"
passwd = "PASSWORT"
# ---------------------------------------------------------------
# Das funktioniert nur, wenn in den google-Einstellungen die "weniger sicheren Apps" zugelassen werden!

frm   = login
to    = 'met@gemsger.eu'
subj  = 'Betreff mit Kaese'
msg   = 'Verteufelt wichtiger Text'


try:
    mime = MIMEText(msg, 'plain', 'utf-8')
    mime['From'] = frm
    mime['To'] = to
    mime['Subject'] = Header(subj, 'utf8')

    smtp = smtplib.SMTP("smtp.gmail.com")
    smtp.starttls()
    smtp.login(login, passwd)
    smtp.sendmail(frm, [to], mime.as_string())
    smtp.quit()

except:
    print ("Scheisse", sys.exc_info())
