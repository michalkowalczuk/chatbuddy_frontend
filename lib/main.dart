import 'package:chat_buddy/cubits/buddy_cubit.dart';
import 'package:chat_buddy/screens/age_confirm.dart';
import 'package:chat_buddy/screens/avatar_select.dart';
import 'package:chat_buddy/screens/buddy_select.dart';
import 'package:chat_buddy/screens/chat.dart';
import 'package:chat_buddy/screens/nickname_select.dart';
import 'package:chat_buddy/screens/welcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubits/chat_cubit.dart';

void main() {
  runApp(const ChatBuddy());
}

class ChatBuddy extends StatelessWidget {
  const ChatBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<BuddyCubit>(create: (_) => BuddyCubit()),
        BlocProvider<ChatCubit>(
          create: (_) => ChatCubit(dio: Dio()),
        ),
      ],
      child: MaterialApp.router(
        title: 'ChatBuddy',
        routerDelegate: MyRouterDelegate(),
        routeInformationParser: MyRouteInformationParser(),
      ),
    );
  }
}

class MyRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String _currentPath = '/welcome';

  void _navigateTo(String path) {
    if (_currentPath != path) {
      _currentPath = path;
      notifyListeners();
    }
  }

  @override
  String get currentConfiguration => _currentPath;

  @override
  Widget build(BuildContext context) {
    Map<String, MaterialPage> allPages = {
      '/welcome': MaterialPage(
        key: const ValueKey('WelcomeScreen'),
        child: WelcomeScreen(
          onNavigate: () => _navigateTo('/age_confirm'),
        ),
      ),
      '/age_confirm': MaterialPage(
        key: const ValueKey('AgeConfirmScreen'),
        child: AgeConfirmScreen(
          onYesNavigate: () => _navigateTo('/avatar_select'),
          onNoNavigate: () => _navigateTo('/welcome'),
          onBack: () => _navigateTo('/welcome'),
        ),
      ),
      '/avatar_select': MaterialPage(
        key: const ValueKey('AvatarSelectScreen'),
        child: AvatarSelectScreen(
          onNavigate: () => _navigateTo('/nickname_select'),
          onBack: () => _navigateTo('/age_confirm'),
        ),
      ),
      '/nickname_select': MaterialPage(
        key: const ValueKey('NicknameSelectScreen'),
        child: NicknameSelectScreen(
          onNavigate: () => _navigateTo('/buddy_select'),
          onBack: () => _navigateTo('/avatar_select'),
        ),
      ),
      '/buddy_select': MaterialPage(
        key: const ValueKey('BuddySelectScreen'),
        child: BuddySelectScreen(
          onNavigate: () => _navigateTo('/chat'),
          onBack: () => _navigateTo('/nickname_select'),
        ),
      ),
      '/chat': MaterialPage(
        key: const ValueKey('ChatScreen'),
        child: ChatScreen(
          onBack: () => _navigateTo('/buddy_select'),
        ),
      ),
    };

    // just one page in stack at all times - do some clever shit here if needed
    List<MaterialPage> stack = [allPages[_currentPath]!];

    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _currentPath = configuration;
  }
}

class MyRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return '/welcome';
  }
}
