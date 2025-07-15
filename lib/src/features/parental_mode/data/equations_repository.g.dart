// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$equationsRepositoryHash() =>
    r'60b1eb8e92a8eb7ab236ca1084c2406ad76a88cf';

/// This provider is kept alive because we don't want cheeky kids closing and
/// re-opening the challenge screen over and over again to get a new equation
/// every time.
///
/// Copied from [EquationsRepository].
@ProviderFor(EquationsRepository)
final equationsRepositoryProvider =
    NotifierProvider<EquationsRepository, Equation>.internal(
      EquationsRepository.new,
      name: r'equationsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$equationsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EquationsRepository = Notifier<Equation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
