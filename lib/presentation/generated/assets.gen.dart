// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/Halenoir-Black.otf
  String get halenoirBlack => 'assets/font/Halenoir-Black.otf';

  /// File path: assets/font/Halenoir-Bold.otf
  String get halenoirBold => 'assets/font/Halenoir-Bold.otf';

  /// File path: assets/font/HalenoirCompact-Light.otf
  String get halenoirCompactLight => 'assets/font/HalenoirCompact-Light.otf';

  /// File path: assets/font/HalenoirCompact-Medium.otf
  String get halenoirCompactMedium => 'assets/font/HalenoirCompact-Medium.otf';

  /// File path: assets/font/HalenoirCompact-Regular.otf
  String get halenoirCompactRegular =>
      'assets/font/HalenoirCompact-Regular.otf';

  /// List of all assets
  List<String> get values => [
    halenoirBlack,
    halenoirBold,
    halenoirCompactLight,
    halenoirCompactMedium,
    halenoirCompactRegular,
  ];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/welcome_background.png
  AssetGenImage get welcomeBackground => const AssetGenImage(
    'assets/image/welcome_background.png',
    size: const Size(1408.0, 768.0),
  );

  /// List of all assets
  List<AssetGenImage> get values => [welcomeBackground];
}

class Assets {
  const Assets._();

  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
