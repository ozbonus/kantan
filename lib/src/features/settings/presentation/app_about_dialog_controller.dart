import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_about_dialog_controller.g.dart';

@riverpod
Future<PackageInfo> appAboutDialogController(Ref ref) async {
  try {
    return await PackageInfo.fromPlatform();
  } catch (error, stackTrace) {
    log('Error getting information for about dialog: $error');
    log('Stack trace: $stackTrace');
    rethrow;
  }
}
