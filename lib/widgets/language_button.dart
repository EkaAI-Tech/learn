import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:learn/utils/localization.dart';

/// Language menu (English / العربية / Français / Español) shown in the top
/// bar of every page.
///
/// [compact] shows a small chip with the current language ("EN", "ع", "FR",
/// "ES"); otherwise the full language name is shown.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, this.compact = true});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;
    final label = compact
        ? AppLang.shortNames[current] ?? current.toUpperCase()
        : AppLang.nativeNames[current] ?? current;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 4),
      child: PopupMenuButton<String>(
        tooltip: 'common.language'.tr(),
        onSelected: (code) {
          if (code != current) AppLang.setLanguage(context, Locale(code));
        },
        itemBuilder: (context) => [
          for (final entry in AppLang.nativeNames.entries)
            CheckedPopupMenuItem<String>(
              value: entry.key,
              checked: entry.key == current,
              child: Text(entry.value),
            ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.translate, size: 20),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
