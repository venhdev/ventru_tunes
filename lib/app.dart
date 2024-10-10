import 'package:flutter/material.dart';
import 'package:tunes/domain/entities/playlist_entity.dart';
import 'package:tunes/presentation/playlist/screens/playlist_screen.dart';

class TunesApp extends StatelessWidget {
  const TunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
      ),
      home: Scaffold(
        body: Center(child: Home()),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PlaylistScreen(
                  playlist: PlaylistEntity(
                    id: '1',
                    name: 'My Playlist',
                    description: 'My Description',
                    shortDescription: 'My Short Description',
                    image: 'https://via.placeholder.com/150',
                    followers: 100,
                    tracks: [],
                  ),
                );
              },
            ),
          );
        },
        icon: const Icon(Icons.logo_dev),
      ),
    );
  }
}
