import 'package:perso/app/screens/trainer_clients_list/section_type.dart';
import 'package:perso/core/models/client_entity.dart';

class ClientSectionData {
  ClientSectionData({required this.sectionType, required this.clients});

  final SectionType sectionType;
  final List<ClientEntity> clients;
}
