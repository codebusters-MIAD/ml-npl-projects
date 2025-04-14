import onnxruntime as ort
import os

session = ort.InferenceSession(f"{os.path.dirname(__file__)}/resources/phishing_clf.onnx")

class PredictModel:
    @staticmethod
    def predict(features):
        input_name = session.get_inputs()[0].name
        return session.run(None, {input_name: features})
