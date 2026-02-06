import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:wapipay_challenge/data/repository/auth_repo.dart';
import 'package:wapipay_challenge/data/repository/country_repo.dart';
import 'package:wapipay_challenge/data/repository/user_repo.dart';
import 'package:wapipay_challenge/data/source/api/api_data_source.dart';
import 'package:wapipay_challenge/data/source/api/mock_api_data_source.dart';
import 'package:wapipay_challenge/data/source/local/local_data_source.dart';
import 'package:wapipay_challenge/data/source/local/secure_local_data_source.dart';
import 'package:wapipay_challenge/domain/repository/auth_repository.dart';
import 'package:wapipay_challenge/domain/repository/country_repository.dart';
import 'package:wapipay_challenge/domain/repository/user_repository.dart';
import 'package:wapipay_challenge/domain/use_case/country_get_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/otp_verify_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/phone_check_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/user_clear_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/user_get_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/user_set_use_case.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/navigation/navigation.dart';
import 'package:wapipay_challenge/presentation/screen/login/bloc/login_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/otp/bloc/otp_bloc.dart';

part 'di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDi();
  runApp(WapiPayChallengeApp());
}

class WapiPayChallengeApp extends StatelessWidget {
  WapiPayChallengeApp({super.key});

  final WapiPayRouter _router = WapiPayRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              LoginBloc(phoneCheckUseCase: locator<PhoneCheckUseCase>()),
        ),
        BlocProvider(
          create: (_) => OtpBloc(
            otpVerifyUseCase: locator<OtpVerifyUseCase>(),
            userSetUseCase: locator<UserSetUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router.config(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
