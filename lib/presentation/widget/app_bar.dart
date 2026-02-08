import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WPAppBar({
    this.title = '',
    this.showLeading = true,
    this.leadingWidget,
    this.actions,
    this.backgroundColor,
    this.arrowColor,
    this.titleColor,
    super.key,
  });

  final String title;
  final bool showLeading;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Color? backgroundColor;
  final Color? arrowColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? appWhite,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? leadingWidget ??
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => context.router.back(),
                  child: Icon(Icons.arrow_back, color: arrowColor ?? appBlack),
                )
          : null,
      title: WPText.bold(title, color: titleColor ?? appBlack, fontSize: 18),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
