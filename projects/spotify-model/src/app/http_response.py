import json
from http import HTTPStatus
from datetime import datetime
import logging as logger

ERR_UNAUTHORIZED = 'Unauthorized doc|file:'
ERR_BAD_REQUEST = 'Invalid Request Type -'
ERR_NOT_FOUND_AUTHORIZATION = 'Not found authorization for doc|file:'


class HTTPResponse:
    """
    Class to handle the lambda responses
    """
    DELETE = 'DELETE'
    POST = 'POST'
    OPTIONS = 'OPTIONS'

    @staticmethod
    def build(body, status, content_type='application/json'):
        return {
            'body': json.dumps(body),
            'statusCode': status,
            'headers': {
                'Content-Type': content_type,
                'Access-Control-Allow-Origin': '*'
            }
        }

    @staticmethod
    def build_not_body(status, content_type='application/json'):
        return {
            'statusCode': status,
            'headers': {
                'Content-Type': content_type,
                'Access-Control-Allow-Origin': '*'
            }
        }

    @staticmethod
    def options_response():
        return {
            'statusCode': HTTPStatus.NO_CONTENT,
            'headers': {
                'Content-Type': 'text/plain charset=UTF-8',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Credentials': 'true',
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Methods': 'POST,OPTIONS,DELETE'
            }
        }

    @staticmethod
    def build_err_body(err, status, exception=None):
        return {
            "timestamp": str(datetime.utcnow()),
            "status": status,
            "error": err,
            "exception": str(exception),
        }

    @staticmethod
    def successful_response(body):
        return HTTPResponse.build(body, HTTPStatus.OK)

    @staticmethod
    def accepted_response():
        return HTTPResponse.build_not_body(HTTPStatus.ACCEPTED)

    @staticmethod
    def unauthorized_response(message=None):
        message = f'{ERR_UNAUTHORIZED} {message}'
        logger.info(message)
        return HTTPResponse.build(HTTPResponse.build_err_body(err=message, status=HTTPStatus.UNAUTHORIZED),
                                  HTTPStatus.UNAUTHORIZED)

    @staticmethod
    def bad_request_response(err=None, exception=None):
        err = f'{ERR_BAD_REQUEST} {err}'
        logger.info(err)
        return HTTPResponse.build(HTTPResponse.build_err_body(err=err, status=HTTPStatus.BAD_REQUEST,
                                                              exception=exception), HTTPStatus.BAD_REQUEST)

    @staticmethod
    def not_found_authorization(key=None):
        err = f'{ERR_NOT_FOUND_AUTHORIZATION} {key}'
        logger.info(err)
        return HTTPResponse.build(HTTPResponse.build_err_body(err=err, status=HTTPStatus.NOT_FOUND),
                                  HTTPStatus.NOT_FOUND)

    @staticmethod
    def internal_server_err_response(err, exception=None):
        logger.error(err)
        return HTTPResponse.build(HTTPResponse.build_err_body(err=err, status=HTTPStatus.INTERNAL_SERVER_ERROR,
                                                              exception=exception), HTTPStatus.INTERNAL_SERVER_ERROR)