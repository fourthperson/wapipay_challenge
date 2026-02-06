// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(phone) => "我们已通过短信向 ${phone} 发送了验证码";

  static String m1(time) => "将在 (${time}) 秒后重发";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "an_error_cooured_rationale": MessageLookupByLibrary.simpleMessage(
      "操作未成功。这是我们的问题 - 请稍后再试",
    ),
    "confirm_logout_rationale": MessageLookupByLibrary.simpleMessage(
      "您确定要退出登录吗？",
    ),
    "enter_otp": MessageLookupByLibrary.simpleMessage("输入验证码"),
    "enter_otp_rationale": m0,
    "enter_phone_number_rationale": MessageLookupByLibrary.simpleMessage(
      "请输入与您的 Wapi Pay 账户关联的手机号码",
    ),
    "error_phone_number_not_registered": MessageLookupByLibrary.simpleMessage(
      "手机号码未注册",
    ),
    "i_accept_the": MessageLookupByLibrary.simpleMessage("我接受 Wapi Pay 的"),
    "label_cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "label_change_language": MessageLookupByLibrary.simpleMessage("更改语言"),
    "label_check_rates": MessageLookupByLibrary.simpleMessage("查看汇率"),
    "label_confirm": MessageLookupByLibrary.simpleMessage("确认"),
    "label_continue": MessageLookupByLibrary.simpleMessage("继续"),
    "label_enter_pin": MessageLookupByLibrary.simpleMessage("输入密码"),
    "label_forgot_pin": MessageLookupByLibrary.simpleMessage("忘记密码？"),
    "label_go_back": MessageLookupByLibrary.simpleMessage("返回"),
    "label_home": MessageLookupByLibrary.simpleMessage("首页"),
    "label_language_chinese": MessageLookupByLibrary.simpleMessage("简体中文"),
    "label_language_english": MessageLookupByLibrary.simpleMessage("English"),
    "label_login": MessageLookupByLibrary.simpleMessage("登录"),
    "label_logout": MessageLookupByLibrary.simpleMessage("退出登录"),
    "label_phone_number": MessageLookupByLibrary.simpleMessage("手机号码"),
    "label_register": MessageLookupByLibrary.simpleMessage("注册"),
    "label_select_country": MessageLookupByLibrary.simpleMessage("选择国家"),
    "label_select_your_language": MessageLookupByLibrary.simpleMessage("选择语言"),
    "label_try_again": MessageLookupByLibrary.simpleMessage("重试"),
    "label_welcome": MessageLookupByLibrary.simpleMessage("欢迎，"),
    "number_confirmation_rationale": MessageLookupByLibrary.simpleMessage(
      "该号码是否正确？我们将向其发送确认码",
    ),
    "phone_number_unregistered_rationale": MessageLookupByLibrary.simpleMessage(
      "该号码尚未注册账户。请前往注册",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "resend_otp": MessageLookupByLibrary.simpleMessage("重发验证码"),
    "resend_otp_timer": m1,
    "search_country": MessageLookupByLibrary.simpleMessage("搜索国家/地区"),
    "terms_of_service": MessageLookupByLibrary.simpleMessage("服务条款"),
    "title_an_error_occurred": MessageLookupByLibrary.simpleMessage("发生错误"),
    "title_confirm_logout": MessageLookupByLibrary.simpleMessage("确认退出"),
    "validation_invalid_otp": MessageLookupByLibrary.simpleMessage("验证码错误，请重试"),
    "validation_invalid_phone": MessageLookupByLibrary.simpleMessage(
      "请输入有效的手机号码",
    ),
    "welcome_back": MessageLookupByLibrary.simpleMessage("欢迎回来！"),
    "welcome_subtitle_1": MessageLookupByLibrary.simpleMessage("快速、安全、跨境"),
    "welcome_subtitle_2": MessageLookupByLibrary.simpleMessage("让每一笔转账更有意义"),
    "welcome_subtitle_3": MessageLookupByLibrary.simpleMessage("商务、汇款及更多服务"),
    "welcome_subtitle_4": MessageLookupByLibrary.simpleMessage("快速、安全、跨境"),
    "welcome_title_1": MessageLookupByLibrary.simpleMessage("即时转账"),
    "welcome_title_2": MessageLookupByLibrary.simpleMessage("每一笔付款都至关重要"),
    "welcome_title_3": MessageLookupByLibrary.simpleMessage("连接中非贸易"),
    "welcome_title_4": MessageLookupByLibrary.simpleMessage("一个应用，管理所有资金"),
  };
}
