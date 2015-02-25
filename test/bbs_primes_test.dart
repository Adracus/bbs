library bbs.test.primes;

import 'package:bbs/bbs.dart';
import 'package:bignum/bignum.dart';

import 'package:mock/mock.dart';
import 'package:unittest/unittest.dart';

import 'all_test.dart';

definePrimeTests() {
  group("Primes", () {
    test("getRandBits", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1) // Last bits (smallest value)
            .thenReturn(0)
            .thenReturn(1, 4)
            .thenReturn(0, 4); // Leading bits (highest value)
      
      var n = getRandBits(10, random);
      expect(n, equals(new BigInteger(61)));
      random.calls("nextInt", 2).verify(happenedExactly(10));
    });
    
    test("bigPrime", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) // Last bits (smallest value)
            .thenReturn(0, 4); // Leading bits (highest value)
      
      var n = bigPrime(10, random);
      expect(n, equals(new BigInteger(67)));
      random.calls("nextInt", 2).verify(happenedExactly(10));
    });
  });
}