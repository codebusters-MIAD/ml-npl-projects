from pydantic import ValidationError

from http_response import HTTPResponse
from predict_request import PredictRequest
from predict_model import  PredictModel
from util import Utils


class ModelService:
    ERR_INTERNAL_SERVER = 'Internal server error'
    ERR_WRONG_STRUCTURE = 'The body data is wrong, Exception: {}'

    IN_PROGRESS = "In progress"
    COMPLETED = "Completed"
    FAILED = "Failed"

    def __init__(self, body, http_method, request_id):
        self.body = body
        self.http_method = http_method
        self.request_id = request_id

    def make_operation(self):
        try:
            if self.http_method == HTTPResponse.OPTIONS:
                return HTTPResponse.options_response()

            parsed = PredictRequest.model_validate_json(self.body)
            features = Utils.extract_features(str(parsed.url))
            result = PredictModel.predict(features)

            response = HTTPResponse.successful_response({
                "requestId": self.request_id,
                "status": self.COMPLETED,
                "HTTP Method": self.http_method,
                "Body": self.body,
                "ParseBody": str(parsed.url),
                "successful": f"Phishing probability: {result[1][0][1]:.4f}",
                "failures": ""})

        except ValidationError as ex:
            response = HTTPResponse.bad_request_response(err=ex.message)
        except BaseException as ex:
            exception = str(ex)
            response = HTTPResponse.internal_server_err_response(err=self.ERR_INTERNAL_SERVER, exception=exception)
        return response
