import PyPDF2
import nltk
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.ensemble import RandomForestRegressor

def load_pdf(file_path):
    with open(file_path, 'rb') as file:
        pdf = PyPDF2.PdfFileReader(file)
        text = ""
        for page in range(pdf.getNumPages()):
            text += pdf.getPage(page).extractText()
        return text

def extract_details(text):

    nltk.download('stopwords')
    stop_words = set(stopwords.words('english'))
    tokens = nltk.word_tokenize(text.lower())
    tokens = [token for token in tokens if token.isalnum() and token not in stop_words]


    experience_keywords = ['experience', 'work', 'job']
    experience = None
    for i, token in enumerate(tokens):
        if token in experience_keywords:
            if i+1 < len(tokens):
                experience = tokens[i+1]
            break

    region_keywords = ['location', 'region', 'city']
    region = None
    for i, token in enumerate(tokens):
        if token in region_keywords:
            if i+1 < len(tokens):
                region = tokens[i+1]
            break

    return experience, region


def generate_rate_card(experience, region):
   
    training_data = [

        {'experience': 1, 'region': 'New York', 'rate': 50},
        {'experience': 2, 'region': 'California', 'rate': 60},
        {'experience': 3, 'region': 'Texas', 'rate': 70},
        {'experience': 4, 'region': 'Florida', 'rate': 80},
        {'experience': 5, 'region': 'New York', 'rate': 90},
    ]

   
    X_train = []
    y_train = []
    for data in training_data:
        X_train.append([data['experience'], data['region']])
        y_train.append(data['rate'])

    
    model = RandomForestRegressor()

    model.fit(X_train, y_train)

 
    X_test = [[experience, region]]


    predicted_rate = model.predict(X_test)

    return predicted_rate[0]


def main():
    cv_file = 'C:\Users\ridit\OneDrive\DesktopRiditJain_BMU'

    cv_text = load_pdf(cv_file)

    experience, region = extract_details(cv_text)

    rate_card = generate_rate_card(experience, region)

    print("Experience:", experience)
    print("Region:", region)
    print("Rate Card:", rate_card)

if __name__ == '__main__':
    main()
