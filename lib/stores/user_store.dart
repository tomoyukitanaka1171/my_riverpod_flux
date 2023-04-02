import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_riverpod_sample/state_flow/state_flow.dart';

part 'user_store.freezed.dart';

@freezed
class UserState with _$UserState implements ImmutableState {
  const factory UserState({
    @Default('') String userId,
    @Default('ななし') String name,
    int? age,
  }) = _UserState;
  const UserState._();
}

class UserStore extends StateFlow<UserState> {
  @override
  late UserState value;

  UserStore() : value = const UserState();
}
