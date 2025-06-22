import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/datasources/product_api.dart';
import '../../../data/models/repositories/product_repository_impl.dart';
import '../../task3_note_crud/operations/get_products_usecase.dart';
import '../controller/product_controller.dart';
import '../widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);
  final ProductController controller = Get.put(
    ProductController(
      GetProductsUseCase(
        ProductRepositoryImpl(ProductApi()),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Products')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Obx(() => DropdownButton<String>(
                      value: controller.selectedCategory.value.isEmpty
                          ? 'All'
                          : controller.selectedCategory.value,
                      items: controller.categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ))
                          .toList(),
                      onChanged: controller.onCategoryChanged,
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  // Skeleton loader
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemCount: 6,
                    itemBuilder: (_, __) => const SkeletonLoader(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: controller.refreshProducts,
                  child: controller.filteredProducts.isEmpty
                      ? const Center(child: Text('No products found'))
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 8, mainAxisSpacing: 8),
                          itemCount: controller.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = controller.filteredProducts[index];
                            return ProductItem(product: product);
                          },
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
} 