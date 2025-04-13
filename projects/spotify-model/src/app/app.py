from model_service import ModelService

ERR_WRONG_PATH = 'Path not supported'

def handler(event, context):
    """
    Lambda main method
    """
    body = event.get('body') or {}
    requestContext = event.get("requestContext", {})
    http_method = requestContext.get("http", {}).get("method","null")
    request_id = requestContext.get("requestId", "null")
    return ModelService(body=body, http_method=http_method, request_id=request_id).make_operation()
