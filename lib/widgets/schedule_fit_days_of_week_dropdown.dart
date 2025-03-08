import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_days_of_week.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ScheduleFitDaysOfWeekDropdown extends StatelessWidget {
  List<String> giorniSettimanaTradotti;
  final Function onUpdate;

  ScheduleFitDaysOfWeekDropdown(
      {super.key,
      required this.giorniSettimanaTradotti,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      initialValue: giorniSettimanaTradotti,
      items: getDayOfWeekTranslatedFromEnum(context)
          .map((e) => MultiSelectItem(e, e))
          .toList(),
      listType: MultiSelectListType.LIST,
      backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
      checkColor: Colors.white,
      selectedColor: ThemeProvider.getColor(AppColors.secondaryColor),
      searchable: true,
      searchIcon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 24,
      ),
      closeSearchIcon: Icon(
        Icons.close,
        color: ThemeProvider.getColor(AppColors.cancelColor),
        size: 24,
      ),
      searchHint: AppLocalizations.of(context)!.cerca,
      searchHintStyle: const TextStyle(color: Colors.white),
      searchTextStyle: const TextStyle(color: Colors.white),
      dialogHeight: MediaQuery.of(context).size.height * 0.5,
      itemsTextStyle: TextStyle(
          color: ThemeProvider.getColor(AppColors.secondaryColor),
          fontSize: 18,
          fontWeight: FontWeight.bold),
      selectedItemsTextStyle: TextStyle(
          color: ThemeProvider.getColor(AppColors.secondaryColor),
          fontSize: 18,
          fontWeight: FontWeight.bold),
      title: Expanded(
        child: Text(
          AppLocalizations.of(context)!.giorniAllenamento,
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      barrierColor: Colors.transparent,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 2,
            color: ThemeProvider.getColor(AppColors.dropdownButtonTextColor) ??
                const Color(0xFF556EAA),
          )),
      buttonIcon: Icon(
        Icons.arrow_drop_down,
        color: ThemeProvider.getColor(AppColors.dropdownButtonTextColor),
        size: 20,
      ),
      buttonText: Text(
        AppLocalizations.of(context)!.giorniAllenamento,
        softWrap: true,
        maxLines: 2,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeProvider.getColor(AppColors.dropdownButtonTextColor),
        ),
      ),
      confirmText: Text(
        AppLocalizations.of(context)!.conferma,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      cancelText: Text(
        AppLocalizations.of(context)!.chiudi,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ThemeProvider.getColor(AppColors.cancelColor),
        ),
      ),
      onConfirm: (values) {
        giorniSettimanaTradotti = values;
        onUpdate(giorniSettimanaTradotti);
      },
      chipDisplay: MultiSelectChipDisplay(
        scroll: true,
        scrollBar: HorizontalScrollBar(isAlwaysShown: false),
        chipColor: ThemeProvider.getColor(AppColors.primaryColor),
        textStyle: TextStyle(
            color: ThemeProvider.getColor(AppColors.secondaryColor),
            fontSize: 14),
        items: getDayOfWeekTranslatedFromEnum(context)
            .map((d) => MultiSelectItem(d, d))
            .toList(),
      ),
    );
  }
}
