class UserModel {
  final String id;
  final String name;
  final String username;
  final String password;
  final String securityQuestion;
  final String securityAnswer;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.securityQuestion,
    required this.securityAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'security_question': securityQuestion,
      'security_answer': securityAnswer,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      securityQuestion: map['security_question'],
      securityAnswer: map['security_answer'],
    );
  }
}
