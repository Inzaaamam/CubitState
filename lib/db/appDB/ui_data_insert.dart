import 'package:cubit/dio/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline data store')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Get DioCubit instance
          await context.read<DioCubit>().service.getData(); // Fetch data first
          await context.read<DioCubit>().addOffline();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
