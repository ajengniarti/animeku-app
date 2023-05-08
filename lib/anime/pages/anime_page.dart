import 'package:animeku/anime/providers/anime_get_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AnimeGetListProvider>().getList(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animeku'),
      ),
      body: Consumer<AnimeGetListProvider>(
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (_, Provider, __) {
          if (Provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (Provider.anime.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final anime = Provider.anime[index];

                return ListTile(
                  title: Text(anime.title),
                  subtitle: Text(anime.synopsis),
                );
              },
            );
          }

          return const Center(
            child: Text('Not Found List Anime'),
          );
        },
      ),
    );
  }
}
