import 'package:fresh_recipes/src/data/helper/header.dart';
import 'package:fresh_recipes/src/domain/entities/photo.dart';
import 'package:fresh_recipes/src/domain/services/image_service.dart';
import 'package:uno/uno.dart';

class ImageUploadServiceImpl extends ImageUploadService {
  final Uno http;
  ImageUploadServiceImpl(this.http);

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<Photos> upload(String path) async {
    try {
      final formData = FormData();
      formData.addFile('photo', path);

      Response response = await http.post(
        endpoint,
        data: formData,
        headers: await headers(
          authorizer: true,
        ),
      );
      if (response.status != 201) {
        throw Exception(response.data['message']);
      }
      return Photos.fromJson(response.data);
    } catch (e) {
      if (e is UnoError) {
        throw Exception(e.response?.data['message']);
      }
      throw Exception('Erro durante o login: $e');
    }
  }
}
