import 'package:flutter/material.dart';

abstract class ImmutableState {
  const ImmutableState();
}

typedef ModelUpdate<T> = T Function(T prev);

abstract class StateFlow<T extends ImmutableState> extends ChangeNotifier {
  T get value;
  set value(T v);

  var mounted = false;

  StateFlow() : mounted = true;

  @override
  @mustCallSuper
  void dispose() {
    mounted = false;
    super.dispose();
  }

  bool _compare(T prev, T update) => prev == update;

  void _update(ModelUpdate<T> updator) {
    final prevValue = value;
    final nextValue = updator(value);
    if (!_compare(prevValue, nextValue)) {
      value = nextValue;
    }

    notifyListeners();
  }
}

mixin Mutator {
  List<ImmutableState> get states;

  void mutate<ST extends StateFlow<ImmutableState>>(ModelUpdate<ImmutableState> updator) {
    states.whereType<ST>().map((s) {
      s._update(updator);
    });
  }
}
