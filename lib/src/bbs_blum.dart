library bbs.blum;

import 'dart:math' show Random, log;

import 'package:bignum/bignum.dart';

import 'bbs_primes.dart' as primes;

class BlumBlumShub implements Random {
  BigInteger n;
  BigInteger state;
  
  BlumBlumShub([int bits = 256, Random random]) {
    this.n = generateN(bits, random);
    var length = this.n.bitLength();
    this.seed = primes.getRandBits(length, random);
  }
  
  void set seed(BigInteger seed) {
    this.state = seed.mod(this.n);
  }
  
  static BigInteger getPrime(int bits, [Random random]) {
    while (true) {
      var p = primes.bigPrime(bits, random);
      if (BigInteger.THREE == p.and(BigInteger.THREE)) return p;
    }
  }
  
  static BigInteger generateN(int bits, [Random random]) {
    var p = getPrime(bits ~/ 2, random);
    while (true) {
      var q = getPrime(bits ~/ 2, random);
      
      if (p != q) return p * q;
    }
  }
  
  BigInteger next(int numBits) {
    var result = new BigInteger(0);
    
    for (int i = 0; i < numBits; i++) {
      this.state = this.state.modPowInt(2, this.n);
      result = toBig(result.shiftLeft(1))
                .or(toBig(this.state.and(BigInteger.ONE)));
    }
    
    return result;
  }
  
  static BigInteger toBig(n) {
    if (n is int ) return new BigInteger(n);
    if (n is BigInteger) return n;
    throw new ArgumentError.value(n);
  }
  
  static int toInt(n) {
    if (n is int ) return n;
    if (n is BigInteger) return int.parse(n.toRadix());
    throw new ArgumentError.value(n);
  }
  
  double nextDouble() =>
      throw new UnimplementedError();
  
  static int neededBits(int max) {
    if (0 == max || 1 == max) return 1;
    return (log(max + 1) / log(2)).ceil(); // +1 because max would be no of possibilites
  }
  
  bool nextBool() {
    return 1 == next(1) ? true : false;
  }
  
  int nextInt(int max) {
    var bits = neededBits(max);
    var _max = toBig(max);
    while (true) {
      var value = next(bits);
      if (value < _max) return toInt(value);
    }
  }
}