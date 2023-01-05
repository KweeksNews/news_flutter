import 'package:kweeksnews_app/domain/entities/user.dart';
import 'package:kweeksnews_app/infrastructure/dtos/user_model.dart';

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
