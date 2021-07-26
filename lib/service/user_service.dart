import 'package:market/api/user_webclient.dart';
import 'package:market/core/app_shared_prefs_keys.dart';
import 'package:market/model/token.dart';
import 'package:market/util/shared_preferences_util.dart';
import 'package:meta/meta.dart';

class UserService {
  final UserWebClient userWebClient;

  UserService({UserWebClient webClient}) : userWebClient = webClient ?? UserWebClient();

  Future<Token> authenticate({
    @required String username,
    @required String password,
  }) async {
    var data = await userWebClient.authenticate(username: username, password: password);
    return Token.fromJson(data);
  }

  Future<void> deleteToken() async {
    await SharedPreferencesUtil.removeKey(AppSharedPrefsKeys.token);
  }

  Future<void> persistToken(Token token) async {
    await SharedPreferencesUtil.saveToken(token);
  }

  Future<bool> hasToken() async {
    return SharedPreferencesUtil.hasToken();
  }
}
