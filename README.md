# my_riverpod_sample

My sample app for come true flux application.
There was so many influence from hatchin.
↓
https://hachibeechan.hateblo.jp/entry/change-notifier-does-not-solve-anything-by-itselfs

### Dependency
For immutability, using freezed.
https://pub.dev/packages/freezed

And for Listening these changes I use RiverPod.
But It's OK using Provider.

### Store
You can create store the below code.
```
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
```
StateFlow has [ImmutableState].
And It has method for [notifyListeners] and update these state.(But cannot update store by itself)

### mutator
Store cannot update by itself.
Because there are many usecase for update store.

So, mutator can update store only.
```
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
```

Mutator has some stores and can invoke everywhere if in Widget.
Also, Mutator has side effect to stores.
To enable them, you should declare method for update store.
Like this.
```
    void updateName({required String name}) {
      mutate((UserState prev) => prev.copyWith(name: name));
    }
```
Mutate is enable to transaction, so you can don't care about If It's same between prev and after update.