from pix2text import Pix2Text
import tkinter as tk
from tkinter import filedialog

def select_file():
    # Create a Tk root widget (it won't be shown)
    root = tk.Tk()
    root.withdraw()  # Hide the root window

    # Open a file dialog and get the selected file path
    file_path = filedialog.askopenfilename(
        filetypes=[("Image files", "*.jpg *.jpeg *.png"), ("All files", "*.*")]
    )

    if file_path:
        return file_path
    else:
        print("No file selected")
        return None

if __name__ == "__main__":
    # Let the user select an image file
    image_path = select_file()

    if image_path:
        # Create an instance of Pix2Text
        p2t = Pix2Text()

        # Recognize formula from the selected image
        result = p2t.recognize_formula(image_path)

        # Print the result
        print(result)
