import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_riverpod_sample/stores/user_store.dart';

final helloWorldProvider = Provider((_) => 'Hello world');
final userStoreProvider = Provider((_) => UserStore());
