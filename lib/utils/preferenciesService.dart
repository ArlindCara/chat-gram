import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('name', settings.name);
    await preferences.setString('email', settings.email);
    await preferences.setString('about', settings.about);

    print('Saved modify');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final String? name = preferences.getString('name');
    final String? email = preferences.getString('email');
    final String? about = preferences.getString('about');

    return Settings(
      name: name ?? '',
      email: email ?? '',
      about: about ?? '',
    );
  }
}
