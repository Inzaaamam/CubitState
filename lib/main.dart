import 'package:cubit/db/appDB/ui_data_insert.dart';
import 'package:cubit/dio/cubit/cubit.dart';
import 'package:cubit/dio/cubit/ui_screen.dart';
import 'package:cubit/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DioCubit(service: Services())..get(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const OfflineScreen()),
    );
  }
}
