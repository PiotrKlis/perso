import 'package:Perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';
import 'package:Perso/data/repositories/trainer_search_cards/trainer_search_card_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalTrainerSearchCardRepository implements TrainerSearchCardRepository {
  @override
  Future<List<TrainersSearchCarouselCardData>> getAllCards() {
    return Future.value(_dummyCards);
  }

  final List<TrainersSearchCarouselCardData> _dummyCards = [
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic1.jpg",
        categoryName: "YOGA TRAINERS",
        title: "Top Yoga Trainers in your area",
        subtitle: "Explore the list of top Yoga trainers you don't want to miss"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic2.jpg",
        categoryName: "CROSSFIT TRAINERS",
        title: "Top CrossFit trainers in your country",
        subtitle:
        "Top CrossFit trainers you don't want to miss, click here to check"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic3.jpg",
        categoryName: "ENDURANCE TRAINERS",
        title: "Top English speaking endurance trainers",
        subtitle: "English speaker? Not a problem, find your trainer here"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic2.jpg",
        categoryName: "BODYBUILDING TRAINERS",
        title: "Most popular bodybuilding trainers",
        subtitle:
        "Looking for someone rated by lots people? Find most popular bodybuilding trainers"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic1.jpg",
        categoryName: "CARDIO TRAINERS",
        title: "Another quick-search card",
        subtitle:
        "Something that people will be looking for that they can click on to search without typing"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic3.jpg",
        categoryName: "CALISTHENICS TRAINERS",
        title: "Another quick-search card",
        subtitle:
        "Something that people will be looking for that they can click on to search without typing"),
    const TrainersSearchCarouselCardData(
        image: "assets/images/dummy_pic2.jpg",
        categoryName: "GYMNASTICS TRAINERS",
        title: "Another quick-search card",
        subtitle:
        "Something that people will be looking for that they can click on to search without typing"),
  ];
}
