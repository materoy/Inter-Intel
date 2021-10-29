import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

const dictionary = {
  '34': 'thirty-four',
  '90': 'ninety',
  '91': 'ninety-one',
  '21': 'twenty-one',
  '61': 'sixty-one',
  '9': 'nine',
  '2': 'two',
  '6': 'six',
  '3': 'three',
  '8': 'eight',
  '80': 'eighty',
  '81': 'eighty-one',
  'Ninety-Nine': '99',
  'nine-hundred': '900'
};

Map<dynamic, dynamic> sortDictionary(Map dict) {
  final sorted =
      SplayTreeMap<dynamic, dynamic>.from(dict, (dynamic a, dynamic b) {
    final x = int.tryParse(a.toString()) ?? a.toString();
    final y = int.tryParse(b.toString()) ?? b.toString();
    if (x is int && y is int) {
      return x > y ? 1 : -1;
    } else if (x is! int && b is! int) {
      for (var i = 0; i < min(x.toString().length, y.toString().length); i++) {
        if (x.toString().codeUnitAt(i) == y.toString().codeUnitAt(i)) {
          continue;
        } else {
          return x.toString().codeUnitAt(i) > y.toString().codeUnitAt(i)
              ? 1
              : -1;
        }
      }

      return x.toString().codeUnitAt(0) > y.toString().codeUnitAt(0) ? 1 : -1;
    } else if (x is! int) {
      return 1;
    } else {
      return -1;
    }
  });
  return sorted;
}

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late final Map sortedDictionary;

  @override
  void initState() {
    super.initState();
    sortedDictionary = sortDictionary(dictionary);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sortedDictionary.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sortedDictionary.entries.toList()[index].key.toString()),
          subtitle:
              Text(sortedDictionary.entries.toList()[index].value.toString()),
        );
      },
    );
  }
}
