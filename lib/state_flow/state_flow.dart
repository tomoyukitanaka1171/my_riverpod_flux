import 'package:flutter/material.dart';

abstract class ImmutableState {
  const ImmutableState();
}

typedef ModelUpdate<T> = T Function(T prev);

/// maybe, state_notifier come true same purpose?
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
      print('notify${value}');
      notifyListeners();
    } else {}
  }
}

mixin Mutator {
  List<StateFlow<ImmutableState>> get states;

  void mutate<I extends ImmutableState, S extends StateFlow<I>>(ModelUpdate<I> updator) {
    states.whereType<S>().forEach((s) {
      s._update(updator);
    });
  }
}
