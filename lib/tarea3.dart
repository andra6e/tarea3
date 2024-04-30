import 'dart:convert';
import 'package:http/http.dart' as http;

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

Future<List<Photo>> fetchPhotos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Photo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}

void main(List<String> arguments) async {
  try {
    List<Photo> photos = await fetchPhotos();
    for (var photo in photos) {
      print('Photo ID: ${photo.id}');
      print('Title: ${photo.title}');
      print('URL: ${photo.url}');
      print('Thumbnail URL: ${photo.thumbnailUrl}');
      print('==============================');
    }
  } catch (e) {
    print('Error: $e');
  }
}