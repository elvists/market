import 'dart:convert';
import 'package:market/core/app_shared_prefs_keys.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_util.dart';

abstract class SharedPreferencesUtil {
  static Future<SharedPreferences> _getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }

  static Future removeKey(String key) async {
    var sharedPreferences = await _getSharedPreferences();
    sharedPreferences.remove(key);
  }

  static Future<void> saveToken(Token token) async {
    var sharedPreferences = await _getSharedPreferences();
    await sharedPreferences.setString(
        AppSharedPrefsKeys.token, json.encode(token.toJson()));
  }

  static Future<void> saveCart(List<CartProduct> cartProducts) async {
    var sharedPreferences = await _getSharedPreferences();
    await sharedPreferences.setString(
        AppSharedPrefsKeys.cart, CartUtil.encode(cartProducts));
  }

  static Future<Token> retrieveToken() async {
    var sharedPreferences = await _getSharedPreferences();
    var tokenJson = sharedPreferences.getString(AppSharedPrefsKeys.token);
    if (tokenJson == null) return null;
    return Token.fromJson(json.decode(tokenJson));
  }

  static Future<List<CartProduct>> retrieveCart() async {
    var sharedPreferences = await _getSharedPreferences();
    var cartJson = sharedPreferences.getString(AppSharedPrefsKeys.cart);
    if (cartJson == null) return [];
    return CartUtil.decode(cartJson);
  }

  static Future<bool> hasToken() async {
    var sharedPreferences = await _getSharedPreferences();
    var tokenJson = sharedPreferences.getString(AppSharedPrefsKeys.token);
    return tokenJson != null;
  }
}
