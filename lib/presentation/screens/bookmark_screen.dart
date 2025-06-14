import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'package:go_router/go_router.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.read(movieViewModelProvider).getBookmarks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Movies'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (_, index) {
          final movie = movies[index];
          return ListTile(
            leading: movie.posterPath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                    width: 50,
                  )
                : const Icon(Icons.movie),
            title: Text(movie.title),
            subtitle: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              context.push('/movie/${movie.id}');
            },
          );
        },
      ),
    );
  }
}
