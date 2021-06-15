
import 'package:equatable/equatable.dart';
abstract class RegisterEvent extends Equatable {
   RegisterEvent();
}

class registerPressed extends RegisterEvent {
  String? userMail;
String? password;
String? phone;
String? name;
  registerPressed(
  {
    this.userMail,
    this.password,
    this.phone,
    this.name
}
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    userMail,
    password,
    phone,
    name
  ];


}