import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/model/language_model.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class LanguageListItem extends StatelessWidget {
  final LanguageItem language;
  final bool selected;
  final void Function(LanguageItem)? onTap;

  const LanguageListItem({
    required this.language,
    this.selected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(language),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? appLightGreen
                    : appGrey.withValues(alpha: 0.1),
              ),
              child: ClipOval(
                child: selected
                    ? Center(child: Icon(Icons.check_outlined, color: appWhite))
                    : CachedNetworkImage(
                        imageUrl: language.flag,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: appGrey.withValues(alpha: 0.1)),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.flag_rounded, size: 16, color: appGrey),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WPText.medium(
                language.title,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
