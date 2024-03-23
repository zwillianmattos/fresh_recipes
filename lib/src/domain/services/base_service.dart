abstract class BaseService {
  final endpoint = '/';

  Future<List<T>> paginate<T>({
    String? query,
    int limit = 10,
    int page = 1,
  });
}
