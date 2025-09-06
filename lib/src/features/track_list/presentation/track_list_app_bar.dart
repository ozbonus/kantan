import 'package:flutter/material.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class TrackListAppBar extends StatelessWidget {
  const TrackListAppBar({
    super.key,
    this.isFullscreen = false,
    required this.collapsed,
  });

  final bool isFullscreen;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TrackListAppBarStyle>();
    final overlayStyle = style?.systemUiOverlayStyle;
    final fullscreenAppBarColor = style?.fullscreenAppBarCollapsedColor;
    final contentsOnlyAppBarColor = style?.contentsOnlyAppBarCollapsedColor;
    final backgroundDecoration =
        style?.backgroundContainerDecoration ?? BoxDecoration();
    final imageBackgroundDecoration =
        style?.imageContainerDecoration ?? BoxDecoration();
    final imageForegroundDecoration =
        style?.imageContainerForegroundDecoration ?? BoxDecoration();
    final bookCoverPadding = style?.bookCoverPadding ?? 0.0;

    return SliverAppBar(
      systemOverlayStyle: isFullscreen ? overlayStyle : null,
      backgroundColor: isFullscreen
          ? fullscreenAppBarColor
          : contentsOnlyAppBarColor,
      pinned: true,
      snap: false,
      floating: false,
      stretch: true,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: collapsed ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(Config.appTitle),
        ),
        background: Container(
          decoration: backgroundDecoration,
          child: SafeArea(
            minimum: EdgeInsets.all(bookCoverPadding),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: imageBackgroundDecoration,
                foregroundDecoration: imageForegroundDecoration,
                child: Image(
                  image: AssetImage(
                    'assets/images/cover.webp',
                    package: Config.assetsPackage,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
