from pix2text import Pix2Text

# 创建Pix2Text对象
p2t = Pix2Text()

# 指定图片路径
image_path = '/Users/minecraftxz.com/Downloads/math1.jpg'

result = p2t.recognize_formula(image_path)

print(result)