import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';

class WPLoader extends StatelessWidget {
  final Color? color;
  final double? size;
  final double? thickness;

  const WPLoader({this.color, this.size, this.thickness, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color ?? appLightGreen,
          strokeWidth: thickness ?? 2,
        ),
      ),
    );
  }
}

class WPLoaderOverlay extends StatelessWidget {
  final double? opacity;

  const WPLoaderOverlay({this.opacity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBlack.withValues(alpha: opacity ?? 0.8),
      child: Center(child: WPLoader()),
    );
  }
}
