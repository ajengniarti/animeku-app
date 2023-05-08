import 'package:animeku/anime/models/anime_model.dart';
import 'package:animeku/anime/repostories/anime_repository.dart';
import 'package:flutter/material.dart';

class AnimeGetListProvider with ChangeNotifier {
  final AnimeRepository animeRepository;

  AnimeGetListProvider(this.animeRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<AnimeModel> _anime = [];
  List<AnimeModel> get anime => _anime;

  void getList(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await animeRepository.getList();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        _isLoading = false;
        notifyListeners();
        return;

      },
      (response) {
        _anime.clear();
        _anime.addAll(response.data);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }
}
