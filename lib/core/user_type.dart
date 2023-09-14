enum UserType {
  trainer, client
}

extension StringToUserType on String {
  UserType toUserType() {
    switch (this) {
      case 'trainer':
        return UserType.trainer;
      case 'client':
        return UserType.client;
      default:
        throw ArgumentError('Invalid user type string: $this');
    }
  }
}
