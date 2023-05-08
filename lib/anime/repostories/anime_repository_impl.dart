import 'package:animeku/anime/models/anime_model.dart';
import 'package:animeku/anime/repostories/anime_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final Dio dio;

  AnimeRepositoryImpl(this.dio);

  @override
  Future<Either<String, AnimeResponseModel>> getList({int page = 1}) async {
    try {
      final result = await dio.get(
        '/anime',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null ) {
        final model = AnimeResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get list anime');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get list');
    }
  }
}
