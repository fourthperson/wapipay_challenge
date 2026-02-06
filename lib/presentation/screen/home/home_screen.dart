import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.gr.dart';
import 'package:wapipay_challenge/presentation/screen/home/bloc/home_bloc.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
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
    // Fetch user data as soon as the screen is initialized
    context.read<HomeBloc>().add(HomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state.status == HomeStatus.unauthenticated) {
          context.router.replaceAll([const LoginRoute()]);
        }
      },
      child: Scaffold(
        backgroundColor: appWhite,
        appBar: WPAppBar(showLeading: false, title: strings.label_home),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const Center(child: WPLoader());
                }

                final String userName = state.user?.name ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WPText.light('Welcome,', color: appBlack, fontSize: 20),
                    WPText.bold(userName, color: appBlack, fontSize: 36),
                    const SizedBox(height: 24),
                    WPButton.primary(
                      'Logout',
                      onTap: () =>
                          context.read<HomeBloc>().add(HomeLogoutEvent()),
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
