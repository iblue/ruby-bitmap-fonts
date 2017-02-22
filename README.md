# ruby-bitmap-fonts

This gem allows you to render text using BDF (<i>Glyph
Bitmap Distribution Format</i>) fonts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-bitmap-fonts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-bitmap-fonts

## Usage

This is an early alpha version, so this is the documentation:

```
my_string = "just a test"

font   = BDF::Font.from_file("fixtures/ter-u12b.bdf")
canvas = BDF::Renderer.render(my_string, :font => font)

# => canvas.to_a now contains a 2-dimensional array with ones and
zeroes, representing the pixel values

puts canvas.to_a.map do |line|
  line.map { |x| x == 1 ? "#" : " " }.join
end.join("\n")

# Prints:
#
#    #
#    #               #                       #                 #
#                    #                       #                 #
#   ## #   #  ####  ###         ###         ###   ###   ####  ###
#    # #   # #       #             #         #   #   # #       #
#    # #   #  ###    #          ####         #   #####  ###    #
#    # #   #     #   #         #   #         #   #         #   #
#    # #   #     #   #         #   #         #   #         #   #
#    #  #### ####     ##        ####          ##  #### ####     ##
# #  #
#  ##

```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/iblue/ruby-bitmap-fonts.

