import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/data/repositories/trainers/trainers_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersRepository implements TrainersRepository {
  @override
  Future<List<TrainerCard>> getTrainerCards() async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection('trainers');
    QuerySnapshot usersSnapshot = await usersRef.get();
    for (DocumentSnapshot document in usersSnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Wyświetlenie danych z dokumentu
      print('User ID: ${document.id}');
      print('Name: ${data['name']}');
      print('fullBio: ${data['fullBio']}');
      print('languages: ${data['languages']}');
      print('location: ${data['location']}');
      print('name: ${data['name']}');
      print('nickname: ${data['nickname']}');
      print('phone: ${data['phone']}');
      print('rating: ${data['rating']}');
      print('reviews: ${data['reviews']}');
      print('shortBio: ${data['shortBio']}');
      print('trainingTypes: ${data['trainingTypes']}');
    }
    return Future.value();
  }
}
