library bbs.example;

import 'package:bbs/bbs.dart';

main() {
  var bbs = new BlumBlumShub();
  
  print(bbs.next(10));
  print(bbs.nextInt(100));
  // print(bbs.nextDouble()); This is currently not supported
  print(bbs.nextBool());
}
