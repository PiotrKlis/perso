import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/core/models/client_entity.dart';

mixin ClientsService {
  Future<void> uploadFullClientData(ClientEntity clientEntity);
  Future<void> updateData(EditableClientData editableClientData);
}
