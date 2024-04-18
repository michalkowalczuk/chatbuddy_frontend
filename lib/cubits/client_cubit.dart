import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ClientCubit extends Cubit<Client> {
  ClientCubit() : super(Client.empty());

  final List<String> avatars = [
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f1.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f2.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f3.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f4.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f5.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f6.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f7.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f8.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f9.png'
  ];

  Client currentClient() => state;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('client_id');
    final name = prefs.getString('client_name');
    final imageUrl = prefs.getString('client_imageUrl');
    final adult = prefs.getBool('client_is_adult');

    if (id != null && name != null && imageUrl != null && adult != null) {
      emit(Client(id: id, name: name, imageUrl: imageUrl, adult: adult));
    } else {
      final newClient = Client.empty();
      await _saveToPrefs(newClient);
      emit(newClient);
    }
  }

  Future<void> _saveToPrefs(Client client) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('client_id', client.id);
    await prefs.setString('client_name', client.name);
    await prefs.setString('client_imageUrl', client.imageUrl);
  }

  Future<Client> setName(String newName) async {
    final updatedClient = state.copyWith(name: newName);
    await _updateClientPrefsString('client_name', newName);
    emit(updatedClient);
    return updatedClient;
  }
  
  Future<Client> setUnder18() async {
    final updatedClient = state.copyWith(adult: false);
    await _updateClientPrefsBool('client_is_adult', false);
    emit(updatedClient);
    return updatedClient;
  }

  void nextAvatar() {
    final currentIndex = avatars.indexOf(state.imageUrl);
    String imageUrl;
    if (currentIndex >= 0 && currentIndex < avatars.length - 1) {
      imageUrl = avatars[currentIndex + 1];
    } else {
      imageUrl = avatars.first;
    }
    _setImageUrl(imageUrl);
  }

  void previousAvatar() {
    final currentIndex = avatars.indexOf(state.imageUrl);
    String imageUrl;
    if (currentIndex > 0) {
      imageUrl = avatars[currentIndex - 1];
    } else {
      imageUrl = avatars.last;
    }
    _setImageUrl(imageUrl);
  }

  void _setImageUrl(String newImageUrl) async {
    final updatedClient = state.copyWith(imageUrl: newImageUrl);
    await _updateClientPrefsString('client_imageUrl', newImageUrl);
    emit(updatedClient);
  }

  Future<void> _updateClientPrefsString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _updateClientPrefsBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}

class Client {
  final String id;
  final String name;
  final String imageUrl;
  final bool adult;

  const Client({required this.id, required this.name, required this.imageUrl, required this.adult});

  factory Client.empty() {
    const uuid = Uuid();
    return Client(
      id: uuid.v4(),
      name: "Buddy User",
      imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f1.png",
      adult: true,
    );
  }

  Client copyWith({String? id, String? name, String? imageUrl, bool? adult}) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      adult: adult ?? this.adult,
    );
  }
}
