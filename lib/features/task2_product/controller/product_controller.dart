import 'package:get/get.dart';
import '../../../data/models/product/product.dart';
import '../../task3_note_crud/operations/get_products_usecase.dart';

class ProductController extends GetxController {
  final GetProductsUseCase getProductsUseCase;
  ProductController(this.getProductsUseCase);

  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final result = await getProductsUseCase();
      products.value = result;
      categories.value = ['All', ...result.map((e) => e.category).toSet()];
      applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    var list = products;
    if (selectedCategory.value.isNotEmpty && selectedCategory.value != 'All') {
      list = list.where((p) => p.category == selectedCategory.value).toList().obs;
    }
    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((p) => p.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList()
          .obs;
    }
    filteredProducts.value = list;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void onCategoryChanged(String? category) {
    selectedCategory.value = category ?? '';
    applyFilters();
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }
} 