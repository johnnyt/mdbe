# MDBE
[![Version][Version image]][Version]
[![Build][Build image]][Build]

MDBE is a version of [maglev-database-explorer-gem](maglev-database-explorer-gem)
which uses Sinatra instead of Rails.

MDBE is a Sinatra application that allow you to view and modify objects
persisted in MagLev/GemStone and to debug Rails applications.

http://www.youtube.com/watch?v=27mS1BNP7wQ


### Installation

    gem install mdbe


### Usage

    mdbe


You can access MDBE at this URL: `http://localhost:9292//`


### Contributing

If you'd like to contribute, that's awesome. There's a guide to contributing
(both code and general help) over in [CONTRIBUTING.md](CONTRIBUTING.md)


### Development

To see what has changed in recent versions, see the [CHANGELOG.md](CHANGELOG.md).


### License

Copyright 2013-2014 Matthias Springer, Kirstin Heidler, Stefan Bunk,
Dimitri Korsch, Nicco Kunzmann, JohnnyT

Licensed under the MIT License

[maglev-database-explorer-gem]: https://github.com/matthias-springer/maglev-database-explorer-gem

[Version]: https://rubygems.org/gems/mdbe
[Build]: https://travis-ci.org/johnnyt/mdbe
[Coverage]: https://coveralls.io/r/johnnyt/mdbe

[Version image]: https://badge.fury.io/rb/mdbe.png
[Build image]: https://travis-ci.org/johnnyt/mdbe.png
[Coverage image]: https://coveralls.io/repos/johnnyt/mdbe/badge.png?branch=master
