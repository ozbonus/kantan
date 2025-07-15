import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/parental_mode/data/equations_list.dart';
import 'package:kantan/src/features/parental_mode/domain/equation.dart';

part 'equations_repository.g.dart';

/// This provider is kept alive because we don't want cheeky kids closing and
/// re-opening the challenge screen over and over again to get a new equation
/// every time.
@Riverpod(keepAlive: true)
class EquationsRepository extends _$EquationsRepository {
  late int index;

  @override
  Equation build() {
    index = Random().nextInt(equationsList.length);
    return equationsList[index];
  }

  void getRandomEquation() {
    var newIndex = Random().nextInt(equationsList.length);
    while (newIndex == index) {
      newIndex = Random().nextInt(equationsList.length);
    }
    index = newIndex;
    state = equationsList[index];
  }
}
