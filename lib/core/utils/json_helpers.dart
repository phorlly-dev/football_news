import 'package:flutter/widgets.dart';

T? safeParse<T>(dynamic data, T Function(Map<String, dynamic> json) fromJson) {
  if (data == null) return null;
  if (data is! Map) return null;

  return fromJson(Map<String, dynamic>.from(data));
}

T castToMap<T>(dynamic data, T Function(Map<String, dynamic> json) fromJson) {
  return fromJson(Map<String, dynamic>.from(data));
}

T? parseModel<T>(dynamic data, T Function(Map<String, dynamic> json) fromJson) {
  if (data is Map) return fromJson(Map<String, dynamic>.from(data));
  return null;
}

List<T> parseJsonList<T>(
  dynamic data,
  T Function(Map<String, dynamic> json) fromJson,
) {
  if (data is List) {
    try {
      return data
          .whereType<Map>() // filters only valid maps
          .map((e) => fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      debugPrint('⚠️ JSON parse error in parseJsonList: $e');
      return [];
    }
  }
  return [];
}
