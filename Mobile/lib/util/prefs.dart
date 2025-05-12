import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prefs.g.dart';

/// SharedPreferencesWithCache
///
/// This class is a wrapper around SharedPreferences that provides caching functionality.
@riverpod
Future<SharedPreferencesWithCache> prefs(Ref ref) =>
    SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
