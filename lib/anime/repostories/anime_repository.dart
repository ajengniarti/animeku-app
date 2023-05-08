import 'package:animeku/anime/models/anime_model.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeRepository {
  Future<Either<String, AnimeResponseModel>> getList({int page = 1 });
}