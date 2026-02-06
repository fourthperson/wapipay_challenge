// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(phone) => "We\'ve sent you the OTP through SMS to ${phone}";

  static String m1(time) => "Resend OTP in (${time})s";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "an_error_cooured_rationale": MessageLookupByLibrary.simpleMessage(
      "That didn\'t go as planned. It\'s on us - please try again in a moment",
    ),
    "enter_otp": MessageLookupByLibrary.simpleMessage("Enter your OTP"),
    "enter_otp_rationale": m0,
    "enter_phone_number_rationale": MessageLookupByLibrary.simpleMessage(
      "Enter the phone number associated with your Wapi Pay account",
    ),
    "error_phone_number_not_registered": MessageLookupByLibrary.simpleMessage(
      "Phone number not registered",
    ),
    "i_accept_the": MessageLookupByLibrary.simpleMessage("I accept Wapi Pay "),
    "label_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "label_change_language": MessageLookupByLibrary.simpleMessage(
      "Change Language",
    ),
    "label_check_rates": MessageLookupByLibrary.simpleMessage(
      "Check our rates",
    ),
    "label_confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "label_continue": MessageLookupByLibrary.simpleMessage("Continue"),
    "label_enter_pin": MessageLookupByLibrary.simpleMessage("Enter PIN"),
    "label_forgot_pin": MessageLookupByLibrary.simpleMessage(
      "Forgot your PIN?",
    ),
    "label_go_back": MessageLookupByLibrary.simpleMessage("Go back"),
    "label_home": MessageLookupByLibrary.simpleMessage("Home"),
    "label_language_chinese": MessageLookupByLibrary.simpleMessage("简体中文"),
    "label_language_english": MessageLookupByLibrary.simpleMessage("English"),
    "label_login": MessageLookupByLibrary.simpleMessage("Login"),
    "label_phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
    "label_register": MessageLookupByLibrary.simpleMessage("Register"),
    "label_select_country": MessageLookupByLibrary.simpleMessage(
      "Select country",
    ),
    "label_select_your_language": MessageLookupByLibrary.simpleMessage(
      "Select your Language",
    ),
    "label_try_again": MessageLookupByLibrary.simpleMessage("Try again"),
    "number_confirmation_rationale": MessageLookupByLibrary.simpleMessage(
      "Is this number correct? We\'ll send you a confirmation code there",
    ),
    "phone_number_unregistered_rationale": MessageLookupByLibrary.simpleMessage(
      "This number does not have an account with us. Please proceed to registration",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "resend_otp": MessageLookupByLibrary.simpleMessage("Resend OTP"),
    "resend_otp_timer": m1,
    "search_country": MessageLookupByLibrary.simpleMessage(
      "Search country / region",
    ),
    "terms_of_service": MessageLookupByLibrary.simpleMessage(
      "Terms of Service",
    ),
    "title_an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "An error occurred",
    ),
    "validation_invalid_otp": MessageLookupByLibrary.simpleMessage(
      "Incorrect OTP. Please try again",
    ),
    "validation_invalid_phone": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "welcome_back": MessageLookupByLibrary.simpleMessage("Welcome back!"),
    "welcome_subtitle_1": MessageLookupByLibrary.simpleMessage(
      "Fast, secure, across borders",
    ),
    "welcome_subtitle_2": MessageLookupByLibrary.simpleMessage(
      "Move money with meaning",
    ),
    "welcome_subtitle_3": MessageLookupByLibrary.simpleMessage(
      "Business, remittances, and more",
    ),
    "welcome_subtitle_4": MessageLookupByLibrary.simpleMessage(
      "Fast, secure, across borders",
    ),
    "welcome_title_1": MessageLookupByLibrary.simpleMessage(
      "Send money instantly",
    ),
    "welcome_title_2": MessageLookupByLibrary.simpleMessage(
      "Every payment matters",
    ),
    "welcome_title_3": MessageLookupByLibrary.simpleMessage(
      "Connecting Africa and Asia trade",
    ),
    "welcome_title_4": MessageLookupByLibrary.simpleMessage(
      "One app, all your money",
    ),
  };
}
