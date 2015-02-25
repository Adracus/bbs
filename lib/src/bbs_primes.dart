library bbs.primes;

import 'dart:math' show Random;

import 'package:bignum/bignum.dart' show BigInteger;

BigInteger bigPrime([int bits = 256, Random random]) {
  var candidate = getRandBits(bits, random);
  
  candidate = candidate.or(BigInteger.ONE); // Ensure uneven
  
  while (true) {
    if (candidate.isProbablePrime(5)) return candidate;
    candidate = candidate + new BigInteger(2);
  }
}

BigInteger getRandBits(int n, [Random random]) {
  if (0 >= n) throw new ArgumentError.value(n);
  if (null == random) random = new Random();
  
  var l = new List.generate(n, (_) => random.nextInt(2));
  var i = 0;
  return l.fold(new BigInteger(0), (BigInteger acc, int c) {
    i++;
    if (0 == c) {
      return acc;
    }
    return acc + new BigInteger(2).pow(i - 1);
  });
}