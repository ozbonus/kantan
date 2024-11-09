import 'package:flutter/material.dart';

/// A reuseable error message widget that simply displays an error message in
/// the context's error color.
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(
    this.errorMessage, {
    super.key,
  });
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
    );
  }
}
