import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_riverpod_sample/mutator/user_mutator.dart';
import 'package:my_riverpod_sample/stores/user_store.dart';

final userStoreProvider = ChangeNotifierProvider<UserStore>((_) => UserStore());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'hello'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(builder: (context, ref, _) {
              print('rebuild');
              print(ref.watch(userStoreProvider).value.name);
              return Text(
                ref.watch(userStoreProvider).value.name,
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            TextButton(onPressed: () => UserMutator.fromRef(ref).updateName(name: "たこ焼き"), child: Text('hoge'))
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
