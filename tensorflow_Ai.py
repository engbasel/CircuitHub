import pandas as pd
import random
import tensorflow as tf
from sklearn.feature_extraction.text import TfidfVectorizer
from tensorflow.keras.models import Sequential # type: ignore
from tensorflow.keras.layers import Dense, Input # type: ignore
from sklearn.preprocessing import LabelEncoder

# Load and preprocess data
data = pd.read_csv("electronics_projects_unique.csv")
data["Project Description"] = data["Project Description"].str.lower().str.strip()
data["Required Components"] = data["Required Components"].str.lower().str.strip()

# Generate random prices for components
all_components = set()
for components in data["Required Components"]:
    all_components.update(components.split(", "))

component_prices = {component: random.randint(5, 100) for component in all_components}

def calculate_project_price(components):
    items = components.split(", ")
    total_price = sum(component_prices[item] for item in items)
    return total_price

# Add price info to data
data["Component Prices"] = data["Required Components"].apply(
    lambda x: ", ".join([f"{item}: ${component_prices[item]}" for item in x.split(", ")])
)
data["Total Project Price"] = data["Required Components"].apply(calculate_project_price)

# Use TF-IDF to convert descriptions into numeric form
vectorizer = TfidfVectorizer(stop_words='english', max_features=5000, ngram_range=(1, 2))
X_tfidf = vectorizer.fit_transform(data["Project Description"]).toarray()

# Label encode the project descriptions
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(data["Project Description"])

# Define the model
model = Sequential([
    Input(shape=(X_tfidf.shape[1],)),
    Dense(128, activation='relu'),
    Dense(64, activation='relu'),
    Dense(len(label_encoder.classes_), activation='softmax')
])

# Compile the model
model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])

# Train the model
model.fit(X_tfidf, y_encoded, epochs=30, batch_size=16, verbose=1)

# Save the model and vectorizer for future use
model.save("tf_model.h5")
import pickle
pickle.dump(vectorizer, open("vectorizer.pkl", "wb"))
pickle.dump(label_encoder, open("label_encoder.pkl", "wb"))
