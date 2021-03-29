import 'package:shared_preferences/shared_preferences.dart';

class PreferenciaUsuario {

  static final PreferenciaUsuario _instance = new PreferenciaUsuario._internal();

  factory PreferenciaUsuario(){
    return _instance;
  }

  PreferenciaUsuario._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  /// Push Notification
  get receivePushNotification {
    return _prefs.getBool('receive_push_notification') ?? false;
  }

  set receivePushNotification(bool value) {
    _prefs.setBool('receive_push_notification', value);
  }

  /// Email
  bool get receiveEmailWhenNewCampaign => _prefs.getBool('receive_email') ?? false;

  set receiveEmailWhenNewCampaign(bool value) {
    _prefs.setBool('receive_email', value);
  }

  /// Share Medical History
  bool get allowShareMedicalHistory => _prefs.getBool('allow_share_medical_history') ?? false;

  set allowShareMedicalHistory(bool value) {
    _prefs.setBool('allow_share_medical_history', value);
  }

  /// Share Personal Data to be part of Stats and Analytics
  bool get shareMyDataToHelpVacineControl => _prefs.getBool('share_data_analytics') ?? false;

  set shareMyDataToHelpVacineControl(bool value) {
    _prefs.setBool('share_data_analytics', value);
  }
}