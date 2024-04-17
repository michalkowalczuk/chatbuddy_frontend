import 'package:flutter_bloc/flutter_bloc.dart';

class BuddyCubit extends Cubit<Buddy> {
  final List<Buddy> allBuddies = [
    const Buddy(
      id: "inu",
      name: "Shiba Inu",
      imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png",
      description: "Friendly, loyal and energetic",
    ),
    const Buddy(
      id: "owl",
      name: "Wise Owl",
      imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/owl.png",
      description: "Smart and mysterious",
    ),
    const Buddy(
      id: "rabbit",
      name: "Rabbit Grandma",
      imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rab.png",
      description: "Kind and caring",
    ),
  ];

  BuddyCubit() : super(Buddy.empty()) {
    emit(allBuddies.first);
  }

  Buddy currentBuddy() => state;

  void nextBuddy() {
    final currentIndex = allBuddies.indexOf(state);
    if (currentIndex >= 0 && currentIndex < allBuddies.length - 1) {
      emit(allBuddies[currentIndex + 1]);
    } else {
      emit(allBuddies.first);
    }
  }

  void previousBuddy() {
    final currentIndex = allBuddies.indexOf(state);
    if (currentIndex > 0) {
      emit(allBuddies[currentIndex - 1]);
    } else {
      emit(allBuddies.last);
    }
  }
}

class Buddy {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  const Buddy({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Buddy.empty() => const Buddy(
    id: "buddy-0",
    name: "",
    imageUrl: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png",
    description: "",
  );
}