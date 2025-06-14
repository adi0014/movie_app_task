import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/movie_viewmodel.dart';
import '../../data/models/movie.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(movieViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Movie App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.push('/bookmark'),
          ),
        ],
      ),
      body: FutureBuilder<List<List<Movie>>>(
        future: Future.wait([
          viewModel.fetchTrending(),
          viewModel.fetchNowPlaying(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  const Text(
                    'Network error. Please check your internet.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Data"));
          }

          final trending = snapshot.data![0];
          final nowPlaying = snapshot.data![1];

          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text("🔥 Trending",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              ...trending.map((movie) => MovieTile(movie: movie)),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text("🎬 Now Playing",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              ...nowPlaying.map((movie) => MovieTile(movie: movie)),
            ],
          );
        },
      ),
    );
  }
}

class MovieTile extends ConsumerWidget {
  final Movie movie;
  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(movieViewModelProvider);
    final isBookmarked = vm.isBookmarked(movie.id);

    return ListTile(
      leading: movie.posterPath != null
          ? Image.network(
              'https://image.tmdb.org/t/p/w92${movie.posterPath}',
              width: 50,
              fit: BoxFit.cover,
            )
          : const Icon(Icons.movie),
      title: Text(movie.title),
      subtitle: Text(
        movie.overview,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: isBookmarked ? Colors.red : Colors.grey,
        ),
        onPressed: () {
          if (isBookmarked) {
            vm.unbookmark(movie.id);
          } else {
            vm.bookmark(movie);
          }
        },
      ),
      onTap: () {
        context.push('/movie/${movie.id}');
      },
    );
  }
}
