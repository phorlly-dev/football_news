import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

/// A generic GetX controller for Firebase Realtime Database.
/// Provides CRUD + realtime streams with automatic reactive updates.
abstract class Controller<T> extends GetxController {
  final cnx = GetConnect();
  final DatabaseReference _db;
  final String path;
  final T Function(Map<String, dynamic> json) fromJson;
  late StreamSubscription _sub;

  Controller({required this.path, required this.fromJson})
    : _db = FirebaseDatabase.instance.ref();

  DatabaseReference get ref => _db.child(path);

  // Reactive list for UI binding
  final RxList<T> items = <T>[].obs;

  // Optional: single item reactive variable
  final Rxn<T> current = Rxn<T>();

  // ---------- CREATE / UPDATE ----------
  Future<void> set(Map<String, dynamic> value) =>
      _safeCall(() => ref.set(value));

  Future<void> saveChange(Map<String, dynamic> value) =>
      _safeCall(() => ref.update(value));

  Future<String> push(Map<String, dynamic> value) async {
    cnx.get('url', query: {'d': 1});
    return _safeCall(() async {
      final newRef = ref.push();
      final key = newRef.key;
      if (key == null) {
        throw Exception('Failed to generate key for ${ref.path}');
      }
      await newRef.set({'id': key, ...value});

      return key;
    });
  }

  // ---------- READ ----------
  Future<T?> get({String? id}) async {
    return _safeCall(() async {
      final snapshot = await (id != null ? ref.child(id).get() : ref.get());
      if (!snapshot.exists || snapshot.value == null) return null;
      return fromJson(_castToMap(snapshot.value));
    });
  }

  Future<List<T>> gets() async {
    return _safeCall(() async {
      final snapshot = await ref.get();
      if (!snapshot.exists || snapshot.value == null) return [];
      final data = _castToMap(snapshot.value);
      return data.values
          .map((e) => fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  // ---------- DELETE ----------
  Future<void> delete({String? id}) async {
    await _safeCall(() async {
      final target = id != null ? ref.child(id) : ref;
      await target.remove();
    });
  }

  // ---------- STREAMS (REALTIME + REACTIVE) ----------
  /// Listen to a single record and auto-update [current].
  void bind(String id) {
    _sub = ref.child(id).onValue.listen((event) {
      if (!event.snapshot.exists || event.snapshot.value == null) {
        current.value = null;
        return;
      }

      current.value = fromJson(_castToMap(event.snapshot.value));
    });
  }

  /// Listen to all records and auto-update [items].
  void binds() {
    _sub = ref.onValue.listen((event) {
      if (!event.snapshot.exists || event.snapshot.value == null) {
        items.clear();
        return;
      }
      final data = _castToMap(event.snapshot.value);
      items.assignAll(
        data.values.map((e) => fromJson(Map<String, dynamic>.from(e))).toList(),
      );
    });
  }

  // ---------- HELPERS ----------
  Future<R> _safeCall<R>(Future<R> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Map<String, dynamic> _castToMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return Map<String, dynamic>.from(value as Map);
  }

  // ---------- LIFECYCLE ----------
  @override
  void onClose() {
    _sub.cancel();
    super.onClose();
  }
}
