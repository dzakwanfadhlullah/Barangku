import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/inventory_repository.dart';
import '../data/models/item_model.dart';
import 'package:uuid/uuid.dart';

final inventoryRepositoryProvider = Provider((ref) => InventoryRepository());

class InventoryNotifier extends AsyncNotifier<List<ItemModel>> {
  @override
  Future<List<ItemModel>> build() async {
    return _fetchItems();
  }

  Future<List<ItemModel>> _fetchItems() async {
    final repo = ref.read(inventoryRepositoryProvider);
    return await repo.getAllItems();
  }

  Future<void> loadItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await _fetchItems();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addItem({
    required String name,
    String? sku,
    String? category,
    required int initialStock,
    String? unit,
    required double price,
    String? description,
  }) async {
    try {
      final repo = ref.read(inventoryRepositoryProvider);
      final newItem = ItemModel(
        id: const Uuid().v4(),
        name: name,
        sku: sku,
        category: category,
        initialStock: initialStock,
        unit: unit,
        price: price,
        description: description,
        createdAt: DateTime.now(),
        // Simple heuristic for status stock
        statusStock: initialStock > 5 ? 'Aman' : 'Menipis',
      );

      await repo.insertItem(newItem);
      await loadItems();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateItem(ItemModel updatedItem) async {
    try {
      final repo = ref.read(inventoryRepositoryProvider);
      
      // Update status dynamically if stock changed
      final stockS = updatedItem.initialStock > 5 ? 'Aman' : 'Menipis';
      final itemToSave = updatedItem.copyWith(statusStock: stockS);

      await repo.updateItem(itemToSave);
      await loadItems();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final repo = ref.read(inventoryRepositoryProvider);
      await repo.deleteItem(id);
      await loadItems();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> adjustStock(ItemModel item, int amount) async {
    final newStock = item.initialStock + amount;
    if (newStock < 0) return; // Disallow negative stock
    await updateItem(item.copyWith(initialStock: newStock));
  }
}

final inventoryProvider = AsyncNotifierProvider<InventoryNotifier, List<ItemModel>>(() {
  return InventoryNotifier();
});
