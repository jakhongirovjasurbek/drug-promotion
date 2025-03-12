import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for managing persistent key-value storage using
/// `SharedPreferences`. This class provides methods for saving,
/// retrieving, and deleting various data types such as strings,
/// string lists, doubles, booleans, and integers.
///
/// This class uses the singleton pattern to ensure a single instance
/// of `StorageRepository` is used throughout the application.
///
/// Usage:
/// ```dart
/// final storage = await StorageRepository.getInstance();
/// storage.putString('key', 'value');
/// String value = storage.getString('key', defValue: 'default');
/// ```
///
/// Note:
/// - Ensure `getInstance` is called before using other methods,
///   as it initializes the internal `SharedPreferences` instance.
///
/// Methods:
/// - **Strings**
///   - `putString(String key, String value)`
///   - `getString(String key, {String defValue = ''})`
///   - `deleteString(String key)`
///
/// - **String Lists**
///   - `putStringList(String key, List<String> value)`
///   - `getStringList(String key, {List<String> defValue = const []})`
///
/// - **Doubles**
///   - `putDouble(String key, double value)`
///   - `getDouble(String key, {double defValue = 0.0})`
///   - `deleteDouble(String key)`
///
/// - **Booleans**
///   - `putBool({required String key, required bool value})`
///   - `getBool(String key, {bool defValue = true})`
///   - `deleteBool(String key)`
///
/// - **Integers**
///   - `putInt({required String key, required int value})`
///   - `getInt(String key, {int defValue = 0})`
///   - `deleteInt(String key)`
class StorageRepository {
  static StorageRepository? _storageUtil;

  static SharedPreferences? _preferences;

  static Future<StorageRepository> getInstance() async {
    if (_storageUtil == null) {
      final secureStorage = StorageRepository._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  /// A private constructor to enforce the singleton pattern and ensure
  /// the class can only be instantiated internally.
  StorageRepository._();

  /// A private method to initialize the `SharedPreferences` instance.
  /// This must be called during the singleton initialization.
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Saves a string value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(key, value);
  }

  /// Retrieves a string value for the given [key].
  ///
  /// If the value does not exist, returns the provided [defValue] (default: an empty string).
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;

    return _preferences!.getString(key) ?? defValue;
  }

  /// Deletes the string value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? deleteString(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  /// Saves a list of strings associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? putStringList(String key, List<String> value) {
    if (_preferences == null) return null;
    return _preferences!.setStringList(key, value);
  }

  /// Retrieves a list of strings for the given [key].
  ///
  /// If the value does not exist, returns the provided [defValue] (default: an empty list).
  static List<String> getStringList(
    String key, {
    List<String> defValue = const [],
  }) {
    if (_preferences == null) return List.empty(growable: true);
    return _preferences!.getStringList(key) ?? List.empty(growable: true);
  }

  /// Retrieves a double value for the given [key].
  ///
  /// If the value does not exist, returns the provided [defValue] (default: 0.0).
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences!.getDouble(key) ?? defValue;
  }

  /// Saves a double value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? putDouble(String key, double value) {
    if (_preferences == null) return null;
    return _preferences!.setDouble(key, value);
  }

  /// Deletes the double value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? deleteDouble(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  /// Retrieves a boolean value for the given [key].
  ///
  /// If the value does not exist, returns the provided [defValue] (default: true).
  static bool getBool(String key, {bool defValue = true}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  /// Saves a boolean value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? putBool({required String key, required bool value}) {
    if (_preferences == null) return null;
    return _preferences!.setBool(key, value);
  }

  /// Deletes the boolean value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? deleteBool(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  /// Retrieves an integer value for the given [key].
  ///
  /// If the value does not exist, returns the provided [defValue] (default: 0).
  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences!.getInt(key) ?? defValue;
  }

  /// Saves an integer value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? putInt({required String key, required int value}) async {
    if (_preferences == null) return false;
    return await _preferences!.setInt(key, value);
  }

  /// Deletes the integer value associated with the given [key].
  ///
  /// Returns a `Future<bool>` indicating success or failure, or `null`
  /// if the preferences instance has not been initialized.
  static Future<bool>? deleteInt(String key) async {
    if (_preferences == null) return false;
    return await _preferences!.remove(key);
  }
}
