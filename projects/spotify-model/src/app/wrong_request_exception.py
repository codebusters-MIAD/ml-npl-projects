class WrongRequestException(Exception):
    ERR_WRONG_PATH = 'Path not supported'
    ERR_WRONG_METHOD = 'HTTP method not supported'

    def __init__(self, message=""):
        self.message = message
        super().__init__(self.message)
