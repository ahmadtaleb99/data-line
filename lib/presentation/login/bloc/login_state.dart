part of 'login_bloc.dart';



class LoginState extends Equatable {
 final bool allValid ;
 final bool isPasswordValid ;
 final bool isUsernameValid;
 final FlowState flowState;

 final bool hasLoggedIn;


  @override
  List<Object> get props => [flowState,allValid,isPasswordValid,isUsernameValid,hasLoggedIn];

 const LoginState({
    required this.allValid,
    required this.flowState,
    required this.isPasswordValid,
    required this.isUsernameValid,

    required this.hasLoggedIn,
  });

 LoginState copyWith({
    bool? allValid,
    bool? isPasswordValid,
    bool? isUsernameValid,
   FlowState? flowState,

    bool? hasLoggedIn,
  }) {
    return LoginState(
      allValid: allValid ?? this.allValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      flowState: flowState ?? this.flowState,


      hasLoggedIn: hasLoggedIn ?? this.hasLoggedIn,
    );
  }
}
