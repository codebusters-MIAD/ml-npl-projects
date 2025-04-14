import logging as logger
import numpy as np
import re

# Lista de keywords
keywords_list = ['https', 'login', '.php', '.html', '@', 'sign']


class Utils:

    @staticmethod
    def extract_features(url):
        logger.info(f"URL : {url}")
        features = []

        for keyword in keywords_list:
            features.append(1 if keyword in url else 0)

        features.append(len(url) - 2)

        try:
            domain = re.split(r'\/+', url)[1]
        except IndexError:
            domain = ''

        features.append(len(domain))

        is_ip = domain.replace('.', '').isdigit()
        features.append(1 if is_ip else 0)

        features.append(url.count('com'))

        return np.array([features], dtype=np.float32)


    @staticmethod
    def show_log_banner(message):
        logger.info("---------------------------------------------------------------------------------------------")
        logger.info(message)
        logger.info("---------------------------------------------------------------------------------------------")


