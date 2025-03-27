// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_translation_switch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showTranslationSwitchControllerHash() =>
    r'078af421b3e4e122161748cfa6ab0d1101e34f48';

/// Provides a state for the [ShowTranslationSwitch] widget in the player
/// controls of the transcript screen.
///
/// Depending on the state, the switch may be active or inactive, on or off.
///
/// Returns a [ShowTranslationSwitchState] which is a record comprising two
/// boolean values, [isActive] and [value]. [isActive] will be true if the
/// current track has a translation available. [value] corresponds to whether
/// the translation, if available, will be shown or not.
///
/// Copied from [ShowTranslationSwitchController].
@ProviderFor(ShowTranslationSwitchController)
final showTranslationSwitchControllerProvider = AutoDisposeNotifierProvider<
    ShowTranslationSwitchController, ShowTranslationSwitchState>.internal(
  ShowTranslationSwitchController.new,
  name: r'showTranslationSwitchControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showTranslationSwitchControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowTranslationSwitchController
    = AutoDisposeNotifier<ShowTranslationSwitchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
