# from schema import And, Optional, Use
# from datetime import datetime
# import pytz
#
#
# class AutoInfo:
#     SUPPORTED_PATH = "/predict"
#
#     ERR_TEAM_LEN = 'team length should be between 3 and 10'
#     ERR_USER_LEN = 'user length should be between 1 and 100'
#     ERR_DOCUMENT_ID_LEN = 'documentId length should be between 1 and 100'
#     ERR_FILE_NAME_LEN = 'fileName length should be between 1 and 150'
#
#     # Field constants
#     TEAM = "team"
#     USER = "user"
#     DOCUMENT_ID = "documentId"
#     FILE_ID = "fileName"
#     XPATH_STRING_LIST = "xpathStringList"
#     DATAPOINT_STRING_LIST = "datapointStringList"
#
#     DEFAULT_SCHEMA_FIELDS = {
#         TEAM: And(Use(str), lambda s: 3 <= len(s) <= 10, error=ERR_TEAM_LEN),
#         USER: And(Use(str), lambda s: 1 <= len(s) <= 100, error=ERR_USER_LEN),
#         DOCUMENT_ID: And(Use(str), lambda s: 1 <= len(s) <= 100, error=ERR_DOCUMENT_ID_LEN),
#         Optional(FILE_ID): And(Use(str), lambda s: 1 <= len(s) <= 150, error=ERR_FILE_NAME_LEN),
#     }
#
#     def __init__(self):
#         self.team = None
#         self.user = None
#         self.doc_id = None
#         self.file_name = None
#         self.xpath_str_list = None
#         self.datapoint_str_list = None
#         self.process = None
#         self.lambda_last_event_time = datetime.now(pytz.utc)
#
#     def build(self, body):
#         self.team = body["team"]
#         self.user = body["user"]
#         self.doc_id = body["documentId"]
#         self.file_name = body["fileName"] or ""
#
#     def build_auto_xpath_list(self, body):
#         self.build(body)
#         self.process = "ADDITION"
#         self.xpath_str_list = body["xpathStringList"]
#         return self
#
#     def build_auto_datapoint_list(self, body):
#         self.build(body)
#         self.process = "DELETION"
#         self.datapoint_str_list = body["datapointStringList"]
#         return self
