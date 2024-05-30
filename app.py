from flask import Flask, request, jsonify
from PIL import Image
import requests
from main.recognization import recognize  # Importing the recognize function from ./main/recognization.py
from main.solving_main import solving     # Importing the solving function from ./main/solving_main.py

app = Flask(__name__)

@app.route('/recognize', methods=['POST'])
def recognize_image():
  file = request.files['file']
  callback_url = request.form.get('callback_url')
  if not callback_url:
    return jsonify({"error": "No callback URL provided"}), 400

  try:
    image = Image.open(file.stream)
    # Use the recognize function to get the result
    result = recognize(image)
    # Send the result back to the callback URL
    send_result(callback_url, result)
    return jsonify({"status": "Result sent"}), 200
  except Exception as e:
    return jsonify({"error": str(e)}), 500

@app.route('/expression', methods=['POST'])
def solve_expression():
  expression_file = request.files['expression']
  callback_url = request.form.get('callback_url')
  if not callback_url:
    return jsonify({"error": "No callback URL provided"}), 400

  try:
    expression = expression_file.stream.read().decode('utf-8')
    # Use the solving function to get the result
    result = solving(expression)
    # Send the result back to the callback URL
    send_result(callback_url, result)
    return jsonify({"status": "Result sent"}), 200
  except Exception as e:
    return jsonify({"error": str(e)}), 500

def send_result(url, result):
  # Send the result to the specified callback URL
  try:
    response = requests.post(url, json={"result": result})
    response.raise_for_status()
  except requests.exceptions.RequestException as e:
    print(f"Failed to send result to {url}: {e}")

if __name__ == '__main__':
  import sys
  port = 5000
  if len(sys.argv) > 1:
    port = int(sys.argv[1].split('=')[-1])
  app.run(host='0.0.0.0', port=port)
