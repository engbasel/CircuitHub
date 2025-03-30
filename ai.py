import pickle
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors

# Load project data from CSV
data = pd.read_csv("electronics_projects_unique.csv")

# Check if the required column exists
if "Project Description" not in data.columns:
    raise ValueError("CSV file must contain a 'Project Description' column!")

# Convert project descriptions to TF-IDF vectors
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(data["Project Description"])

# Train KNN model
knn = NearestNeighbors(n_neighbors=5, metric='cosine')
knn.fit(X)

# Save the trained model and vectorizer
with open("knn_model.pkl", "wb") as f:
    pickle.dump(knn, f)

with open("vectorizer.pkl", "wb") as f:
    pickle.dump(vectorizer, f)

# Save the processed dataset
with open("projects_data.pkl", "wb") as f:
    pickle.dump(data, f)

print("✅ KNN model, vectorizer, and project data saved successfully!")
