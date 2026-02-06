import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return Scaffold(
      backgroundColor: appWhite,
      appBar: WPAppBar(showLeading: false, title: strings.label_home),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WPText.light('Welcome,', color: appBlack, fontSize: 20),
              WPText.bold('John Doe', color: appBlack, fontSize: 36),
              WPButton.primary('Logout'),
            ],
          ),
        ),
      ),
    );
  }
}
