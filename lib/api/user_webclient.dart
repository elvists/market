class UserWebClient {
  Future<dynamic> authenticate({String password, String username}) async {
    if (username == "user" && password == "123") {
      return {"accessToken": "token"};
    }
    throw Exception("Usuário e/ou senha inválido(s)");
  }
}
