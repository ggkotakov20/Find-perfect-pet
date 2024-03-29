import 'package:flutter/widgets.dart';
import 'intl_en.dart'; // Import with an alias
import 'intl_bg.dart'; // Import with an alias

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  String get general_yes {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_yes; // Use Bulgarian translation
    } else {
      return IntlEN.general_yes; // Use English translation as a fallback
    }
  }
  String get general_no {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_no; // Use Bulgarian translation
    } else {
      return IntlEN.general_no; // Use English translation as a fallback
    }
  }
  String get general_edit {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_edit; // Use Bulgarian translation
    } else {
      return IntlEN.general_edit; // Use English translation as a fallback
    }
  }

  //  Title page
  String get page_title_map {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_map; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_map; // Use English translation as a fallback
    }
  }
  String get page_title_pet {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_pet; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_pet; // Use English translation as a fallback
    }
  }
  String get page_title_edit_pet {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_edit_pet; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_edit_pet; // Use English translation as a fallback
    }
  }
  String get page_title_add_pet {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_add_pet; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_add_pet; // Use English translation as a fallback
    }
  }
  String get page_title_home {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_home; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_home; // Use English translation as a fallback
    }
  }
  String get page_title_profile {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_profile; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_profile; // Use English translation as a fallback
    }
  }
  String get page_title_calendar {
    if (locale.languageCode == 'bg') {
      return IntlBG.page_title_calendar; // Use Bulgarian translation
    } else {
      return IntlEN.page_title_calendar; // Use English translation as a fallback
    }
  }

  //  Home page
  String get home_buy {
    if (locale.languageCode == 'bg') {
      return IntlBG.home_buy; // Use Bulgarian translation
    } else {
      return IntlEN.home_buy; // Use English translation as a fallback
    }
  }
  String get home_breeding {
    if (locale.languageCode == 'bg') {
      return IntlBG.home_breeding; // Use Bulgarian translation
    } else {
      return IntlEN.home_breeding; // Use English translation as a fallback
    }
  }
  String get home_food {
    if (locale.languageCode == 'bg') {
      return IntlBG.home_food; // Use Bulgarian translation
    } else {
      return IntlEN.home_food; // Use English translation as a fallback
    }
  }
  String get home_accessory {
    if (locale.languageCode == 'bg') {
      return IntlBG.home_accessory; // Use Bulgarian translation
    } else {
      return IntlEN.home_accessory; // Use English translation as a fallback
    }
  }

  // Pet page
  String get pet_page_basic_info {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_basic_info; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_basic_info; // Use English translation as a fallback
    }
  }
  String get pet_page_diet {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_diet; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_diet; // Use English translation as a fallback
    }
  }
  String get pet_page_name {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_name; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_name; // Use English translation as a fallback
    }
  }
  String get pet_page_species {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_species; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_species; // Use English translation as a fallback
    }
  }
  String get pet_page_gender {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_gender; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_gender; // Use English translation as a fallback
    }
  }
  String get pet_page_breed {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_breed; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_breed; // Use English translation as a fallback
    }
  }
  String get pet_page_birthdate {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_birthdate; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_birthdate; // Use English translation as a fallback
    }
  }
  String get pet_page_weight {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_weight; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_weight; // Use English translation as a fallback
    }
  }
  String get pet_page_food {
    if (locale.languageCode == 'bg') {
      return IntlBG.pet_page_food; // Use Bulgarian translation
    } else {
      return IntlEN.pet_page_food; // Use English translation as a fallback
    }
  }
  
  //  Map page
  String get general_open {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_open; // Use Bulgarian translation
    } else {
      return IntlEN.general_open; // Use English translation as a fallback
    }
  }
  String get general_close {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_close; // Use Bulgarian translation
    } else {
      return IntlEN.general_close; // Use English translation as a fallback
    }
  }
  String get general_work_time {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_work_time; // Use Bulgarian translation
    } else {
      return IntlEN.general_work_time; // Use English translation as a fallback
    }
  }
  String get general_weekday {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_weekday; // Use Bulgarian translation
    } else {
      return IntlEN.general_weekday; // Use English translation as a fallback
    }
  }
  String get general_saturday {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_saturday; // Use Bulgarian translation
    } else {
      return IntlEN.general_saturday; // Use English translation as a fallback
    }
  }
  String get general_sunday {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_sunday; // Use Bulgarian translation
    } else {
      return IntlEN.general_sunday; // Use English translation as a fallback
    }
  }
  String get general_all_day {
      if (locale.languageCode == 'bg') {
        return IntlBG.general_all_day; // Use Bulgarian translation
      } else {
        return IntlEN.general_all_day; // Use English translation as a fallback
      }
    }
  String get general_not_working {
      if (locale.languageCode == 'bg') {
        return IntlBG.general_not_working; // Use Bulgarian translation
      } else {
        return IntlEN.general_not_working; // Use English translation as a fallback
      }
    }

  //  Menu
  String get general_user {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_user; // Use Bulgarian translation
    } else {
      return IntlEN.general_user; // Use English translation as a fallback
    }
  }
  String get general_advert {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_advert; // Use Bulgarian translation
    } else {
      return IntlEN.general_advert; // Use English translation as a fallback
    }
  }
  

  String get general_profile {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_profile; // Use Bulgarian translation
    } else {
      return IntlEN.general_profile; // Use English translation as a fallback
    }
  }
  String get general_settings {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_settings; // Use Bulgarian translation
    } else {
      return IntlEN.general_settings; // Use English translation as a fallback
    }
  }
  String get general_favorite {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_favorite; // Use Bulgarian translation
    } else {
      return IntlEN.general_favorite; // Use English translation as a fallback
    }
  }
  String get general_cart {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_cart; // Use Bulgarian translation
    } else {
      return IntlEN.general_cart; // Use English translation as a fallback
    }
  }
  String get general_your_orders {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_your_orders; // Use Bulgarian translation
    } else {
      return IntlEN.general_your_orders; // Use English translation as a fallback
    }
  }
  String get general_add {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_add; // Use Bulgarian translation
    } else {
      return IntlEN.general_add; // Use English translation as a fallback
    }
  }
  String get general_your_adverts {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_your_adverts; // Use Bulgarian translation
    } else {
      return IntlEN.general_your_adverts; // Use English translation as a fallback
    }
  }
  String get general_logout {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_logout; // Use Bulgarian translation
    } else {
      return IntlEN.general_logout; // Use English translation as a fallback
    }
  }

  //  Buttons
  String get general_add_advert {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_add_advert; // Use Bulgarian translation
    } else {
      return IntlEN.general_add_advert; // Use English translation as a fallback
    }
  }
  String get general_save_changes {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_save_changes; // Use Bulgarian translation
    } else {
      return IntlEN.general_save_changes; // Use English translation as a fallback
    }
  }
  
  // Textt Form
  String get general_title {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_title; // Use Bulgarian translation
    } else {
      return IntlEN.general_title; // Use English translation as a fallback
    }
  }
  String get general_type {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_type; // Use Bulgarian translation
    } else {
      return IntlEN.general_type; // Use English translation as a fallback
    }
  }
  String get general_category {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_category; // Use Bulgarian translation
    } else {
      return IntlEN.general_category; // Use English translation as a fallback
    }
  }
  String get general_price {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_price; // Use Bulgarian translation
    } else {
      return IntlEN.general_price; // Use English translation as a fallback
    }
  }
  String get general_description {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_description; // Use Bulgarian translation
    } else {
      return IntlEN.general_description; // Use English translation as a fallback
    }
  }

  // Textt Messages
  String get general_add_adver_suucess {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_add_adver_suucess; // Use Bulgarian translation
    } else {
      return IntlEN.general_add_adver_suucess; // Use English translation as a fallback
    }
  }
  String get general_add_adver_favorite {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_add_adver_favorite; // Use Bulgarian translation
    } else {
      return IntlEN.general_add_adver_favorite; // Use English translation as a fallback
    }
  }
  String get general_remove_adver_favorite {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_remove_adver_favorite; // Use Bulgarian translation
    } else {
      return IntlEN.general_remove_adver_favorite; // Use English translation as a fallback
    }
  }
  String get general_warning_advert_delete {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_warning_advert_delete; // Use Bulgarian translation
    } else {
      return IntlEN.general_warning_advert_delete; // Use English translation as a fallback
    }
  }
  String get general_edit_adver_suucess {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_edit_adver_suucess; // Use Bulgarian translation
    } else {
      return IntlEN.general_edit_adver_suucess; // Use English translation as a fallback
    }
  }
  String get general_delete_adver_suucess {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_delete_adver_suucess; // Use Bulgarian translation
    } else {
      return IntlEN.general_delete_adver_suucess; // Use English translation as a fallback
    }
  }
  String get general_edit_pet_suucess {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_edit_pet_suucess; // Use Bulgarian translation
    } else {
      return IntlEN.general_edit_pet_suucess; // Use English translation as a fallback
    }
  }
  String get general_error {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_error; // Use Bulgarian translation
    } else {
      return IntlEN.general_error; // Use English translation as a fallback
    }
  }
  String get general_no_data {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_no_data; // Use Bulgarian translation
    } else {
      return IntlEN.general_no_data; // Use English translation as a fallback
    }
  }
  String get general_no_result {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_no_result; // Use Bulgarian translation
    } else {
      return IntlEN.general_no_result; // Use English translation as a fallback
    }
  }

  String get general_added {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_added; // Use Bulgarian translation
    } else {
      return IntlEN.general_added; // Use English translation as a fallback
    }
  }
  String get general_today {
    if (locale.languageCode == 'bg') {
      return IntlBG.general_today; // Use Bulgarian translation
    } else {
      return IntlEN.general_today; // Use English translation as a fallback
    }
  }
  
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('bg', 'BG'), // Bulgarian
    // Add more locales as needed
  ];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Return true if the locale is supported
    return ['en', 'bg'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Load and return the appropriate localization for the locale
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
