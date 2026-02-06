import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/model/language_model.dart';
import 'package:wapipay_challenge/presentation/screen/language/bloc/language_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/language/widget/language_list_item.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class LanguageList extends StatefulWidget {
  const LanguageList({super.key});

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  late LanguageItem selected;

  @override
  void initState() {
    super.initState();
    final String code = context.read<LanguageBloc>().state.locale.languageCode;
    selected = languageList.firstWhere((LanguageItem e) => e.code == code);
  }

  final List<LanguageItem> languageList = [
    LanguageItem(
      title: S.current.label_language_english,
      code: 'en',
      flag: 'https://flagcdn.com/w320/gb-eng.png',
    ),
    LanguageItem(
      title: S.current.label_language_chinese,
      code: 'zh',
      flag: 'https://flagcdn.com/w320/cn.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: appWhite,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close_outlined),
                    color: appBlack,
                    onPressed: () => context.router.pop(),
                  ),
                ],
              ),
              WPText.bold(
                strings.label_select_your_language,
                color: appBlack,
                fontSize: 24,
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: languageList.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int item) {
                  final LanguageItem language = languageList[item];
                  return LanguageListItem(
                    language: language,
                    selected: selected.code == language.code,
                    onTap: (LanguageItem l) {
                      context.read<LanguageBloc>().add(
                        ChangeLanguageEvent(Locale(l.code)),
                      );
                      context.router.pop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
