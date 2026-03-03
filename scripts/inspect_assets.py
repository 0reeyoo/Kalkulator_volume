from PIL import Image
import os
for name in ['kubus.png','tabung.png','kerucut.png']:
    path=os.path.join(r'c:\projectflutter\flutterlat1\assets',name)
    try:
        im=Image.open(path)
        print(name, im.size, os.path.getsize(path))
    except Exception as e:
        print('error',name,e)
