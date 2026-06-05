import 'package:bloc_struc/screen/list/bloc/list_bloc.dart';
import 'package:bloc_struc/screen/list/list_screen.dart';
import 'package:bloc_struc/screen/login/bloc/login_bloc.dart';
import 'package:bloc_struc/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utiles/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ListBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            primaryColor: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 18),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, style: BorderStyle.solid,color:  Colors.black12)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width:1, color: Colors.redAccent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width:1, style: BorderStyle.solid, color: Colors.black12)
              ),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.blue.withValues(alpha: 0.3)),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(Colors.black)).copyWith(secondary: Colors.black)
        ),
        home: const ListScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
