import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../data/models/item_model.dart';
import '../providers/inventory_provider.dart';
import 'package:intl/intl.dart';

class DetailBarangScreen extends HookConsumerWidget {
  final ItemModel item;
  
  const DetailBarangScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tonton state jika item di-update dari layar lain (misal dapet perubahan harga/stok)
    // namun kita lebih baik ambil dari list Riverpod berdasar ID
    final items = ref.watch(inventoryProvider).value ?? [];
    final currentItem = items.firstWhere((i) => i.id == item.id, orElse: () => item);

    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.warmBackground,
      appBar: AppBar(
        backgroundColor: AppColors.warmSurface,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Detail Barang',
          style: AppTextStyles.h3.copyWith(color: AppColors.olive700),
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.olive700),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.moreVertical, color: AppColors.olive700),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Placeholder
              Container(
                height: 240,
                width: double.infinity,
                color: AppColors.warmSurface,
                child: const Icon(LucideIcons.image, size: 64, color: AppColors.warmMutedGray),
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            currentItem.name,
                            style: AppTextStyles.h1.copyWith(fontSize: 24),
                          ),
                        ),
                        if (currentItem.category != null && currentItem.category!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.sage300.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              currentItem.category!,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.olive700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.m),
                    Text(
                      currencyFormat.format(currentItem.price),
                      style: AppTextStyles.h2.copyWith(color: AppColors.olive700),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Info Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            icon: LucideIcons.qrCode,
                            label: 'SKU',
                            value: currentItem.sku?.isNotEmpty == true ? currentItem.sku! : '-',
                          ),
                        ),
                        const SizedBox(width: AppSpacing.m),
                        Expanded(
                          child: _buildInfoCard(
                            icon: LucideIcons.package,
                            label: 'Stok Tersedia',
                            value: '${currentItem.initialStock} ${currentItem.unit ?? ''}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Detail Tambahan
                    Text(
                      'Informasi Tambahan',
                      style: AppTextStyles.h3,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    _buildDetailRow('Deskripsi', currentItem.description?.isNotEmpty == true ? currentItem.description! : 'Tidak ada deskripsi'),
                    _buildDetailRow('Ditambahkan', DateFormat('dd MMM yyyy, HH:mm').format(currentItem.createdAt)),

                    const SizedBox(height: AppSpacing.xxxl),

                    // Actions
                    AppButton(
                      text: 'Ubah Data',
                      icon: const Icon(LucideIcons.edit2, size: 18),
                      onPressed: () => context.push('/barang/ubah', extra: currentItem),
                    ),
                    const SizedBox(height: AppSpacing.m),
                    AppButton(
                      text: 'Hapus Barang',
                      type: AppButtonType.text,
                      icon: const Icon(LucideIcons.trash2, size: 18, color: AppColors.error),
                      onPressed: () {
                        _showDeleteConfirm(context, ref, currentItem);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, ItemModel item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Barang?'),
        content: Text('Apakah Anda yakin ingin menghapus ${item.name}? Data tidak dapat dikembalikan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              ref.read(inventoryProvider.notifier).deleteItem(item.id);
              Navigator.of(ctx).pop();
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Barang berhasil dihapus.')),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    bool isValueAlert = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutralDivider.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.warmMutedGray),
          const SizedBox(height: AppSpacing.m),
          Text(
            label,
            style: AppTextStyles.bodySm.copyWith(color: AppColors.warmMutedGray),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              color: isValueAlert ? AppColors.error : AppColors.softCharcoal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.warmMutedGray),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.softCharcoal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
