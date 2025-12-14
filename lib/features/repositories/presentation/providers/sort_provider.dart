import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortField { stars, updated }
enum SortOrder { asc, desc }

class SortState {
  final SortField field;
  final SortOrder order;

  const SortState({
    required this.field,
    required this.order,
  });

  SortState copyWith({
    SortField? field,
    SortOrder? order,
  }) {
    return SortState(
      field: field ?? this.field,
      order: order ?? this.order,
    );
  }
}

final sortProvider =
StateNotifierProvider<SortNotifier, SortState>((ref) {
  return SortNotifier();
});

class SortNotifier extends StateNotifier<SortState> {
  static const _fieldKey = 'sort_field';
  static const _orderKey = 'sort_order';

  SortNotifier()
      : super(const SortState(
    field: SortField.stars,
    order: SortOrder.desc,
  )) {
    _load();
  }

  /// Change between stars ↔ updated
  void toggleField() {
    state = state.copyWith(
      field: state.field == SortField.stars
          ? SortField.updated
          : SortField.stars,
    );
    _save();
  }

  /// Change asc ↔ desc
  void toggleOrder() {
    state = state.copyWith(
      order: state.order == SortOrder.asc
          ? SortOrder.desc
          : SortOrder.asc,
    );
    _save();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final field = prefs.getString(_fieldKey);
    final order = prefs.getString(_orderKey);

    state = SortState(
      field: field != null
          ? SortField.values.byName(field)
          : SortField.stars,
      order: order != null
          ? SortOrder.values.byName(order)
          : SortOrder.desc,
    );
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_fieldKey, state.field.name);
    prefs.setString(_orderKey, state.order.name);
  }
}