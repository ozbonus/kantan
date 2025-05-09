import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/presentation/player_screen.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen.dart';
import 'package:kantan/src/kantan_player_app.dart';

class AppRoute {
  static String home = 'home';
  static String player = 'player';
  static String transcript = 'transcript';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home,
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            path: AppRoute.player,
            name: AppRoute.player,
            redirect: (context, state) {
              final width = MediaQuery.sizeOf(context).width;
              return width > Config.mediumBreakpoint ? '/' : null;
            },
            builder: (_, __) => const PlayerScreen(),
          ),
          GoRoute(
            path: AppRoute.transcript,
            name: AppRoute.transcript,
            builder: (_, __) => const TranscriptScreen(),
          ),
        ],
      ),
    ],
  );
});
