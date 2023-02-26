import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainers_search_carousel_card_data.freezed.dart';

@freezed
class TrainersSearchCarouselCardData with _$TrainersSearchCarouselCardData {
  const factory TrainersSearchCarouselCardData(
      {required String image,
      required String categoryName,
      required String title,
      required String subtitle}) = _TrainersSearchCarouselCardData;
}

List<TrainersSearchCarouselCardData> dummyCards = [
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_image.jpg",
      categoryName: "YOGA TRAINERS",
      title: "Top Yoga Trainers in your area",
      subtitle: "Explore the list of top Yoga trainers you don't want to miss"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "CROSSFIT TRAINERS",
      title: "Top CrossFit trainers in your country",
      subtitle:
          "Top CrossFit trainers you don't want to miss, click here to check"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "ENDURANCE TRAINERS",
      title: "Top English speaking endurance trainers",
      subtitle: "English speaker? Not a problem, find your trainer here"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "BODYBUILDING TRAINERS",
      title: "Most popular bodybuilding trainers",
      subtitle:
          "Looking for someone rated by lots people? Find most popular bodybuilding trainers"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "CARDIO TRAINERS",
      title: "Another quick-search card",
      subtitle:
          "Something that people will be looking for that they can click on to search without typing"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "CALISTHENICS TRAINERS",
      title: "Another quick-search card",
      subtitle:
          "Something that people will be looking for that they can click on to search without typing"),
  const TrainersSearchCarouselCardData(
      image: "assets/images/dummy_category_2.png",
      categoryName: "GYMNASTICS TRAINERS",
      title: "Another quick-search card",
      subtitle:
          "Something that people will be looking for that they can click on to search without typing"),
];
