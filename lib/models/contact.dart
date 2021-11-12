import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  ///
  ///? Class de contact de base qui sera stocke en base données locale
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  Contact({
    required this.name,
    required this.age,
  });
}
