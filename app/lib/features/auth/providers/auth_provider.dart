import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/auth_repository.dart';
import '../data/models/user_model.dart';
import 'package:uuid/uuid.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthNotifier extends AsyncNotifier<UserModel?> {
  static const _userKey = 'loggedInUsername';

  @override
  Future<UserModel?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_userKey);
    if (username != null) {
      final repository = ref.read(authRepositoryProvider);
      return await repository.getUserByUsername(username);
    }
    return null;
  }

  Future<bool> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.authenticateUser(username, password);
      state = AsyncValue.data(user);
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userKey, user.username);
        return true;
      }
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String username,
    required String password,
    required String question,
    required String answer,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final exists = await repository.getUserByUsername(username);
      if (exists != null) {
        // Username already taken
        state = const AsyncValue.data(null);
        return false;
      }

      final uuid = const Uuid().v4();
      final user = UserModel(
        id: uuid,
        name: name,
        username: username,
        password: password,
        securityQuestion: question,
        securityAnswer: answer,
      );

      await repository.registerUser(user);
      
      // Auto login after register
      state = AsyncValue.data(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, user.username);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final authStateProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(() {
  return AuthNotifier();
});

// Provider for password reset flow (temporary username holder)
class ResetUsernameNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  
  void setUsername(String? username) => state = username;
}

final resetUsernameProvider = NotifierProvider<ResetUsernameNotifier, String?>(() {
  return ResetUsernameNotifier();
});
