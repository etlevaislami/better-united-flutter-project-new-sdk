import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/grant_type.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/apple_authentication.dart';
import 'package:flutter_better_united/data/net/facebook_authentication.dart';
import 'package:flutter_better_united/data/net/google_authentication.dart';
import 'package:flutter_better_united/data/net/models/auth_response.dart';
import 'package:flutter_better_united/data/net/models/delete_account_request.dart';
import 'package:flutter_better_united/data/net/token_authentication.dart';
import 'package:flutter_better_united/data/repo/profile_repository.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../run.dart';
import '../../util/settings.dart';
import '../model/user.dart';
import 'interceptors/error_interceptor.dart';
import 'models/auth_request.dart';
import 'models/forgot_password_request.dart';
import 'models/register_request.dart';
import 'models/reset_password_request.dart';

class AuthenticatorManager {
  final storage = const FlutterSecureStorage();
  final ApiService restClient;
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
  static const emailAddress = "email_address";
  static const String userDataKey = "USER_DATA";
  final ProfileRepository _profileRepository;
  late final FacebookAuthentication facebookAuthentication =
      FacebookAuthentication(restClient);
  late final GoogleAuthentication googleAuthentication =
      GoogleAuthentication(restClient);
  late final AppleAuthentication appleAuthentication =
      AppleAuthentication(restClient);
  String? _accessToken;
  User? _connectedUser;

  User? get connectedUser {
    _connectedUser ??= _getUser();
    return _connectedUser;
  }

  set connectedUser(User? user) {
    _connectedUser = user;
    _saveUser(user);
  }

  _saveUser(User? user) async {
    if (user != null) {
      String json = jsonEncode(user);
      sharedPreferences.setString(userDataKey, json);
    }
  }

  updateUserCoinBalance(int coins) {
    connectedUser?.coinBalance = coins;
    _saveUser(connectedUser);
  }

  updateUserTipCreation() {
    connectedUser?.hasCreatedTips = true;
    _saveUser(connectedUser);
  }

  User? _getUser() {
    var data = sharedPreferences.getString(userDataKey);
    return data == null ? null : User.fromJson(jsonDecode(data));
  }

  AuthenticatorManager(this.restClient, this._profileRepository);

  Future<String?> getAccessToken() async {
    _accessToken = _accessToken ?? await storage.read(key: accessToken);
    return _accessToken;
  }

  Future removeAuthenticationCredentials() async {
    await storage.deleteAll();
    final friendLeagueInvitation =
        sharedPreferences.getString(Settings.leagueInvitationKey);

    Locale? locale = getSavedLocale();
    // clear everything except friend invitation and locale
    sharedPreferences.clear();
    if (friendLeagueInvitation != null) {
      sharedPreferences.setString(
          Settings.leagueInvitationKey, friendLeagueInvitation);
    }
    if (locale != null) {
      saveLocale(locale);
    }
  }

  setAccessToken(String token) {
    storage.write(key: accessToken, value: token);
    _accessToken = token;
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: refreshToken);
  }

  setRefreshToken(String token) {
    storage.write(key: refreshToken, value: token);
  }

  storeEmailAddress(String email) {
    storage.write(key: emailAddress, value: email);
  }

  Future<AuthStatus> loginWithToken(TokenAuthentication authentication) async {
    await removeAuthenticationCredentials();
    final authResult = await authentication.loginWithToken();
    final authResponse = authResult.authResponse;
    final email = authResult.email;
    if (authResponse != null && email != null) {
      await _postLogin(email, authResponse);
    }
    return authResult.loginStatus;
  }

  Future<AuthStatus> loginWithGoogle() async {
    return loginWithToken(googleAuthentication);
  }

  Future<AuthStatus> loginWithFacebook() async {
    return loginWithToken(facebookAuthentication);
  }

  Future<AuthStatus> loginWithApple() async {
    return loginWithToken(appleAuthentication);
  }

  Future<AuthStatus> loginWithPassword(String email, String password) async {
    try {
      final authResponse = await _getTokenWithCredentials(email, password);
      await _postLogin(email, authResponse);
      return AuthStatus.success;
    } on UnauthorizedException {
      return AuthStatus.invalidCredentials;
    } catch (exception, e) {
      logger.e(exception);
      print(e);
    }
    return AuthStatus.failed;
  }

  Future<AuthResponse> _getTokenWithCredentials(String email, String password) {
    return restClient.login(
        AuthRequest(GrantType.password, email: email, password: password));
  }

  Future _postLogin(String email, AuthResponse authResponse) async {
    setAccessToken(authResponse.accessToken);
    setRefreshToken(authResponse.refreshToken);
    storeEmailAddress(email);
    final user = await _profileRepository.getProfile();
    _saveUser(user);
    //todo remove?
    //await _siteSettings.syncSiteSettings();
    final locale = getSavedLocale();
    if (locale != null) {
      await _profileRepository.setLanguage(locale);
    }
  }

  Future forgotPassword(String email) async {
    return restClient.forgotPassword(ForgotPasswordRequest(email));
  }

  Future resetPassword(String userId, String token, String password) async {
    return restClient.resetPassword(
        userId, token, ResetPasswordRequest(password));
  }

  Future register(String email, String password) {
    return restClient
        .register(RegisterRequest(email, password))
        .then((_) => _getTokenWithCredentials(email, password))
        .then((authResponse) => _postLogin(email, authResponse));
  }

  Future<bool> isAuthenticated() async {
    return await getAccessToken() != null;
  }

  Future deleteUser(String password) {
    return restClient
        .deleteProfile(DeleteAccountRequest(password))
        .then((value) => removeAuthenticationCredentials());
  }

  bool isProfileCompleted() {
    return connectedUser?.nickname != null &&
        connectedUser?.dateOfBirth != null;
  }

  bool shouldRemoveCredentials() {
    return connectedUser != null && !isProfileCompleted();
  }
}