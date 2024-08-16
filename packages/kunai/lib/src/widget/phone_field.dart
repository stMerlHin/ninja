import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kunai/l10n/localizations_ext.dart';

import '../../kunai.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    this.width,
    this.textFieldWidth,
    this.height = 50,
    this.onSubmitted,
    this.textFieldSpace,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0,),),
    this.color,
    this.maxWidth = 300,
    required this.controller,
    this.label,
    this.maxLength,
    this.maxDigit = 8,
    this.onChanged,
    this.onCountryChanged,
    this.searchFieldDecoration,
    this.allowedCountries,
    this.padding,
    this.defaultCountry,
    this.autofocus = true,
  });

  final double? width;
  final double? textFieldSpace;
  final double? textFieldWidth;
  final double? height;
  final Color? color;
  final int? maxLength;
  final int maxDigit;
  final String? label;
  final Country? defaultCountry;
  final double maxWidth;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final TextEditingController controller;
  final List<Country>? allowedCountries;
  final EdgeInsetsGeometry? padding;
  final InputDecoration? searchFieldDecoration;
  final bool autofocus;

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late String _text;
  late Country _country;

  @override
  void initState() {
    super.initState();
    _country = widget.defaultCountry ?? Country.togo();
    _text = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      child: Container(
        width: widget.width,
        height: widget.height,
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
        child: TextField(
          onTap: widget.onTap,
          controller: widget.controller,
          maxLength: widget.maxLength,
          autofocus: widget.autofocus,
          onSubmitted: widget.onSubmitted,
          onChanged: (str) {
            if (str.length <= widget.maxDigit) {
              _text = str;
              widget.onChanged?.call(str);
              return;
            }
            widget.controller.text = _text;
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(
                offset: widget.controller.text.length,
              ),
            );
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: widget.padding ?? const EdgeInsets.symmetric(vertical: 16.0,),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(18.0),
            ),
            fillColor: widget.color ?? Colors.grey.withOpacity(0.3),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(18.0),
            ),
            // suffixIconConstraints: BoxConstraints(),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8.0,),
                InkWell(
                  onTap: widget.onCountryChanged == null
                      ? null
                      : () => this.nextPage(
                    CountrySelectionPage(
                      searchFieldDecoration: widget.searchFieldDecoration,
                      allowedCountries: widget.allowedCountries,
                      onCountrySelected: (c) {
                        if (c == _country) {
                          return;
                        }
                        setState(() {
                          _country = c;
                        });
                        if (_text.length > c.maxLength) {
                          _text = _text.substring(0, c.maxLength);
                          widget.controller.text = _text;
                          widget.onChanged?.call(_text);
                        }
                        widget.onCountryChanged!(c);
                      },
                    ),
                  ),
                  child: Text(
                    _country.dialCodeAndFlagString,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Separator(
                  direction: Direction.vertical,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  size: 25,
                  width: 1,
                ),
                SizedBox(
                  width: widget.textFieldSpace,
                )
              ],
            ),
            hintText: '',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({
    super.key,
    required this.onCountrySelected,
    this.searchFieldDecoration,
    this.allowedCountries,
  });

  final ValueChanged<Country> onCountrySelected;
  final InputDecoration? searchFieldDecoration;
  final List<Country>? allowedCountries;

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  String _searchingValue = '';
  @override
  Widget build(BuildContext context) {
    List<Country> searchList = widget.allowedCountries ?? countries;
    if (_searchingValue.isNotEmpty) {
      searchList = (widget.allowedCountries ?? countries)
          .where(
            (element) =>
                element.name
                    .toLowerCase()
                    .contains(_searchingValue.toLowerCase()) ||
                element.nameTranslations.values
                    .where((el) => el
                        .toLowerCase()
                        .contains(_searchingValue.toLowerCase()))
                    .isNotEmpty ||
                element.dialCode.contains(_searchingValue),
          )
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black.withOpacity(0.005),
          systemNavigationBarColor: const Color(0xFF000000),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          //statusBarBrightness: Brightness.dark,
        ),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(height: 80,),
          Container(
            // width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            constraints: const BoxConstraints(maxWidth: 375),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18)),
            child: TextField(
              onChanged: (str) {
                setState(() {
                  _searchingValue = str;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                // suffixIcon: IconButton(
                //   onPressed: () {
                //     setState(() {
                //       _obscurePassword = !_obscurePassword;
                //     });
                //   },
                //   icon: Icon(
                //     _obscurePassword
                //         ? CupertinoIcons.eye_fill
                //         : CupertinoIcons.eye_slash_fill,
                //     color: primaryColor,
                //   ),
                // ),
                hintText: kunaiL10n.searchCountry,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: searchList.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    widget.onCountrySelected(searchList[i]);
                    this.previousPage();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            '${searchList[i].flag} ${searchList[i].nameTranslations[kunaiL10n.localeName] ?? searchList[i].name}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(searchList[i].dialCode,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
