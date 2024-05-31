from flask import Flask, request, jsonify
from PIL import Image
from recognization import recognize  # Importing the recognize function from ./main/recognization.py
from solving_main import solving     # Importing the solving function from ./main/solving_main.py

app = Flask(__name__)

@app.route('/recognize', methods=['POST'])
def recognize_image():
  file = request.files['file']

  try:
    image = Image.open(file.stream)
    # Use the recognize function to get the result
    return recognize(image)
  except Exception as e:
    return jsonify({"error": str(e)}), 500

@app.route('/solving', methods=['POST'])
def solve_expression():
  try:
    expression = request.form['expression']
    # Use the solving function to get the result
    return jsonify(solving(expression))
  except Exception as e:
    return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000)
