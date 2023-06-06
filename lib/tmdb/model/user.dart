
class User {
  User(this.id, this.name, this.email, this.photoUrl);

  final String id;
  final String name;
  final String email;
  final String photoUrl;

  User.empty() : this("", "", "", "");
}
