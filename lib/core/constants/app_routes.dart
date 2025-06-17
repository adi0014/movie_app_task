import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/bookmark_screen.dart';
import '../../presentation/screens/movie_detail_screen.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/bookmark',
      builder: (context, state) => const BookmarkScreen(),
    ),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) => MovieDetailScreen(
        movieId: state.pathParameters['id'] ?? '0',
      ),
    ),
  ],
);
