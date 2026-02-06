import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wapipay_challenge/presentation/generated/assets.gen.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/model/welcome_item.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/language/bloc/language_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/language/language_list.dart';
import 'package:wapipay_challenge/presentation/screen/welcome/widget/language_button.dart';
import 'package:wapipay_challenge/presentation/screen/welcome/widget/welcome_pager_item.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    final List<WelcomeItem> pagerItems = [
      WelcomeItem(
        title: strings.welcome_title_1, // Use the local 'strings' variable
        subtitle: strings.welcome_subtitle_1,
      ),
      WelcomeItem(
        title: strings.welcome_title_2,
        subtitle: strings.welcome_subtitle_2,
      ),
      WelcomeItem(
        title: strings.welcome_title_3,
        subtitle: strings.welcome_subtitle_3,
      ),
      WelcomeItem(
        title: strings.welcome_title_4,
        subtitle: strings.welcome_subtitle_4,
      ),
    ];

    final String currentLang = context
        .watch<LanguageBloc>()
        .state
        .locale
        .languageCode;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: appDarkGreen,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.image.welcomeBackground.path),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.1),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: LanguageButton(
                      label: currentLang == 'zh'
                          ? strings.label_language_chinese
                          : strings.label_language_english,
                      onTap: () {
                        bottomSheet(context, LanguageList());
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    color: appWhite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 160,
                          child: PageView(
                            controller: _pageController,
                            physics: const ClampingScrollPhysics(),
                            children: pagerItems
                                .map(
                                  (
                                    WelcomeItem item,
                                  ) => TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeOut,
                                    builder: (context, value, child) {
                                      return Opacity(
                                        opacity: value,
                                        child: Transform.translate(
                                          offset: Offset(0, 20 * (1 - value)),
                                          child: WelcomePagerItem(item: item),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(growable: false),
                          ),
                        ),
                        SizedBox(height: 16),
                        WPText.link(
                          strings.label_check_rates,
                          color: appLightGreen,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 4,
                            effect: ExpandingDotsEffect(
                              dotColor: appGrey,
                              activeDotColor: appBlack,
                              dotWidth: 8,
                              dotHeight: 8,
                            ),
                            onDotClicked: (index) {},
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: WPButton.primary(
                                  strings.label_login,
                                  onTap: () =>
                                      context.router.push(const LoginRoute()),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: WPButton.secondary(
                                  strings.label_register,
                                  onTap: () =>
                                      context.router.push(const HomeRoute()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
