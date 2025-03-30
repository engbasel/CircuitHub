
# import pandas as pd
# import pickle
# from flask import Flask, request, jsonify
# from sklearn.feature_extraction.text import TfidfVectorizer
# from sklearn.neighbors import NearestNeighbors
# import firebase_admin
# from firebase_admin import credentials

# # Initialize Firebase
# cred = credentials.Certificate("store-e1838-firebase-adminsdk-lm82w-c7f376e188.json")
# firebase_admin.initialize_app(cred)

# # Load dataset
# data = pd.read_csv("electronics_projects_unique.csv")

# data["Project Description"] = data["Project Description"].str.lower().str.strip()
# data["Required Components"] = data["Required Components"].str.lower().str.strip()

# # Train TF-IDF and KNN Model
# vectorizer = TfidfVectorizer(stop_words='english', max_features=5000, ngram_range=(1, 2))
# X_tfidf = vectorizer.fit_transform(data["Project Description"])

# knn = NearestNeighbors(n_neighbors=3, metric='cosine')
# knn.fit(X_tfidf)

# # Save models
# pickle.dump(knn, open("knn_model.pkl", "wb"))
# pickle.dump(vectorizer, open("vectorizer.pkl", "wb"))
# pickle.dump(data, open("projects_data.pkl", "wb"))

# print("✅ Model is Ready!")

# # Flask App Setup
# app = Flask(__name__)

# # Load models
# knn = pickle.load(open("knn_model.pkl", "rb"))
# vectorizer = pickle.load(open("vectorizer.pkl", "rb"))
# data = pickle.load(open("projects_data.pkl", "rb"))

# @app.route('/search_project', methods=['POST'])
# def search_project():
#     try:
#         data_request = request.get_json()
#         project_query = data_request.get("project_description", "").strip().lower()
#         required_components = data_request.get("required_components", [])

#         if project_query:
#             input_tfidf = vectorizer.transform([project_query])
#             distances, indices = knn.kneighbors(input_tfidf)

#             similar_projects = []
#             for i in range(len(indices[0])):
#                 similarity_score = round((1 - distances[0][i]) * 100, 2)
#                 if similarity_score >= 50: # Adjust threshold as needed
#                     project_info = {
#                         "project_description": data.iloc[indices[0][i]]["Project Description"],
#                         "required_components": data.iloc[indices[0][i]]["Required Components"],
#                         "similarity_score": similarity_score
#                     }
#                     similar_projects.append(project_info)

#             if similar_projects:
#                 return jsonify({"similar_projects": similar_projects})
#             else:
#                 return jsonify({"message": "يا باسل أدخل بيانات صحيحة"})

#         elif required_components:
#             required_components = [comp.strip().lower() for comp in required_components]
#             matching_projects = []

#             for index, row in data.iterrows():
#                 project_components = set(map(str.strip, row["Required Components"].split(",")))
#                 common_components = project_components.intersection(set(required_components))

#                 if common_components:
#                     match_score = len(common_components) / len(required_components) * 100

#                     matching_projects.append({
#                         "project_description": row["Project Description"],
#                         "required_components": list(common_components),
#                         "match_score": round(match_score, 2)
#                     })

#             matching_projects = sorted(matching_projects, key=lambda x: x["match_score"], reverse=True)

#             if matching_projects:
#                 return jsonify({"matching_projects": matching_projects})
#             else:
#                 return jsonify({
#                     "message": "No Exact Match Found",
#                     "suggestions": "Try adjusting your required components or searching with a project description."
#                 })

#         else:
#             return jsonify({"error": "Invalid Request"}), 400

#     except Exception as e:
#         return jsonify({"error": f"Error: {str(e)}"}), 500

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=7777, debug=True)




import pandas as pd
import pickle
from flask import Flask, request, jsonify
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors
import firebase_admin
from firebase_admin import credentials

# Initialize Firebase
cred = credentials.Certificate("store-e1838-firebase-adminsdk-lm82w-c7f376e188.json")
firebase_admin.initialize_app(cred)

# Load dataset
data = pd.read_csv("electronics_projects_unique.csv")

data["Project Description"] = data["Project Description"].str.lower().str.strip()
data["Required Components"] = data["Required Components"].str.lower().str.strip()

# Train TF-IDF and KNN Model
vectorizer = TfidfVectorizer(stop_words='english', max_features=5000, ngram_range=(1, 3), min_df=1, max_df=0.9, sublinear_tf=True)
X_tfidf = vectorizer.fit_transform(data["Project Description"])

knn = NearestNeighbors(n_neighbors=5, metric='cosine')
knn.fit(X_tfidf)

# Save models
pickle.dump(knn, open("knn_model.pkl", "wb"))
pickle.dump(vectorizer, open("vectorizer.pkl", "wb"))
pickle.dump(data, open("projects_data.pkl", "wb"))

print("✅ Model is Ready!")

# Flask App Setup
app = Flask(__name__)

# Load models
knn = pickle.load(open("knn_model.pkl", "rb"))
vectorizer = pickle.load(open("vectorizer.pkl", "rb"))
data = pickle.load(open("projects_data.pkl", "rb"))

@app.route('/search_project', methods=['POST'])
def search_project():
    try:
        data_request = request.get_json()
        project_query = data_request.get("project_description", "").strip().lower()
        required_components = data_request.get("required_components", [])

        if project_query:
            input_tfidf = vectorizer.transform([project_query])
            distances, indices = knn.kneighbors(input_tfidf)

            similar_projects = []
            for i in range(len(indices[0])):
                similarity_score = round((1 - distances[0][i]) * 100, 2)
                if similarity_score >= 30:  # Reduced threshold to catch more matches
                    project_info = {
                        "project_description": data.iloc[indices[0][i]]["Project Description"],
                        "required_components": data.iloc[indices[0][i]]["Required Components"],
                        "similarity_score": similarity_score
                    }
                    similar_projects.append(project_info)

            if similar_projects:
                return jsonify({"similar_projects": similar_projects})
            else:
                return jsonify({"message": "please enter valid data"})

        elif required_components:
            required_components = [comp.strip().lower() for comp in required_components]
            matching_projects = []

            for index, row in data.iterrows():
                project_components = set(map(str.strip, row["Required Components"].split(",")))
                common_components = project_components.intersection(set(required_components))

                if common_components:
                    match_score = len(common_components) / len(required_components) * 100

                    matching_projects.append({
                        "project_description": row["Project Description"],
                        "required_components": list(common_components),
                        "match_score": round(match_score, 2)
                    })

            matching_projects = sorted(matching_projects, key=lambda x: x["match_score"], reverse=True)

            if matching_projects:
                return jsonify({"matching_projects": matching_projects})
            else:
                return jsonify({
                    "message": "No Exact Match Found",
                    "suggestions": "Try adjusting your required components or searching with a project description."
                })

        else:
            return jsonify({"error": "Invalid Request"}), 400

    except Exception as e:
        return jsonify({"error": f"Error: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7777, debug=True)