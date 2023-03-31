import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_riverpod_sample/provider/read_provider.dart';
import 'package:my_riverpod_sample/state_flow/state_flow.dart';
import 'package:my_riverpod_sample/stores/user_store.dart';

class UserMutator with Mutator {
  @override
  final List<UserState> states;

  UserMutator({required UserStore userStore}) : states = [];

  factory UserMutator.fromRef(WidgetRef ref) {
    return UserMutator(userStore: ref.read(userStoreProvider));
  }
}
