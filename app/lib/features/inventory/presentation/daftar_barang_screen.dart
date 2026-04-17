import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class DaftarBarangScreen extends StatelessWidget {
  const DaftarBarangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBackground,
      appBar: AppBar(
        backgroundColor: AppColors.warmSurface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        title: Text(
          'Daftar Barang',
          style: AppTextStyles.h2.copyWith(color: AppColors.olive900),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.barcode, color: AppColors.olive700),
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
                      _buildFilterChip('Semua (1.248)', isSelected: true),
                      const SizedBox(width: 8),
                      _buildFilterChip('Sembako (450)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Minuman (300)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Snack (210)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: AppSpacing.m, bottom: 100), // padding for FAB
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                // Mock Data Pattern
                final items = [
                  {'name': 'Minyak Goreng 2L', 'sku': 'SKU-001A', 'stock': '15 Botol', 'price': 'Rp 34.000', 'status': 'Aman'},
                  {'name': 'Beras Pandan Wangi 5kg', 'sku': 'SKU-BM02', 'stock': '1 Karung', 'price': 'Rp 75.000', 'status': 'Menipis'},
                  {'name': 'Indomie Goreng Reguler', 'sku': 'SKU-IN23', 'stock': '120 Bungkus', 'price': 'Rp 3.000', 'status': 'Aman'},
                  {'name': 'Kopi Kapal Api 165gr', 'sku': 'SKU-KP01', 'stock': '30 Pcs', 'price': 'Rp 14.500', 'status': 'Aman'},
                  {'name': 'Gula Pasir Kuning 1kg', 'sku': 'SKU-GP01', 'stock': '45 Kg', 'price': 'Rp 16.000', 'status': 'Aman'},
                ];
                
                final item = items[index];
                return _buildItemCard(context, item);
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

  Widget _buildItemCard(BuildContext context, Map<String, String> item) {
    bool isLowStock = item['status'] == 'Menipis';
    
    return InkWell(
      onTap: () => context.push('/barang/detail'),
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
                          item['name']!,
                          style: AppTextStyles.h3.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        item['price']!,
                        style: AppTextStyles.h3.copyWith(fontSize: 14, color: AppColors.olive700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['sku']!,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.warmMutedGray,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isLowStock ? AppColors.errorContainer : AppColors.sage300.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Sisa: ${item['stock']}',
                          style: AppTextStyles.bodySm.copyWith(
                            color: isLowStock ? AppColors.error : AppColors.olive700,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
