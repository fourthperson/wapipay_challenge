import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class CountryListItem extends StatelessWidget {
  final Country country;
  final bool selected;
  final void Function(Country)? onTap;

  const CountryListItem({
    required this.country,
    this.selected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(country),
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
                        imageUrl: country.flag,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: appGrey.withValues(alpha: 0.1)),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.flag_rounded, size: 16, color: appGrey),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            WPText.medium(
              country.code,
              color: appBlack.withValues(alpha: 0.5),
              fontSize: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WPText.medium(
                country.name,
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
