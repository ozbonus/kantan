import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/features/parental_mode/application/math_challenge_service.dart';

class MathChallengeScreen extends ConsumerStatefulWidget {
  const MathChallengeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MathChallengeScreenState();
}

class _MathChallengeScreenState extends ConsumerState<MathChallengeScreen>
    with TickerProviderStateMixin {
  late TextEditingController textController;
  late AnimationController buttonAnimationController;
  late AnimationController sheetAnimationController;
  int failedAttempts = 0;
  bool buttonEnabled = true;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    buttonAnimationController = AnimationController(
      vsync: this,
      duration: Config.shakeDuration,
    );
    sheetAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    textController.dispose();
    buttonAnimationController.dispose();
    sheetAnimationController.dispose();
    super.dispose();
  }

  void checkAnswer(BuildContext context, WidgetRef ref) async {
    final correct = ref
        .read(mathChallengeServiceProvider.notifier)
        .checkAnswer(textController.text);

    if (textController.text == '') return;

    if (correct) {
      context.pop(true);
      return;
    }

    setState(() {
      failedAttempts++;
      buttonEnabled = false;
    });
    textController.clear();
    await buttonAnimationController.forward(from: 0.0);
    if (!mounted) return;
    setState(() => buttonEnabled = true);

    if (failedAttempts == Config.parentalModeChallengeMaxAttempts) {
      setState(() => failedAttempts = 0);
      ref.read(mathChallengeServiceProvider.notifier).getNewEquation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final equation = ref.watch(mathChallengeServiceProvider);
    final localizations = AppLocalizations.of(context)!;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return BottomSheet(
      constraints: const BoxConstraints(maxWidth: 500),
      onClosing: () {},
      animationController: sheetAnimationController,
      builder: (BuildContext context) {
        return SafeArea(
          minimum: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: EdgeInsetsGeometry.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 24.0,
              children: [
                Text(
                  localizations.parentTeacherModeWindowTitle,
                  style: titleStyle,
                ),
                Math.tex(equation.tex, textScaleFactor: 2.0),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: textController,
                    maxLines: 1,
                    enableSuggestions: false,
                    textInputAction: TextInputAction.done,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localizations.solveForX,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                FilledButton(
                      onPressed: buttonEnabled
                          ? () => checkAnswer(context, ref)
                          : null,
                      child: Text(localizations.checkAnswerButtonText),
                    )
                    .animate(
                      controller: buttonAnimationController,
                      autoPlay: false,
                    )
                    .shakeX(hz: 10.0),
                AttemptsCounter(failedAttempts),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AttemptsCounter extends StatelessWidget {
  const AttemptsCounter(
    this.attempts, {
    super.key,
  });

  final int attempts;

  @override
  Widget build(BuildContext context) {
    final attemptsIcons = List.generate(
      Config.parentalModeChallengeMaxAttempts,
      (int index) =>
          index < attempts ? Icon(Icons.close) : Icon(Icons.circle_outlined),
      growable: false,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: attemptsIcons,
    );
  }
}
