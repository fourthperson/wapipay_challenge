import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/presentation/l10n/generated/l10n.dart';
import 'package:wapipay_challenge/presentation/screen/countries/bloc/country_bloc.dart';
import 'package:wapipay_challenge/presentation/screen/countries/widget/country_list_item.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/loader.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';
import 'package:wapipay_challenge/presentation/widget/text_field.dart';

class CountryList extends StatefulWidget {
  const CountryList({
    required this.onCountrySelected,
    this.selected,
    super.key,
  });

  final Function(Country) onCountrySelected;
  final Country? selected;

  @override
  State<StatefulWidget> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<CountryBloc>().add(LoadCountriesEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: appWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: BlocBuilder<CountryBloc, CountriesState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: WPTextField(
                        controller: searchController,
                        hint: strings.search_country,
                        borderRadius: 32,
                        onTextChanged: (s) => context.read<CountryBloc>().add(
                          FilterCountriesEvent(query: s),
                        ),
                        prefixIcon: const Icon(Icons.search_outlined),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  context.read<CountryBloc>().add(
                                    FilterCountriesEvent(query: ''),
                                  );
                                },
                                icon: const Icon(Icons.close),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: WPText.medium(
                        strings.label_cancel,
                        color: appLightGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(child: _buildContent(state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(CountriesState state) {
    return switch (state) {
      CountriesLoadingState() => const Center(child: WPLoader()),

      CountriesErrorState() => Center(
        child: WPText.medium('Failed to load countries'),
      ),

      CountriesLoadedState(filteredCountries: final List<Country> list) =>
        list.isEmpty
            ? const Center(child: Text('No countries found'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, int index) {
                  final country = list[index];
                  return CountryListItem(
                    country: country,
                    selected:
                        widget.selected != null &&
                        widget.selected!.iso == country.iso,
                    onTap: (Country c) {
                      Navigator.of(context).pop();
                      widget.onCountrySelected(c);
                    },
                  );
                },
              ),
    };
  }
}
