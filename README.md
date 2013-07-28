# cf3ruby

**context-free DSL for ruby-1.9 and CF3 syntax** 

Very much derived from [context-free.rb][] by Jeremy Ashkenas this version is updated to be more in line with CF3 and ruby 1.9 syntax. Tested as working with last rubygems release of ruby-processing (v 1.0.11) as well as the current [version][] (v 2.1.0).
[context-free.rb]:https://github.com/jashkenas/context_free/
[version]:https://github.com/monkstone/ruby-processing/releases/
## Installation

To use this library you need install jruby (preferably jruby-1.7.4+), you will also need [ruby-processing][] to be installed (minimum version 1.0.11, preferred version 2.1.0). There are three ways you can install this library:-
***rake test and gem install***

Either clone this repository, or download a [snapshot][].

```bash
cd cf3ruby 
jruby -S rake test # builds and tests gem (mouse click on frame for test image to show)
jruby -S gem install cf3-0.0.1.gem # may need sudo access
```

***local bundle install***

Either clone this repository, or download a [snapshot].

```bash
bundle install
```

***gem install from rubygems***
```bash
gem install cf3
```
it couldn't be easier could it?

## Usage

Extract the included samples to your home directory
```bash
jruby -S cf3samples
```

As for running ruby-processing, it requires the external jruby flag
```bash
rp5 run --jruby city.rb # this is why you should install both ruby-processing and cf3ruby using jruby

```
You should read the [ruby-processing_documentation][] on using rubygems.

## Contributing

[Contributing][]
[contributing]:CONTRIBUTING.md
[ruby-processing_documentation]:https://github.com/jashkenas/ruby-processing/wiki/Using-Rubygems/
[snapshot]:https://github.com/monkstone/cf3ruby/releases

![Y](http://3.bp.blogspot.com/-KNBKD7lArMA/UNBayboXQFI/AAAAAAAAD7A/YAgZCewTOxQ/s400/y.png)

