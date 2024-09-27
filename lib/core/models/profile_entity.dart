abstract class ProfileEntity {
  ProfileEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.nickname,
    required this.imagePath,
  });

  final String id;
  final String name;
  final String surname;
  final String nickname;
  final String imagePath;
}
