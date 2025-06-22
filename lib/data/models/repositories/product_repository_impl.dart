import '../product/product.dart';
import '../product/product_repository.dart';
import '../../datasources/product_api.dart';
import '../product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi api;
  ProductRepositoryImpl(this.api);

  @override
  Future<List<Product>> getProducts() async {
    final List<ProductModel> models = await api.fetchProducts();
    return models
        .map((m) => Product(
              id: m.id,
              title: m.title,
              price: m.price,
              description: m.description,
              category: m.category,
              image: m.image,
              rating: m.rating,
            ))
        .toList();
  }
} 