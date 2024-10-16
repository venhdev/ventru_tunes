import 'package:flutter/material.dart';
import 'package:tunes/domain/entities/playlist_entity.dart';
import 'package:tunes/presentation/playlist/playlist_screen.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
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
        child: const Text(''),
      ),
    );
  }
}
