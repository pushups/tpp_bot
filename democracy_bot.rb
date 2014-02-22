require 'cinch'
require 'optparse'
require File.join(File.expand_path(__FILE__), '..', 'lib', 'tpp')

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  opts.on("-t", "--test", "Run in test mode") do |t|
    options[:test] = t
  end
end.parse!

bot = Cinch::Bot.new do
    configure do |c|
      c.port = Tpp::CHAT_PORT

      # Connect to test server if options[:test]
      if options[:test].nil?
        c.user = ENV['TWITCH_USER']
        c.nick = ENV['TWITCH_USER']
        c.server = Tpp::TWITCH_CHAT_HOST
        c.channels = [Tpp::TPP_CHANNEL]
        c.password = ENV['TWITCH_OAUTH']
      else
        c.user = Tpp::TEST_NAME
        c.nick = Tpp::TEST_NAME
        c.server = Tpp::TEST_HOST
        c.channels = [Tpp::TEST_CHANNEL]
      end

    end

    on :message, Tpp::PURE_COMMANDS[:democracy] do |m|
      m.reply Tpp::PURE_COMMANDS[:democracy]
    end

end

bot.start


