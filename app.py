from flask import Flask, request, jsonify
from PIL import Image
from main.recognization import recognize
from main.solving_main import solving

app = Flask(__name__)

@app.route('/recognize', methods=['POST'])
def recognize_image():
  file = request.files['file']

  try:
    image = Image.open(file.stream)
    return recognize(image)
  except Exception as e:
    return jsonify({"error": str(e)}), 500

@app.route('/expression', methods=['POST'])
def solving():
  expression = request.files['expression']

  try:
    return solving(expression.stream.read().decode('utf-8'))
  except Exception as e:
    return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=6666)
