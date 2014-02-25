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

class DemocracyBot < Cinch::Bot
  attr_accessor :action_count
  attr_accessor :last_action_time

  def within_cooldown_window?
    Time.now.millis - last_action_time < Tpp::TWITCH_ACTION_LIMIT_TIME_WINDOW
  end

  def self.reply_throttled(cinch_message, text)
      if action_count < Tpp::TWITCH_ACTION_LIMIT - 1
        cinch_message.reply text
        @action_count += 1
        @last_action_time = Time.now.millis
      end

      if !within_cooldown_window?
        @action_count = 0
      end
  end

  def initialize(test, &block)
    super &block
    @action_count = 0
    @last_action_time = 0

    configure do |c|
      c.port = Tpp::CHAT_PORT

      # Connect to test server if options[:test]
      if test.nil?
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
      reply_throttled(m, Tpp::PURE_COMMANDS[:democracy])
    end

    if block_given?
      yield
    end
  end
end

bot = DemocracyBot.new options[:test]
bot.start


