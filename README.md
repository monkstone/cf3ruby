# cf3ruby

*This is forked version of [monkstone/cf3ruby](https://github.com/monkstone/cf3ruby). Updated to be compatible with ruby 2.4, JRubyArt 1.4.4 (newer version of ruby-processing), and Processing 3+.*

**context-free DSL for ruby-2.4 and CF3 syntax**

Very much derived from [context-free.rb](https://github.com/jashkenas/context_free) by Jeremy Ashkenas this version is updated to be more in line with CF3 and ruby 1.9 / 2.0 syntax. Tested as working with the current and much earlier rubygems releases of ruby-processing (2.4.3 and 1.0.11).

## Installation

To use this library you need install jruby (preferably jruby-9.1+), you will also need [ruby-processing/JRubyArt](https://github.com/ruby-processing/JRubyArt) to be installed (preferred version 1.4.4). There are three ways you can install this library:-

***rake test and gem install***

Clone this repository,

```bash
cd cf3ruby
jruby -S rake test # builds and tests gem (mouse click on frame for test image to show)
jruby -S gem install cf3-1.0.0.gem # may need sudo access
```

***local bundle install***

Clone this repository,

```bash
cd cf3ruby
# bundle install          # using regular installed bundler may need to set GEM_PATH
jruby -S bundle install # if you installed bundler with jruby
```

***gem install from rubygems***

```bash
# Note: This method is unavailable for this forked version. sorry.

# gem install cf3            # regular install may need to set GEM_PATH env variable
# jruby -S gem install cf3   # jruby install
```
it couldn't be easier could it?

## Usage

Extract the included samples to your home directory (HOME/cf3work/samples)
```bash
cf3samples           # should work
jruby -S cf3samples  # else if installed with jruby this should also work
```

As for running ruby-processing,
```bash
k9 --run city.rb # providing you installed both ruby-processing (JRubyArt) and cf3ruby using jruby

```
You should read the [JRubyArt documentation](https://github.com/ruby-processing/JRubyArt/blob/master/README.md) on using rubygems.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

![Y](http://3.bp.blogspot.com/-KNBKD7lArMA/UNBayboXQFI/AAAAAAAAD7A/YAgZCewTOxQ/s400/y.png)
