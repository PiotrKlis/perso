class TrainerData {
  TrainerData(
      {required this.image,
      required this.languages,
      required this.name,
      required this.surname,
      required this.nickname,
      required this.location,
      required this.phoneNumber,
      required this.shortBio,
      required this.fullBio,
      required this.categories});

  final String image;
  final List<String> languages;
  final String name;
  final String surname;
  final String nickname;
  final String location;
  final String phoneNumber;
  final String shortBio;
  final String fullBio;
  final List<String> categories;
}
