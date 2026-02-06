// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get label_login {
    return Intl.message('Login', name: 'label_login', desc: '', args: []);
  }

  /// `Register`
  String get label_register {
    return Intl.message('Register', name: 'label_register', desc: '', args: []);
  }

  /// `Continue`
  String get label_continue {
    return Intl.message('Continue', name: 'label_continue', desc: '', args: []);
  }

  /// `Cancel`
  String get label_cancel {
    return Intl.message('Cancel', name: 'label_cancel', desc: '', args: []);
  }

  /// `Go back`
  String get label_go_back {
    return Intl.message('Go back', name: 'label_go_back', desc: '', args: []);
  }

  /// `Confirm`
  String get label_confirm {
    return Intl.message('Confirm', name: 'label_confirm', desc: '', args: []);
  }

  /// `Check our rates`
  String get label_check_rates {
    return Intl.message(
      'Check our rates',
      name: 'label_check_rates',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get label_change_language {
    return Intl.message(
      'Change Language',
      name: 'label_change_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get label_language_english {
    return Intl.message(
      'English',
      name: 'label_language_english',
      desc: '',
      args: [],
    );
  }

  /// `简体中文`
  String get label_language_chinese {
    return Intl.message(
      '简体中文',
      name: 'label_language_chinese',
      desc: '',
      args: [],
    );
  }

  /// `Send money instantly`
  String get welcome_title_1 {
    return Intl.message(
      'Send money instantly',
      name: 'welcome_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Every payment matters`
  String get welcome_title_2 {
    return Intl.message(
      'Every payment matters',
      name: 'welcome_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Connecting Africa and Asia trade`
  String get welcome_title_3 {
    return Intl.message(
      'Connecting Africa and Asia trade',
      name: 'welcome_title_3',
      desc: '',
      args: [],
    );
  }

  /// `One app, all your money`
  String get welcome_title_4 {
    return Intl.message(
      'One app, all your money',
      name: 'welcome_title_4',
      desc: '',
      args: [],
    );
  }

  /// `Fast, secure, across borders`
  String get welcome_subtitle_1 {
    return Intl.message(
      'Fast, secure, across borders',
      name: 'welcome_subtitle_1',
      desc: '',
      args: [],
    );
  }

  /// `Move money with meaning`
  String get welcome_subtitle_2 {
    return Intl.message(
      'Move money with meaning',
      name: 'welcome_subtitle_2',
      desc: '',
      args: [],
    );
  }

  /// `Business, remittances, and more`
  String get welcome_subtitle_3 {
    return Intl.message(
      'Business, remittances, and more',
      name: 'welcome_subtitle_3',
      desc: '',
      args: [],
    );
  }

  /// `Fast, secure, across borders`
  String get welcome_subtitle_4 {
    return Intl.message(
      'Fast, secure, across borders',
      name: 'welcome_subtitle_4',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcome_back {
    return Intl.message(
      'Welcome back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Enter the phone number associated with your Wapi Pay account`
  String get enter_phone_number_rationale {
    return Intl.message(
      'Enter the phone number associated with your Wapi Pay account',
      name: 'enter_phone_number_rationale',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get label_select_country {
    return Intl.message(
      'Select country',
      name: 'label_select_country',
      desc: '',
      args: [],
    );
  }

  /// `Search country / region`
  String get search_country {
    return Intl.message(
      'Search country / region',
      name: 'search_country',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get label_phone_number {
    return Intl.message(
      'Phone number',
      name: 'label_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `I accept Wapi Pay `
  String get i_accept_the {
    return Intl.message(
      'I accept Wapi Pay ',
      name: 'i_accept_the',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get validation_invalid_phone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'validation_invalid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect OTP. Please try again`
  String get validation_invalid_otp {
    return Intl.message(
      'Incorrect OTP. Please try again',
      name: 'validation_invalid_otp',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get terms_of_service {
    return Intl.message(
      'Terms of Service',
      name: 'terms_of_service',
      desc: '',
      args: [],
    );
  }

  /// `Is this number correct? We'll send you a confirmation code there`
  String get number_confirmation_rationale {
    return Intl.message(
      'Is this number correct? We\'ll send you a confirmation code there',
      name: 'number_confirmation_rationale',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP`
  String get enter_otp {
    return Intl.message(
      'Enter your OTP',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `We've sent you the OTP through SMS to {phone}`
  String enter_otp_rationale(String phone) {
    return Intl.message(
      'We\'ve sent you the OTP through SMS to $phone',
      name: 'enter_otp_rationale',
      desc: '',
      args: [phone],
    );
  }

  /// `Resend OTP in ({time})s`
  String resend_otp_timer(int time) {
    return Intl.message(
      'Resend OTP in ($time)s',
      name: 'resend_otp_timer',
      desc: '',
      args: [time],
    );
  }

  /// `Resend OTP`
  String get resend_otp {
    return Intl.message('Resend OTP', name: 'resend_otp', desc: '', args: []);
  }

  /// `Try again`
  String get label_try_again {
    return Intl.message(
      'Try again',
      name: 'label_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get label_home {
    return Intl.message('Home', name: 'label_home', desc: '', args: []);
  }

  /// `Enter PIN`
  String get label_enter_pin {
    return Intl.message(
      'Enter PIN',
      name: 'label_enter_pin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your PIN?`
  String get label_forgot_pin {
    return Intl.message(
      'Forgot your PIN?',
      name: 'label_forgot_pin',
      desc: '',
      args: [],
    );
  }

  /// `Select your Language`
  String get label_select_your_language {
    return Intl.message(
      'Select your Language',
      name: 'label_select_your_language',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get title_an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'title_an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `That didn't go as planned. It's on us - please try again in a moment`
  String get an_error_cooured_rationale {
    return Intl.message(
      'That didn\'t go as planned. It\'s on us - please try again in a moment',
      name: 'an_error_cooured_rationale',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not registered`
  String get error_phone_number_not_registered {
    return Intl.message(
      'Phone number not registered',
      name: 'error_phone_number_not_registered',
      desc: '',
      args: [],
    );
  }

  /// `This number does not have an account with us. Please proceed to registration`
  String get phone_number_unregistered_rationale {
    return Intl.message(
      'This number does not have an account with us. Please proceed to registration',
      name: 'phone_number_unregistered_rationale',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get title_confirm_logout {
    return Intl.message(
      'Confirm Logout',
      name: 'title_confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get confirm_logout_rationale {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'confirm_logout_rationale',
      desc: '',
      args: [],
    );
  }

  /// `Welcome,`
  String get label_welcome {
    return Intl.message('Welcome,', name: 'label_welcome', desc: '', args: []);
  }

  /// `Logout`
  String get label_logout {
    return Intl.message('Logout', name: 'label_logout', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
