from PIL import Image
import os
os.makedirs(r'c:\projectflutter\flutterlat1\assets', exist_ok=True)
colors={'kubus':'red','tabung':'green','kerucut':'blue'}
for name,col in colors.items():
    img=Image.new('RGB',(50,50),col)
    img.save(rf'c:\projectflutter\flutterlat1\assets\{name}.png')
print('created')
