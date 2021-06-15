import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent();
}

class LoginPressed extends LoginEvent {
  String? password;
  String? name;
  LoginPressed({this.password, this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [password, name];
}
