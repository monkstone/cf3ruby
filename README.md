# cf3ruby

**context-free DSL for ruby-1.9 and CF3 syntax** 

Very much derived from [context-free.rb][] by Jeremy Ashkenas this version is updated to be more in line with CF3 and ruby 1.9 / 2.0 syntax. Tested as working with the current and much earlier rubygems releases of ruby-processing (2.4.2 and 1.0.11).
[version]:https://github.com/monkstone/ruby-processing/releases/
## Installation

To use this library you need install jruby (preferably jruby-1.7.9+), you will also need [ruby-processing][] to be installed (minimum version 1.0.11, preferred version 2.4.3). There are three ways you can install this library:-

***rake test and gem install***

Either clone this repository, or download a [snapshot][].

```bash
cd cf3ruby 
jruby -S rake test # builds and tests gem (mouse click on frame for test image to show)
jruby -S gem install cf3-0.0.5.gem # may need sudo access
```

***local bundle install***

Either clone this repository, or download a [snapshot].

```bash
cd cf3
bundle install          # using regular installed bundler may need to set GEM_PATH
jruby -S bundle install # if you installed bundler with jruby
```

***gem install from rubygems***
```bash
gem install cf3            # regular install may need to set GEM_PATH env variable
jruby -S gem install cf3   # jruby install 
```
it couldn't be easier could it?

## Usage

Extract the included samples to your home directory (HOME/cf3work/samples)
```bash
cf3samples           # should work
jruby -S cf3samples  # else if installed with jruby this should also work
```

As for running ruby-processing, ( _it requires the external jruby flag prior to ruby-processing-2.1.2_ )
```bash
rp5 run city.rb # providing you installed both ruby-processing and cf3ruby using jruby

```
You should read the [ruby-processing_documentation][] on using rubygems.

## Contributing

[Contributing][]
[contributing]:CONTRIBUTING.md
[ruby-processing]:https://github.com/jashkenas/ruby-processing/
[ruby-processing_documentation]:https://github.com/jashkenas/ruby-processing/wiki/Using-Rubygems/
[snapshot]:https://github.com/monkstone/cf3ruby/releases
[context-free.rb]:https://github.com/jashkenas/context_free

![Y](http://3.bp.blogspot.com/-KNBKD7lArMA/UNBayboXQFI/AAAAAAAAD7A/YAgZCewTOxQ/s400/y.png)

