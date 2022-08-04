class LoginRequest{
  String username;
  String password;
  LoginRequest(this.username, this.password);

}

class ForgetPasswordRequest{
  String username;
  ForgetPasswordRequest(this.username);

}

class RegisterRequest{
  String username;
  String password;
  String phone;
  String countryCode;
   String profilePicture;

  RegisterRequest(this.username, this.password, this.phone, this.countryCode,
      this.profilePicture);
}