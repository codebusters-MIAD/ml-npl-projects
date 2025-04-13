import ast
from wrong_request_exception import WrongRequestException
import logging as logger

ERR_STR_PARSE = "Wrong structure on the json string when it parse: {}"
ERR_WRONG_BODY_PARSE = "Wrong structure on the body when it parse: {}"
WAIT_ERR = "There is not presence of element located by: {} and the values is: {}"


class Utils:
    ERR_INTERNAL_SERVER = 'Internal server error'
    ADD_A_WORD_AND_REMOVE = "a\b"
    JS_TO_FILL_INPUT = "arguments[0].value=arguments[1]"

    @staticmethod
    def parse_body(body):
        try:
            return ast.literal_eval(body)
        except Exception:
            err = ERR_WRONG_BODY_PARSE.format(body)
            logger.error(err)
            raise WrongRequestException(message=err)

    @staticmethod
    def parse_str(string):
        try:
            return ast.literal_eval(string)
        except Exception:
            err = ERR_STR_PARSE.format(string)
            logger.error(err)
            raise BaseException(message=err)

    @staticmethod
    def show_log_banner(message):
        logger.info("---------------------------------------------------------------------------------------------")
        logger.info(message)
        logger.info("---------------------------------------------------------------------------------------------")


