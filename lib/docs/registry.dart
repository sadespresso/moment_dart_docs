import '../pages/calendar.dart';
import '../pages/common_mishaps.dart';
import '../pages/creating_localization.dart';
import '../pages/duration_precise.dart';
import '../pages/duration_relative.dart';
import '../pages/duration_short_forms.dart';
import '../pages/ext_end_of.dart';
import '../pages/ext_generic.dart';
import '../pages/ext_is_at_same.dart';
import '../pages/ext_overview.dart';
import '../pages/ext_relative_finders.dart';
import '../pages/ext_set_clamped.dart';
import '../pages/ext_start_of.dart';
import '../pages/ext_weekday.dart';
import '../pages/formatting.dart';
import '../pages/getting_started.dart';
import '../pages/global_localization.dart';
import '../pages/localizations.dart';
import '../pages/moment.dart';
import '../pages/playground.dart';
import '../pages/time_range.dart';
import '../pages/upgrading.dart';
import 'model.dart';

final List<DocPage> docPages = [
  gettingStartedPage,
  upgradingPage,
  momentPage,
  commonMishapsPage,
  formattingPage,
  calendarPage,
  durationRelativePage,
  durationPrecisePage,
  durationShortFormsPage,
  timeRangePage,
  extOverviewPage,
  extGenericPage,
  extStartOfPage,
  extEndOfPage,
  extRelativeFindersPage,
  extWeekdayPage,
  extIsAtSamePage,
  extSetClampedPage,
  localizationsPage,
  globalLocalizationPage,
  creatingLocalizationPage,
  playgroundPage,
];

/// Sidebar groups, in order. Every page's [DocPage.group] is one of these.
const List<String> docGroups = [
  "Start here",
  "Displaying dates",
  "Time ranges",
  "DateTime extensions",
  "Languages",
  "Try it",
];

DocPage? pageAt(String path) {
  for (final page in docPages) {
    if (page.path == path) return page;
  }
  return null;
}
