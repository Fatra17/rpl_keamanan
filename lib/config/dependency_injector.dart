import 'package:flutter/material.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

/// Menyediakan instance singleton dari ApiService dan repository.
class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._internal();

  factory DependencyInjector() => _instance;

  late final ApiService apiService;
  late final UserRepository userRepository;
  late final PostRepository postRepository;

  DependencyInjector._internal() {
    apiService = ApiService();
    userRepository = UserRepositoryImpl(apiService: apiService);
    postRepository = PostRepositoryImpl(apiService: apiService);
  }
}

/// InheritedWidget untuk menyediakan [DependencyInjector] ke widget tree.
class DependencyProvider extends InheritedWidget {
  final DependencyInjector injector;

  const DependencyProvider({
    super.key,
    required this.injector,
    required super.child,
  });

  static DependencyInjector of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
    assert(provider != null, 'DependencyProvider tidak ditemukan di context');
    return provider!.injector;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) => false;
}