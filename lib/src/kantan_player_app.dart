import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_screen.dart';
import 'package:kantan/src/routing/app_router.dart';

class KantanPlayerApp extends ConsumerWidget {
  const KantanPlayerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: Config.appTitle,
      routerConfig: goRouter,
      restorationScopeId: 'app',
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TrackListScreen();
  }
}
