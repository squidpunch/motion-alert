# Motion-Alert
[![Build Status](https://travis-ci.org/squidpunch/motion-alert.svg?branch=master)](https://travis-ci.org/squidpunch/motion-alert)
[![Gem Version](https://badge.fury.io/rb/motion-alert.svg)](http://badge.fury.io/rb/motion-alert)

Want to just show an alert to your no matter what version of iOS you are on?
Motion-alert is for you.  Did you know `UIAlert` is deprecated in iOS 8?  You
should be using `UIAlertController` but if you use that controller on a prior
iOS version, you're bound to have a bad time.  **Motion Alert** manages this for
you, you just say you want an alert, buttons to show and the actions on those
buttons and Motion Alert handles the rest.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-alert'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-alert

## Usage

    def show_alert
      Motion::Alert.new(title: "Alert!", message:"message").tap do |a|
        a.add_action("OK", Proc.new { puts 'OK!' })
        a.add_action("Cancel", Proc.new { puts 'Cancel!' })
        a.show
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
