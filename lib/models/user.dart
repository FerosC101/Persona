/// Represents an authenticated user in the application.
class User {
  /// Unique identifier for the user
  final String id;

  /// User's email address
  final String email;

  /// User's full name (optional)
  final String? name;

  User({
    required this.id,
    required this.email,
    this.name,
  });

  /// Create a copy of User with optional field updates
  User copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'User(id: $id, email: $email, name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;
}
