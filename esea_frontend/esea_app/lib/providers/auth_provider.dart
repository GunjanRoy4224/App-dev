import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final AppLinks _appLinks = AppLinks();

  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  StreamSubscription<Uri>? _linkSub;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    final cachedUser = await _storageService.getUser();
    if (cachedUser != null) {
      _user = cachedUser;
      _isAuthenticated = true;
    }

    await refreshProfile();
    await _startDeepLinkListener();

    _isLoading = false;
    notifyListeners();
  }

  Future<String?> getSSOLoginUrl() async {
    _isLoading = true;
    notifyListeners();

    final url = await _authService.getSSOLoginUrl();

    _isLoading = false;
    notifyListeners();

    return url;
  }

  Future<void> _startDeepLinkListener() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      await _handleDeepLink(initialUri);
    }

    _linkSub = _appLinks.uriLinkStream.listen(_handleDeepLink);
  }

  Future<void> _handleDeepLink(Uri uri) async {
    if (uri.scheme == 'esea' &&
        uri.host == 'auth' &&
        uri.path == '/callback') {
      final token = uri.queryParameters['token'];
      if (token != null) {
        await _handleSuccessfulLogin(token);
      }
    }
  }

  Future<void> _handleSuccessfulLogin(String token) async {
    await _authService.saveToken(token);
    await refreshProfile();
  }

  Future<void> refreshProfile() async {
  final freshUser = await _authService.fetchCurrentUser();

  if (freshUser == null) {
    // 🔥 Not authenticated
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
    return;
  }

  _user = freshUser;
  _isAuthenticated = true;
  await _storageService.saveUser(freshUser);
  notifyListeners();
}


  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }
}
