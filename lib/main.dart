import 'package:animeku/anime/pages/anime_page.dart';
import 'package:animeku/anime/providers/anime_get_list_provider.dart';
import 'package:animeku/anime/repostories/anime_repository.dart';
import 'package:animeku/anime/repostories/anime_repository_impl.dart';
import 'package:animeku/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // ignore: unused_local_variable
  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key' : AppConstants.apiKey, 'api_host' : AppConstants.apiHost},
  );

  final Dio dio = Dio();
  final AnimeRepository animeRepository = AnimeRepositoryImpl(dio);

  runApp( App(animeRepository: animeRepository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key, required this.animeRepository});

  final AnimeRepository animeRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AnimeGetListProvider(animeRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AnimePage(),
      ),
    );
  }
}
