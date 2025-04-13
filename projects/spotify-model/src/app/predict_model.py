import pandas as pd
import joblib
import os

phishing_path = f"{os.path.dirname(__file__)}/resources/phishing_clf.pkl"

class PredictModel:

    @staticmethod
    def parse_str(url):

        clf = joblib.load(phishing_path)

        url_ = pd.DataFrame([url], columns=['url'])

        # Create features
        keywords = ['https', 'login', '.php', '.html', '@', 'sign']
        for keyword in keywords:
            url_['keyword_' + keyword] = url_.url.str.contains(keyword).astype(
                int)

        url_['lenght'] = url_.url.str.len() - 2
        domain = url_.url.str.split('/', expand=True).iloc[:, 2]
        url_['lenght_domain'] = domain.str.len()
        url_['isIP'] = (
                    url_.url.str.replace('.', '') * 1).str.isnumeric().astype(
            int)
        url_['count_com'] = url_.url.str.count('com')

        # Make prediction
        p1 = clf.predict_proba(url_.drop('url', axis=1))[0, 1]

        return p1
