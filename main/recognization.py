from pix2text import Pix2Text
import re

def recognize(image):
  # Use Pix2Text for OCR recognition
  p2t = Pix2Text()
  raw_result = p2t.recognize_formula(image)
  
  # Call the formatting function to process the result
  formatted_result = format_latex_to_readable(raw_result)
  
  return formatted_result

def format_latex_to_readable(latex_str):
  # Remove LaTeX spaces and unnecessary backslashes
  latex_str = latex_str.replace(' ', '').replace('\\,', '').replace('\\', '')
  
  # Match and replace x^{n} with x^n
  readable_str = re.sub(r'x\^\{(\d+)\}', r'x^\1', latex_str)
  
  # Match and replace {n} with n
  readable_str = re.sub(r'\{(\d+)\}', r'\1', readable_str)
  
  # Add * around x to ensure multiplication
  readable_str = re.sub(r'(\d)x', r'\1*x', readable_str)  # Add * between numbers and x
  readable_str = re.sub(r'(\))x', r'\1*x', readable_str)  # Add * between parentheses and x
  readable_str = re.sub(r'x(\d)', r'x*\1', readable_str)  # Add * between x and numbers
  
  # Ensure the leading term with x is properly formatted
  readable_str = re.sub(r'([a-zA-Z])\*([a-zA-Z])', r'\1*\2', readable_str)
  
  # Fix leading and trailing plus signs
  readable_str = re.sub(r'^\+', '', readable_str)  # Remove leading plus sign
  readable_str = re.sub(r'\+$', '', readable_str)  # Remove trailing plus sign
  
  # Ensure correct placement of minus signs
  readable_str = readable_str.replace('+-', '-').replace('--', '+')