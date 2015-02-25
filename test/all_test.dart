library bbs.test;

import 'dart:math' show Random;

import 'package:mock/mock.dart';
import 'package:bbs/bbs.dart';

import 'bbs_primes_test.dart';
import 'bbs_blum_test.dart';

main() {
  definePrimeTests();
  defineBlumTests();
}


@proxy
class RandomMock extends Mock implements Random {
  noSuchMethod(inv) => super.noSuchMethod(inv);
}