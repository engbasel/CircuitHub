import tensorflow as tf
import pickle
import numpy as np
import tkinter as tk
from tkinter import messagebox
from sklearn.feature_extraction.text import TfidfVectorizer

# Load the saved model and other files
model = tf.keras.models.load_model("tf_model.h5")
vectorizer = pickle.load(open("vectorizer.pkl", "rb"))
label_encoder = pickle.load(open("label_encoder.pkl", "rb"))

# Function to make a prediction
def predict_project(project_description):
    try:
        # Convert input text to the same TF-IDF representation
        input_tfidf = vectorizer.transform([project_description]).toarray()
        
        # Get predictions from the model
        predictions = model.predict(input_tfidf)
        
        # Get the top predicted label
        predicted_label_index = np.argmax(predictions)
        predicted_label = label_encoder.inverse_transform([predicted_label_index])[0]
        
        return predicted_label, predictions[0][predicted_label_index]
    
    except Exception as e:
        return f"Error during prediction: {str(e)}", 0.0

# Function to update the UI with the prediction result
def show_prediction():
    project_description = entry_description.get("1.0", "end-1c").strip().lower()

    if not project_description:
        messagebox.showerror("Input Error", "Please enter a project description.")
        return

    predicted_label, confidence = predict_project(project_description)

    result_text = f"Predicted Project: {predicted_label}\n"
    result_text += f"Confidence: {confidence * 100:.2f}%"

    messagebox.showinfo("Prediction Result", result_text)

# Set up the Tkinter window
window = tk.Tk()
window.title("Project Description Classifier")

# Add components to the window
label_description = tk.Label(window, text="Enter Project Description:")
label_description.pack()

entry_description = tk.Text(window, height=5, width=50)
entry_description.pack()

button_predict = tk.Button(window, text="Predict Project", command=show_prediction)
button_predict.pack()

# Start the Tkinter event loop
window.mainloop()
