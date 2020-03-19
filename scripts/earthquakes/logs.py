import logging


class Log:
    logging.basicConfig(filename='../../logs/earthquakes-application.log', level=logging.DEBUG)

    @classmethod
    def debug(cls, text):
        logging.debug(text)

    @classmethod
    def info(cls, text):
        logging.info(text)

    @classmethod
    def warning(cls, text):
        logging.warning(text)

    @classmethod
    def error(cls, text):
        logging.error(text)
