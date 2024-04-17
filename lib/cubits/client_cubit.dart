import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ClientCubit extends Cubit<Client> {
  ClientCubit() : super(Client.empty());

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('client_id');
    final name = prefs.getString('client_name');
    final imageUrl = prefs.getString('client_imageUrl');

    if (id != null && name != null && imageUrl != null) {
      emit(Client(id: id, name: name, imageUrl: imageUrl));
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
    await _updateClientPrefs('client_name', newName);
    emit(updatedClient);
    return updatedClient;
  }

  Future<Client> setImageUrl(String newImageUrl) async {
    final updatedClient = state.copyWith(imageUrl: newImageUrl);
    await _updateClientPrefs('client_imageUrl', newImageUrl);
    emit(updatedClient);
    return updatedClient;
  }

  Future<void> _updateClientPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}

class Client {
  final String id;
  final String name;
  final String imageUrl;

  const Client({required this.id, required this.name, required this.imageUrl});

  factory Client.empty() {
    const uuid = Uuid();
    return Client(
      id: uuid.v4(),
      name: "Not set",
      imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/face.jpg",
    );
  }

  Client copyWith({String? id, String? name, String? imageUrl}) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
