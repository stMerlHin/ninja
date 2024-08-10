import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kunai/l10n/localizations_ext.dart';

class ShadowTextField extends StatelessWidget {
  const ShadowTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.searchIconData,
    this.onSearchIconTaped,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchIconTaped;
  final IconData? searchIconData;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(
                    0,
                    5,
                  ),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText ?? context.kunaiL10n.search,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: onSearchIconTaped,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(
                    0,
                    5,
                  ),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                searchIconData ?? CupertinoIcons.search,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
