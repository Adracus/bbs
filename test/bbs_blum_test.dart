library bbs.test.blum;

import 'package:bbs/bbs.dart';
import 'package:bignum/bignum.dart';

import 'package:mock/mock.dart';
import 'package:unittest/unittest.dart';

import 'all_test.dart';

defineBlumTests() {
  group("BlumBlumShub", () {
    test("getPrime", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  Last bits (smallest value)
            .thenReturn(0, 4); // Leading bits (highest value)
      
      var prime = BlumBlumShub.getPrime(10, random);
      expect(prime, equals(new BigInteger(67)));
      random.calls("nextInt", 2).verify(happenedExactly(10));
    });
    
    test("generateN", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3); // SECOND NUMBER: Leading bits (highest value)
      
      var n = BlumBlumShub.generateN(20, random);
      expect(n, equals(new BigInteger(127 * 67)));
      random.calls("nextInt", 2).verify(happenedExactly(20));
    });
    
    test("neededBits", () {
      expect(BlumBlumShub.neededBits(1), equals(1));
      expect(BlumBlumShub.neededBits(0), equals(1));
      expect(BlumBlumShub.neededBits(2), equals(2));
      expect(BlumBlumShub.neededBits(3), equals(2));
      expect(BlumBlumShub.neededBits(4), equals(3));
      expect(BlumBlumShub.neededBits(64), equals(7));
      expect(BlumBlumShub.neededBits(63), equals(6));
    });
    
    test("toInt", () {
      expect(BlumBlumShub.toInt(new BigInteger("13123124")), equals(13123124));
      expect(BlumBlumShub.toInt(1234567), equals(1234567));
      expect(() => BlumBlumShub.toInt("ABCDEFG"), throws);
    });
    
    test("toBig", () {
      expect(BlumBlumShub.toBig(new BigInteger("13123124")),
          equals(new BigInteger("13123124")));
      expect(BlumBlumShub.toBig(1234567), equals(new BigInteger("1234567")));
      expect(() => BlumBlumShub.toBig("ABCDEFG"), throws);
    });
    
    test("Constructor", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3) //  SECOND NUMBER: Leading bits (highest value)
            .thenReturn(1, 9) //  THIRD NUMBER:  Last bits (smallest value)
            .thenReturn(0, 5); // THIRD NUMBER:  Leading bits (highest value)
      
      var bbs = new BlumBlumShub(20, random);
      
      expect(bbs.n, equals(new BigInteger(127 * 67)));
      expect(bbs.state, equals(new BigInteger(511).mod(bbs.n)));
      random.calls("nextInt", 2).verify(happenedExactly(34));
    });
    
    test("next", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3) //  SECOND NUMBER: Leading bits (highest value)
            .thenReturn(1, 9) //  THIRD NUMBER:  Last bits (smallest value)
            .thenReturn(0, 5); // THIRD NUMBER:  Leading bits (highest value)
      
      var bbs = new BlumBlumShub(20, random);
      
      expect(bbs.next(100),
          equals(new BigInteger("732284370505661508444573069903")));
    });
    
    test("nextInt", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3) //  SECOND NUMBER: Leading bits (highest value)
            .thenReturn(1, 9) //  THIRD NUMBER:  Last bits (smallest value)
            .thenReturn(0, 5); // THIRD NUMBER:  Leading bits (highest value)
      
      var bbs = new BlumBlumShub(20, random);
      
      expect(bbs.nextInt(100),
          equals(new BigInteger(73)));
    });
    
    test("nextBool", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3) //  SECOND NUMBER: Leading bits (highest value)
            .thenReturn(1, 9) //  THIRD NUMBER:  Last bits (smallest value)
            .thenReturn(0, 5); // THIRD NUMBER:  Leading bits (highest value)
      
      var bbs = new BlumBlumShub(20, random);
      
      expect(bbs.nextBool(), false);
    });
    
    test("nextDouble", () {
      var random = new RandomMock();
      random.when(callsTo("nextInt", 2))
            .thenReturn(1, 6) //  FIRST NUMBER:  Last bits (smallest value)
            .thenReturn(0, 4) //  FIRST NUMBER:  Leading bits (highest value)
            .thenReturn(1, 7) //  SECOND NUMBER: Last bits (smallest value)
            .thenReturn(0, 3) //  SECOND NUMBER: Leading bits (highest value)
            .thenReturn(1, 9) //  THIRD NUMBER:  Last bits (smallest value)
            .thenReturn(0, 5); // THIRD NUMBER:  Leading bits (highest value)
      
      var bbs = new BlumBlumShub(20, random);
      
      expect(() => bbs.nextDouble(), throws, reason: "Implementation needs test");
    });
  });
}