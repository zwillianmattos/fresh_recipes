import 'package:fresh_recipes/src/domain/services/base_service.dart';

abstract class ImageUploadService implements BaseService {
  @override
  final endpoint = '/photos/upload';

  upload(String path);
}
