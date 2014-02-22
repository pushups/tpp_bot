module Tpp
  TWITCH_CHAT_HOST = '199.9.253.199'
  CHAT_PORT = '6667'
  TEST_HOST = 'localhost'
  TEST_CHANNEL = '#test'
  TEST_NAME = 'testbot'
  TPP_CHANNEL = '#twitchplayspokemon'

  PURE_COMMANDS = {:a => 'a',
                   :b => 'b',
                   :start => 'start',
                   :select => 'select',
                   :up => 'up',
                   :down => 'down',
                   :left => 'left',
                   :right => 'right',
                   :democracy => 'democracy',
                   :anarchy => 'anarchy'}

  DEMOCRACY_COMMAND_REGEXPS = {:a => /a\d*[\s|$]/,
                               :b => /b\d*[\s|$]/,
                               :start => /start\d*[\s|$]/,
                               :select => /select\d*[\s|$]/,
                               :up => /up\d*[\s|$]/,
                               :down =>  /down\d*[\s|$]/,
                               :left => /left\d*[\s|$]/,
                               :right => /right\d*[\s|$]/,
                               :democracy => /democracy/,
                               :anarchy => /anarchy/}
end