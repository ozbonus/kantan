import 'package:flutter/material.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class BookCover extends StatelessWidget {
  const BookCover({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<BookCoverStyle>();
    final backgroundContainerDecoration =
        style?.backgroundContainerDecoration ?? BoxDecoration();
    final imageContainerDecoration =
        style?.imageContainerDecoration ?? BoxDecoration();
    final imageContainerForegroundDecoration =
        style?.imageContainerForegroundDecoration ?? BoxDecoration();

    return Container(
      decoration: backgroundContainerDecoration,
      child: SafeArea(
        minimum: EdgeInsets.all(Config.bookCoverPadding),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: imageContainerDecoration,
            foregroundDecoration: imageContainerForegroundDecoration,
            child: Image(
              image: AssetImage(
                'assets/images/cover.webp',
                package: Config.assetsPackage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
