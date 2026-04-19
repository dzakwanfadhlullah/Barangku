import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../providers/inventory_provider.dart';
import '../data/models/item_model.dart';
import 'package:intl/intl.dart';

// No StateProvider needed, using useState locally

class DaftarBarangScreen extends HookConsumerWidget {
  const DaftarBarangScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memastikan data dimuat pertama kali
    useEffect(() {
      Future.microtask(() => ref.read(inventoryProvider.notifier).loadItems());
      return null;
    }, []);

    final itemsState = ref.watch(inventoryProvider);
    final searchQuery = useState<String>('');

    return Scaffold(
      backgroundColor: AppColors.warmBackground,
      appBar: AppBar(
        backgroundColor: AppColors.warmSurface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        title: Text(
          'Daftar Barang',
          style: AppTextStyles.h2.copyWith(color: AppColors.olive700),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.qrCode, color: AppColors.olive700),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.filter, color: AppColors.olive700),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.olive700,
        onPressed: () => context.push('/barang/tambah'),
        icon: const Icon(LucideIcons.plus, color: Colors.white),
        label: Text(
          'Barang',
          style: AppTextStyles.bodyMd.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Bar & Filter
          Container(
            padding: const EdgeInsets.all(AppSpacing.l),
            decoration: BoxDecoration(
              color: AppColors.warmSurface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.softCharcoal.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  style: AppTextStyles.bodyMd,
                  onChanged: (val) => searchQuery.value = val,
                  decoration: InputDecoration(
                    hintText: 'Cari nama barang, kode SKU...',
                    hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
                    prefixIcon: const Icon(LucideIcons.search, color: AppColors.warmMutedGray),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.olive700.withValues(alpha: 0.5), width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua', isSelected: true),
                      const SizedBox(width: 8),
                      _buildFilterChip('Sembako'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Minuman'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Snack'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: itemsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Terjadi kesalahan: $e')),
              data: (items) {
                // Filter
                final filtered = items.where((item) {
                  final q = searchQuery.value.toLowerCase();
                  return item.name.toLowerCase().contains(q) || (item.sku?.toLowerCase().contains(q) ?? false);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('Belum ada barang.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(top: AppSpacing.m, bottom: 100), // padding for FAB
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return _buildItemCard(context, ref, item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.olive700 : Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: isSelected ? null : Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySm.copyWith(
          color: isSelected ? Colors.white : AppColors.softCharcoal,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, WidgetRef ref, ItemModel item) {
    bool isLowStock = item.initialStock <= 5;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    
    return InkWell(
      onTap: () => context.push('/barang/detail', extra: item),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.softCharcoal.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.warmSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(LucideIcons.package, color: AppColors.warmMutedGray),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: AppTextStyles.h3.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        currencyFormat.format(item.price),
                        style: AppTextStyles.h3.copyWith(fontSize: 14, color: AppColors.olive700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.sku ?? 'Tanpa SKU',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.warmMutedGray,
                          fontSize: 11,
                        ),
                      ),
                      // Trigger untuk Popup
                      InkWell(
                        onTap: () => _showQuickStockPopup(context, ref, item),
                        child: Icon(LucideIcons.listPlus, size: 18, color: AppColors.olive700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isLowStock ? AppColors.error.withValues(alpha: 0.1) : AppColors.sage300.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Sisa: ${item.initialStock} ${item.unit ?? ''}',
                      style: AppTextStyles.bodySm.copyWith(
                        color: isLowStock ? AppColors.error : AppColors.olive700,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickStockPopup(BuildContext context, WidgetRef ref, ItemModel item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Penyesuaian Stok Cepat', style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.s),
              Text(item.name, style: AppTextStyles.bodyLg.copyWith(color: AppColors.warmMutedGray)),
              const SizedBox(height: AppSpacing.xxl),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PopupActionBtn(
                    icon: LucideIcons.minus,
                    onTap: () {
                      if (item.initialStock > 0) {
                        ref.read(inventoryProvider.notifier).adjustStock(item, -1);
                        Navigator.pop(ctx);
                      }
                    },
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Text('${item.initialStock}', style: AppTextStyles.h1.copyWith(fontSize: 32)),
                  const SizedBox(width: AppSpacing.xl),
                  _PopupActionBtn(
                    icon: LucideIcons.plus,
                    onTap: () {
                      ref.read(inventoryProvider.notifier).adjustStock(item, 1);
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        );
      },
    );
  }
}

class _PopupActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PopupActionBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.sage300.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.olive700.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, size: 32, color: AppColors.olive700),
      ),
    );
  }
}
