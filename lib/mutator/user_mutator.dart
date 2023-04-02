import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_riverpod_sample/main.dart';
import 'package:my_riverpod_sample/state_flow/state_flow.dart';
import 'package:my_riverpod_sample/stores/user_store.dart';

/// If I use [StateNotifier], I don't need to use it?
class UserMutator with Mutator {
  @override
  final List<StateFlow<ImmutableState>> states;

  UserMutator({required UserStore userStore}) : states = [userStore];

  factory UserMutator.fromRef(WidgetRef ref) {
    return UserMutator(userStore: ref.read(userStoreProvider));
  }

  void updateName({required String name}) {
    mutate((UserState prev) => prev.copyWith(name: name));
  }
}
