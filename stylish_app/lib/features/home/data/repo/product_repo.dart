import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';

class ProductsRepository {
  final ApiHelper apiHelper;

  ProductsRepository({required this.apiHelper});

  Future<ApiResponse> getAllProducts() async {
    return await apiHelper.getRequest(endPoint: 'products');
  }
}
