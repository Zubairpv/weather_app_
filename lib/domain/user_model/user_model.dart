import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final bool loggedIn;


  
  UserModel({
    required this.email,
    required this.loggedIn
  });

}
