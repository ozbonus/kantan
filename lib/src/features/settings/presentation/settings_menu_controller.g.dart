// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_menu_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsMenuControllerHash() =>
    r'489d859efcc1a6724b73ef8bffabe8425ca399f2';

/// Provides visibility settings for the various switches and selectors in the
/// settings menu. A widget's visibility is determined by whether its respective
/// feature is enabled and if the ability to control that feature is under the
/// domain of the parental mode feature if the parental mode feature is enabled.
///
/// Copied from [settingsMenuController].
@ProviderFor(settingsMenuController)
final settingsMenuControllerProvider =
    AutoDisposeProvider<VisibleSettings>.internal(
      settingsMenuController,
      name: r'settingsMenuControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsMenuControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsMenuControllerRef = AutoDisposeProviderRef<VisibleSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
