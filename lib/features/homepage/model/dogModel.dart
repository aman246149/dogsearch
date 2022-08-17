// ignore: file_names
class DogModel {
  final String name;
  final String url;

  DogModel({required this.name, required this.url});

  factory DogModel.fromJson(Map<String, dynamic> map) {
    return DogModel(name: map["name"], url: map["image"]["url"]);
  }
}
