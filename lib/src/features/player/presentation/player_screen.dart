import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/src/routing/app_router.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => context.goNamed(AppRoute.home),
                child: const Text('Go to Home Screen'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => context.goNamed(AppRoute.transcript),
                child: const Text('Go to Transcript Screen'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
