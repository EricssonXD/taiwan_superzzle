import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taiwan_superzzle/utils/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.navigateTo(const SuperzzleRoute()),
            child: const Text("Start Game"),
          ),
          ElevatedButton(
            onPressed: () => context.navigateTo(const SettingsRoute()),
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }
}
