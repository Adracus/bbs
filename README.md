# bbs
[![Build Status](https://travis-ci.org/Adracus/bbs.svg?branch=master)](https://travis-ci.org/Adracus/bbs)
[![Coverage Status](https://coveralls.io/repos/Adracus/bbs/badge.svg?branch=master)](https://coveralls.io/r/Adracus/bbs?branch=master)

Implementation of the BlumBlumShub algorithm adapted from [VSpikes python implementation](https://github.com/VSpike/BBS). This provides an easy to
use interface of the BBS CSPRNG (Cryptographically Secure Pseudo Random
Number Generator).

> **Warning:** This implementation has not been tested in production nor has it
> been examined by a security audit. All uses are your own responsibility.

## Caveats

This CSPRNG is just as secure as the primes which are used to generate random numbers. By
default, this implementation uses two 128 bit primes (which you can change by passing
a custom bit amount to the `BlumBlumShub` constructor).

## Usage

As this CSPRNG implements the `dart:math.Random` interface, all familiar methods like
`nextInt` and `nextBool`. Currently, `nextDouble` is not implemented and will raise an
UnimplementedError. To instantiate a `BlumBlumShub` generator, proceed as follows:

```dart
var bbs = new BlumBlumShub();
```

If you want to change the amount of bits used by a generator, instantiate it passing
the desired number of bits to use (_CAUTION_: The number of bits is divided by two
because two primes have to be created).

```dart
var bbs = new BlumBlumShub(1024);
```

After you've instantiated a generator, use it as you wish.

```dart
bbs.nextInt(100);
bbs.next(100); // Generates a 100 bit BigInteger value
bbs.nextBool();
```

## Features and bugs

If you want a feature: Pull requests are always welcome.
For bugs, open an issue or also: Pull request.
