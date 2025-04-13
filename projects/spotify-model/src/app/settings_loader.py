import os
import configparser
import logging
import json

DEFAULT_ENV_FILE = "../../resources/app_env/local.ini"
ERR_COULD_NOT_VARIABLES = 'It could NOT load the env variables'


class SettingsLoader(object):
    """
    Configuration class to loa:d the properties depending on the environment
    """

    @staticmethod
    def validate_config(config):
        """
        It can not load the file the sections or groups in the config files will be empty
        :param config:
        :return:
        """
        if not config.sections():
            raise RuntimeError(ERR_COULD_NOT_VARIABLES)

    def __new__(cls, *args, **kwargs):
        """
        It loads the file configuration if it can load it will through an error
        """
        if not hasattr(cls, 'instance'):
            cls.instance = super(SettingsLoader, cls).__new__(cls)
            config = configparser.ConfigParser()
            config.read(os.environ.get('APP_ENV') or DEFAULT_ENV_FILE)
            cls.validate_config(config)
            cls.debug_mode(config)
            cls.conf = config
        return cls.instance

    @staticmethod
    def debug_mode(config):
        """Configure the logger singleton to make visible the logs"""
        if json.loads(config['sysadmin']['enable'].lower()):
            logger = logging.getLogger()
            logger.setLevel(logging.DEBUG)
        else:
            logging.getLogger('boto').setLevel(logging.ERROR)
