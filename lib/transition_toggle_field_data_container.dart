import 'package:flutter/material.dart';

class TransitionToggleFieldDataContainer {
  String initValue;
  List<String> options;
  ValueChanged<String?> onChanged;

  TransitionToggleFieldDataContainer({
    required this.initValue,
    required this.options,
    required this.onChanged
  });
}