import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/home/bloc/home_bloc.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/util/functions.dart';
import 'package:wapipay_challenge/presentation/widget/alert_dialog.dart';
import 'package:wapipay_challenge/presentation/widget/app_bar.dart';
import 'package:wapipay_challenge/presentation/widget/button.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state.status == HomeStatus.unauthenticated) {
          context.router.replaceAll([const WelcomeRoute(), const LoginRoute()]);
        }
      },
      child: Scaffold(
        backgroundColor: appWhite,
        appBar: WPAppBar(showLeading: false, title: strings.label_home),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
                if (state.status == HomeStatus.loading) {
                  return const Center(child: WPLoader());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WPText.light(
                      strings.label_welcome,
                      color: appBlack,
                      fontSize: 20,
                    ),
                    WPText.bold(
                      state.user?.name ?? '',
                      color: appBlack,
                      fontSize: 36,
                    ),
                    const SizedBox(height: 24),
                    WPButton.primary(
                      strings.label_logout,
                      onTap: () {
                        alertDialog(
                          context,
                          WPAlert.confirm(
                            context: context,
                            title: strings.title_confirm_logout,
                            message: strings.confirm_logout_rationale,
                            onConfirm: () =>
                                context.read<HomeBloc>().add(HomeLogoutEvent()),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
