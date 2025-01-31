import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PeopleCount with ChangeNotifier {
  int adultPrice = 20000;
  int kidsPrice = 10000;
  int visitorPrice = 10000;
  int? adult;
  int? kids;
  int? visitor;
}
