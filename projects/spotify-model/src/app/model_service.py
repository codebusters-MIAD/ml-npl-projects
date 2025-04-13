from http_response import HTTPResponse
from wrong_request_exception import WrongRequestException

class ModelService:
    ERR_INTERNAL_SERVER = 'Internal server error'
    ERR_WRONG_STRUCTURE = 'The body data is wrong, Exception: {}'

    IN_PROGRESS = "In progress"
    COMPLETED = "Completed"
    FAILED = "Failed"

    def __init__(self, body, http_method, path, request_id):
        self.body = body
        self.http_method = http_method
        self.path = path
        self.request_id = request_id

    def make_operation(self):
        try:
            response = HTTPResponse.successful_response({
                "requestId": self.request_id,
                "status": self.COMPLETED,
                "successful": "Okey Dokey - Margarita",
                "failures": ""})
        except WrongRequestException as ex:
            response = HTTPResponse.bad_request_response(err=ex.message)
        except BaseException as ex:
            exception = str(ex)
            response = HTTPResponse.internal_server_err_response(err=self.ERR_INTERNAL_SERVER, exception=exception)
        return response
