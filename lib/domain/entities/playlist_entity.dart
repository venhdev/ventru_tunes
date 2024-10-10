import 'track_entity.dart';

class PlaylistEntity {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final String image;
  final int followers;
  final List<TrackEntity> tracks;

  PlaylistEntity({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.image,
    required this.followers,
    required this.tracks,
  });
}
