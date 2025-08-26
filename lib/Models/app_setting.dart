class AppSettingsModel {
  final String userId;
  final bool notificationEnabled;
  final bool healthAlertsEnabled;
  final bool dailySummaryEnabled;
  final String dataSyncFrequency;
  final bool darkModeEnabled;
  final String language;

  AppSettingsModel({
    required this.userId,
    required this.notificationEnabled,
    required this.healthAlertsEnabled,
    required this.dailySummaryEnabled,
    required this.dataSyncFrequency,
    required this.darkModeEnabled,
    required this.language,
  });
}
