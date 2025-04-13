from model_service import ModelService

ERR_WRONG_PATH = 'Path not supported'

def handler(event, context):
    """
    Lambda main method
    """
    body = event.get('body') or {}
    path = event.get('path') or {}
    http_method = event.get('httpMethod') or {}
    request_id = event['requestContext']['requestId'] or {}
    return ModelService(body=body, http_method=http_method, path=path,
                             request_id=request_id).make_operation()
