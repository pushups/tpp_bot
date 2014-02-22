require 'log4r'
include Log4r

# Initialize the logger
MESSAGES_LOGGER_NAME = 'messages_logger'
MESSAGES_FILE_OUTPUTTER = 'messages_file_outputter'
MESSAGES_FILE_OUTPUTTER = File.join(File.expand_path(__FILE__),
                                   '..', 'logs', 'tpp.messages.log')

messages_logger = Logger.new MESSAGES_LOGGER_NAME
messages_logger.outputters = FileOutputter.new(MESSAGES_FILE_OUTPUTTER,
                                               :filename => MESSAGES_FILE_OUTPUTTER)

