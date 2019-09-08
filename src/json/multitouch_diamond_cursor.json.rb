#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./multitouch_diamond_cursor.json.rb
#

require 'json'
require_relative '../lib/karabiner.rb'

def main
  #
  # conditions
  #

  condition1 = Karabiner.variable_if('multitouch_extension_finger_count_total', 1)
  condition2 = Karabiner.variable_unless('multitouch_extension_finger_count_total', 0)

  #
  # manipulators
  #

  manipulators = []

  [
    #
    # Finger count == 1
    #

    {
      :from => { 'key_code' => 'w' },
      :to => { 'key_code' => 'up_arrow' },
      :conditions => [condition1],
    },
    {
      :from => { 'key_code' => 's' },
      :to => { 'key_code' => 'down_arrow' },
      :conditions => [condition1],
    },
    {
      :from => { 'key_code' => 'a' },
      :to => { 'key_code' => 'left_arrow' },
      :conditions => [condition1],
    },
    {
      :from => { 'key_code' => 'd' },
      :to => { 'key_code' => 'right_arrow' },
      :conditions => [condition1],
    },

    #
    # Finger count >= 2
    #

    {
      :from => { 'key_code' => 'w' },
      :to => { 'key_code' => 'page_up' },
      :conditions => [condition2],
    },
    {
      :from => { 'key_code' => 's' },
      :to => { 'key_code' => 'page_down' },
      :conditions => [condition2],
    },
    {
      :from => { 'key_code' => 'a' },
      :to => { 'key_code' => 'home' },
      :conditions => [condition2],
    },
    {
      :from => { 'key_code' => 'd' },
      :to => { 'key_code' => 'end' },
      :conditions => [condition2],
    },
  ].each do |d|
    manipulators << {
      'type' => 'basic',
      'from' => d[:from],
      'to' => [
        d[:to],
      ],
      'conditions' => d[:conditions],
    }
  end

  puts JSON.pretty_generate(
    'title' => 'Multitouch Diamond Cursor (rev 1)',
    'maintainers' => ['tekezo'],
    'rules' => [
      'description' => 'Multitouch Diamond Cursor (rev 1)',
      'available_since' => '12.6.9',
      'manipulators' => manipulators,
    ]
  )
end

main
