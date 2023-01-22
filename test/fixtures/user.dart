import 'package:news/domain/entities/user.dart';
import 'package:news/infrastructure/dtos/user_model.dart';

const User user = User(
  id: 1,
  slug: 'test-user',
  name: 'Test User',
  description: 'Test User Description',
  avatar: 'test-user-avatar.png',
);

const UserModel userModel = UserModel(
  id: 1,
  slug: 'test-user',
  name: 'Test User',
  description: 'Test User Description',
  avatar: 'test-user-avatar.png',
);
