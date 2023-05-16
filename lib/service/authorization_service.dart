// ignore_for_file: public_member_api_docs, sort_constructors_first

//TODO: Api and other logic

import 'dart:async';
import 'dart:convert';

import 'package:agconnect_auth/agconnect_auth.dart';

import '../other/validation/validor_builder.dart';

class AuthService{

  String login = 'test@tst.com';
  String password = '123A@qwert'; // минимум 8 символов
  /// Only registration
  String confirmPassword = '123A@qwert'; // минимум 8 символов
  
  String name = 'TEST1';
  bool male = false;
  int age = 18; 

  String werifyCode = '';



  Validation validateInit(){
   Validation validation =  makeSignUpValidation();
   return validation;
  }

  ValidationException? _validateFiled(String field){
    final Map formData = {
      'name': name,
      'email': login,
      'password': password,
      'passwordConfirmation': confirmPassword
    };
    final ValidationException? erroreOrSuccess = validateInit().validate(field: field, input: formData);
    return erroreOrSuccess;
  }



  Future<bool> logined(
    // {required SelectTypeAuth type, required LoginKeyData loginData}
    Function success, Function errore,
  ) async {
    //TODO: validate
    /// Validate
    // var regExp_Email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(login);
    // var regExp_Password = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
    // if(regExp_Email && regExp_Password){}else{
    //   return false;
    // }
    final valideEmail = _validateFiled(login);
    final validePassword = _validateFiled(password);
    if(valideEmail != null && validePassword != null){
      return false;
    }
    var loginData =  LoginEmail(email: login, passsword: password);
    if(loginData is LoginEmail){
      try{
        bool result = await  RepositoryHuaweiAuthService.loginEmailWW(loginData) ;
        if(result == true){
          success();
        }else{
          errore();
        }
      }catch(e){
        errore();
      }
    }else{
      //TODO:
      return false;
    }
    return false;
  }


  Future<bool> registration(Function success, Function errore,)async{
    var regExp_Email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(login);
    var regExp_Password = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
    if(regExp_Email && regExp_Password){}else{
      return false;
    }
    final registData = RegistrationEmail(name: name, male: male, age: age, email: login, passsword: password);
    if(registData is RegistrationEmail){
      //TODO: validate
      /// Validate
      if(true){
        bool result = await  RepositoryHuaweiAuthService.registrationEmailWW(registData);
        if(result){
          success();
        }else{
          errore();
        }
      }else{
        //TODO:
      }
    }else{
      //TODO:
    }
    return false;
  }

  Future<bool> confirmEmail({required Function success, required Function errore})async{
    // var regExp_Email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(login);
    // var regExp_Password = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
    // if(regExp_Email && regExp_Password){}else{
    //   return false;
    // }
    // final registData = RegistrationEmail(name: name, male: male, age: age, email: login, passsword: password);
    if(werifyCode is String){
      //TODO: validate
      /// Validate
      if(true){
       bool result = await  RepositoryHuaweiAuthService.confirmEmail(werifyCode);
       if(result){
        success();
       }else{
        errore();
       }
      }else{
        //TODO:
      }
    }else{
      //TODO:
    }
    return false;
  }



}


//TODO: Mock data
class RepositoryHuaweiAuthService{
  static Future<bool> loginEmailWW(LoginEmail loginData)async{
    bool result = await HuaweiAuthService.loginEmail(loginData);
    return result;
  }
  static Future<bool> registrationEmailWW(RegistrationEmail dataRegistration)async{
    bool? result = await HuaweiAuthService.requirestConfirmEmail(dataRegistration);
    return result;
  }
  static Future<bool> confirmEmail(String code)async{
    bool? result = await HuaweiAuthService.registrationEmail_verify(code);
    return result ?? false;
  }
}

class HuaweiAuthService {
  static Future<bool> loginEmail(LoginEmail loginData)async{
    AGCAuthCredential credential = EmailAuthProvider.credentialWithPassword('k4fos568rhvx7ua@gmail.com', '123A@qwert');
      StreamController<AGCUser?> _streamContr = StreamController();
      StreamController<String?> _streamContrErrore = StreamController();
      AGCAuth.instance.signIn(credential)
        .then((signInResult)async{
              //get user info
              AGCUser? user = signInResult.user;
              AGCUser? currentUser = await AGCAuth.instance.currentUser;
              _streamContr.add(currentUser);
              _streamContrErrore.add(null);
              print("Success AUTH "+user.toString() );
        })
        .catchError((error){
          //fail
          _streamContr.add(null);
          _streamContrErrore.add(error.toString());
          print("Errrore LOGIN "+error.toString() );
        });
      AGCUser? data = await _streamContr.stream.last;
      String? erore = await _streamContrErrore.stream.last;
    
    if(erore != null){
      return false;
    }
    if(data != null){
      return true;
    }else{
      return false;
    }
  }

  /// ## Register after confirm email
  /// ### Parametr
  /// * this veryfiCode
  /// * this email
  /// * this password
  /// ### Result
  /// * this AGCUser? data
  static registrationEmail_verify(String veryfiCode)async{
    String email = "viskochka77@gmail.com";

    // VerifyCodeSettings settings = VerifyCodeSettings(VerifyCodeAction.registerLogin, sendInterval: 30);
    // VerifyCodeResult? resultVerifyCode = await EmailAuthProvider.requestVerifyCode(email,settings);
    
    EmailUser user = EmailUser(email, veryfiCode, password:'123A@qwert');
    StreamController<AGCUser?> _streamContr = StreamController();
    // StreamController<String?> _streamContrErrore = StreamController();
    SignInResult signInUser = await AGCAuth.instance.createEmailUser(user);
    AGCUser? currentUser =await AGCAuth.instance.currentUser;
    //     .then((signInResult) async{
    //       // success
    //       AGCUser? currentUser =await AGCAuth.instance.currentUser;
    //       _streamContr.add(currentUser);
    //       _streamContrErrore.add(null);
    //     })
    //     .catchError((error) {
    //       //fail
    //         _streamContr.add(null);
    //         _streamContrErrore.add(error.toString());
    //       print("Errrore REGISTR "+error.toString());
    //     });
    // AGCUser? data = await _streamContr.stream.last;
    // String? erore = await _streamContrErrore.stream.last;
    
    // if(erore != null){
    //   return false;
    // }
    if(signInUser.user!=null){
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> requirestConfirmEmail(RegistrationEmail dataRegistration)async{
     String email = "viskochka77@gmail.com";

    VerifyCodeSettings settings = VerifyCodeSettings(VerifyCodeAction.registerLogin, sendInterval: 30);
    VerifyCodeResult? resultVerifyCode = await EmailAuthProvider.requestVerifyCode(email,settings);
    return resultVerifyCode != null;
  }
}

enum SelectTypeAuth {
  email,
  phone,
}

// abstract class _UserKey {
//   final String login;
//   final String password;
//   _UserKey({
//     required this.login,
//     required this.password,
//   });
// }

// abstract class _RegistrationUser {
//   final String firstname;
//   final String lastname;
//   final String middlename;
//   final int age;
//   final int nickName;
//   _RegistrationUser({
//     required this.firstname,
//     required this.lastname,
//     required this.middlename,
//     required this.age,
//     required this.nickName,
//   });
// }

// class _RegistrationUserEmail implements _RegistrationUser, _UserKey {
//   final String firstname;
//   final String lastname;
//   final String middlename;
//   final int age;
//   final int nickName;
  
//   final String login;
//   final String password;
//   _RegistrationUserEmail({
//     required this.firstname,
//     required this.lastname,
//     required this.middlename,
//     required this.age,
//     required this.nickName,
//     required this.login,
//     required this.password,
//   });

//   _RegistrationUserEmail copyWith({
//     String? firstname,
//     String? lastname,
//     String? middlename,
//     int? age,
//     int? nickName,
//     String? login,
//     String? password,
//   }) {
//     return _RegistrationUserEmail(
//       firstname: firstname ?? this.firstname,
//       lastname: lastname ?? this.lastname,
//       middlename: middlename ?? this.middlename,
//       age: age ?? this.age,
//       nickName: nickName ?? this.nickName,
//       login: login ?? this.login,
//       password: password ?? this.password,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'firstname': firstname,
//       'lastname': lastname,
//       'middlename': middlename,
//       'age': age,
//       'nickName': nickName,
//       'login': login,
//       'password': password,
//     };
//   }

//   factory _RegistrationUserEmail.fromMap(Map<String, dynamic> map) {
//     return _RegistrationUserEmail(
//       firstname: map['firstname'] as String,
//       lastname: map['lastname'] as String,
//       middlename: map['middlename'] as String,
//       age: map['age'] as int,
//       nickName: map['nickName'] as int,
//       login: map['login'] as String,
//       password: map['password'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory _RegistrationUserEmail.fromJson(String source) => _RegistrationUserEmail.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return '_RegistrationUserEmail(firstname: $firstname, lastname: $lastname, middlename: $middlename, age: $age, nickName: $nickName, login: $login, password: $password)';
//   }

//   @override
//   bool operator ==(covariant _RegistrationUserEmail other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.firstname == firstname &&
//       other.lastname == lastname &&
//       other.middlename == middlename &&
//       other.age == age &&
//       other.nickName == nickName &&
//       other.login == login &&
//       other.password == password;
//   }

//   @override
//   int get hashCode {
//     return firstname.hashCode ^
//       lastname.hashCode ^
//       middlename.hashCode ^
//       age.hashCode ^
//       nickName.hashCode ^
//       login.hashCode ^
//       password.hashCode;
//   }
// }

// class LoginUser implements _UserKey {
//   final String login;
//   final String password;
//   LoginUser({
//     required this.login,
//     required this.password,
//   });
  

//   LoginUser copyWith({
//     String? login,
//     String? password,
//   }) {
//     return LoginUser(
//       login: login ?? this.login,
//       password: password ?? this.password,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'login': login,
//       'password': password,
//     };
//   }

//   factory LoginUser.fromMap(Map<String, dynamic> map) {
//     return LoginUser(
//       login: map['login'] as String,
//       password: map['password'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LoginUser.fromJson(String source) => LoginUser.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'LoginUser(login: $login, password: $password)';

//   @override
//   bool operator ==(covariant LoginUser other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.login == login &&
//       other.password == password;
//   }

//   @override
//   int get hashCode => login.hashCode ^ password.hashCode;
// }


abstract class LoginKeyData{}

class LoginEmail extends LoginKeyData {
  final String email;
  final String passsword;
  final String? confirm;
  LoginEmail({
    required this.email,
    required this.passsword,
    this.confirm,
  });
  
}


abstract class RegistrationData {}
abstract class RegistrationKeyData {
  final String name;
  final bool male;
  final int age; 
  RegistrationKeyData({
    required this.name,
    required this.male,
    required this.age,
  });
}


class RegistrationEmail extends RegistrationData implements LoginEmail, RegistrationKeyData {
  final String name;
  final bool male;
  final int age; 

  final String email;
  final String passsword;
  final String? confirm;
  RegistrationEmail({
    required this.name,
    required this.male,
    required this.age,
    required this.email,
    required this.passsword,
    this.confirm,
  });

  RegistrationEmail copyWith({
    String? name,
    bool? male,
    int? age,
    String? email,
    String? passsword,
    String? confirm,
  }) {
    return RegistrationEmail(
      name: name ?? this.name,
      male: male ?? this.male,
      age: age ?? this.age,
      email: email ?? this.email,
      passsword: passsword ?? this.passsword,
      confirm: confirm ?? this.confirm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'male': male,
      'age': age,
      'email': email,
      'passsword': passsword,
      'confirm': confirm,
    };
  }

  factory RegistrationEmail.fromMap(Map<String, dynamic> map) {
    return RegistrationEmail(
      name: map['name'] as String,
      male: map['male'] as bool,
      age: map['age'] as int,
      email: map['email'] as String,
      passsword: map['passsword'] as String,
      confirm: map['confirm'] != null ? map['confirm'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationEmail.fromJson(String source) => RegistrationEmail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegistrationEmail(name: $name, male: $male, age: $age, email: $email, passsword: $passsword, confirm: $confirm)';
  }

  @override
  bool operator ==(covariant RegistrationEmail other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.male == male &&
      other.age == age &&
      other.email == email &&
      other.passsword == passsword &&
      other.confirm == confirm;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      male.hashCode ^
      age.hashCode ^
      email.hashCode ^
      passsword.hashCode ^
      confirm.hashCode;
  }
}

// -----

// разные авторизационные данные, наследование от авотризационных данных
// одни данные пользователя
// Рвзное подтверждение

// -----










































///////////////////////// -------------------------------------------
///
///
///
///
///
///





















/// ПРИМЕР 


// abstract class IAuthFacade {
//   Future<void> signIn({required String email, required String password,});
//   Future<void> register({required String username, required String email, required String password});
//   Future<User?> getUser();
//   Future<void> logOut();
// }


// @Injectable(as: IAuthFacade)
// class AuthFacade implements IAuthFacade {
//   @override
//   Future<User?> getUser() {
//     // TODO: implement getUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> register({required String username, required String email, required String password}) {
//     // TODO: implement register
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signIn({required String email, required String password}) {
//     // TODO: implement signIn
//     throw UnimplementedError();
//   }
// }


// @JsonSerializable()
// class User extends Equatable {
//   String id;
//   final String email;
//   final String username;

//   User({required this.id, required this.email, required this.username});

//   @override
//   List<Object?> get props => [this.id, this.email, this.username];

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }


// @module
// abstract class AppModule {
//   // ....
//   @injectable
//   FirebaseFirestore get store => FirebaseFirestore.instance;

//   @injectable
//   FirebaseAuth get auth => FirebaseAuth.instance;
// }




// @Injectable(as: IAuthFacade)
// class AuthFacade implements IAuthFacade {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firebaseFirestore;

//   AuthFacade(this._firebaseAuth, this._firebaseFirestore);

//   // ...Implementation..
// }


// @Injectable(as: IAuthFacade)
// class AuthFacade implements IAuthFacade {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firebaseFirestore;

//   AuthFacade(this._firebaseAuth, this._firebaseFirestore);

//   @override
//   Future<u.User?> getUser() async {
//     try {
//       final uid = _firebaseAuth.currentUser!.uid;
//       final currentUser = await _firebaseFirestore.doc("users/$uid").snapshots().first;
//       return currentUser.toUser();
//     } on FirebaseAuthException catch(e) {
//       print("We failed ${e.message}");
//     }
//   }

//   @override
//   Future<void> register({required String username, required String email, required String password}) {
//       return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) async {
//             return _firebaseFirestore.doc("users/${value.user!.uid}")
//         .set({"email": email, "username": username});
//       });
//   }

//   @override
//   Future<void> signIn({required String email, required String password}) {
//     return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//   }

//   @override
//   Future<void> logOut() => _firebaseAuth.signOut();
// }

// // Simple extension to convert firestore document snapshots to our class
// extension DocumentSnapX on DocumentSnapshot<Map<String, dynamic>> {
//   u.User toUser() {
//     return u.User.fromJson(this.data()!)
//         ..id = this.id;
//   }
// }



// @injectable
// class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
//   final IAuthFacade authFacade;

//   LoginFormBloc(this.authFacade) : super(LoginFormInitial()) {
//       // Update login state according to events
//       on<LoginButtonPressed>((event, emit) async {
//       final currentState = state as LoginFormState;
//         final data = authFacade.signIn(currentState.email, currentState.password);
//       })
//     }
//   }

