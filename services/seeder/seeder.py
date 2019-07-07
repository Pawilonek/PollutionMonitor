import urllib.request
import json      

from datetime import datetime
import random
import time

temp = random.uniform(-20, 30)

while True:
    if temp > 30:
        temp -= 1
    elif temp < -20:
        temp +=1
    else:
        temp += random.uniform(-1, 1)

    body = {
        "timestamp": datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S+00:00'),
        "hummiditiy": 12,
        "temperature": temp
    }

    myurl = "http://127.0.0.1:8000/measurements"
    req = urllib.request.Request(myurl)
    req.add_header('Content-Type', 'application/json; charset=utf-8')
    jsondata = json.dumps(body)
    jsondataasbytes = jsondata.encode('utf-8')   # needs to be bytes
    req.add_header('Content-Length', len(jsondataasbytes))
    print (jsondataasbytes)
    response = urllib.request.urlopen(req, jsondataasbytes)

    time.sleep(random.uniform(0, 1))
