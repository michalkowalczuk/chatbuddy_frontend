import 'package:flutter_bloc/flutter_bloc.dart';

class BuddyCubit extends Cubit<Buddy> {
  final List<Buddy> allBuddies = [
    Buddy(
        buddyId: "inu",
        buddyName: "Shiba Inu",
        buddyImage: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png",
        buddyDesc: "Friendly, loyal and energetic"),
    Buddy(
        buddyId: "owl",
        buddyName: "Wise Owl",
        buddyImage: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/owl.png",
        buddyDesc: "Smart and mysterious"),
    Buddy(
        buddyId: "rabbit",
        buddyName: "Rabbit Grandma",
        buddyImage: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rab.png",
        buddyDesc: "Kind and caring"),
  ];

  BuddyCubit() : super(Buddy.empty()) {
    emit(allBuddies.first);
  }

  Buddy currentBuddy() {
    return state;
}

  nextBuddy() {
    int currentIndex = allBuddies.indexOf(state);
    if (currentIndex == -1) {
      return;
    }

    if (currentIndex >= 0 && currentIndex < allBuddies.length - 1) {
      emit(allBuddies[currentIndex + 1]);
    } else {
      emit(allBuddies[0]);
    }
  }

  previousBuddy() {
    int currentIndex = allBuddies.indexOf(state);
    if (currentIndex == -1) {
      return;
    }

    if (currentIndex > 0) {
      emit(allBuddies[currentIndex - 1]);
    } else {
      emit(allBuddies.last);
    }
  }
}

class Buddy {
  final String buddyId;
  final String buddyName;
  final String buddyImage;
  final String buddyDesc;

  Buddy(
      {required this.buddyId,
      required this.buddyName,
      required this.buddyImage,
      required this.buddyDesc});

  factory Buddy.empty() {
    return Buddy(
        buddyId: "buddy-0",
        buddyName: "",
        buddyImage: "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png",
        buddyDesc: "");
  }
}
