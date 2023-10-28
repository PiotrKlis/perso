import 'package:perso/core/models/client_entity.dart';

mixin ClientsSource {
  Future<ClientEntity> getClientData(String id);
}
