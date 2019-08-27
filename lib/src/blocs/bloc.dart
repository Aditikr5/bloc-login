import 'package:loginpage/src/blocs/validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


  final _tokenController = BehaviorSubject<String>();
  final _authenticated = BehaviorSubject<bool>();


  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;


  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
 Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get isAuthenticated => _authenticated.stream.transform(authCheck);

  Stream<String> get storedToken => _tokenController.stream;


  Stream<bool> get submitValid =>
      Observable.combineLatest2(emailStream, passwordStream, (a, b) => true);

  submit() {

    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;





    if (validEmail != '' && validPassword != '') {
      _authenticated.sink.add(true);
       _tokenController.sink.add('valid email and password');
    }


    print('$validEmail and $validPassword. Auth: ${_authenticated.value}');
  }

  logout() {
    _emailController.sink.add('');

    _authenticated.sink.add(false);
    _tokenController.sink.add('');
  }

  dispose() {
    
    _emailController.close();
    _passwordController.close();
  }
}
