from model_service import ModelService

ERR_WRONG_PATH = 'Path not supported'

def handler(event, context):
    """
    Lambda main method
    """
    body = event.get('body') or {}
    request_context = event.get("requestContext", {})
    http_method = request_context.get("http", {}).get("method","null")
    request_id = request_context.get("requestId", "null")
    return ModelService(body=body, http_method=http_method, request_id=request_id).make_operation()
