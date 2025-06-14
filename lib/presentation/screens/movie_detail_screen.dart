import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/movie.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  final String movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  Movie? _movie;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  Future<void> _loadMovie() async {
    final viewModel = ref.read(movieViewModelProvider);
    try {
      final box = viewModel.getBookmarks();
      final local = box.firstWhere(
        (m) => m.id.toString() == widget.movieId,
        orElse: () => Movie(id: 0, title: '', overview: '', posterPath: null),
      );

      if (local.id != 0) {
        _movie = local;
      } else {
        final fetched = await viewModel.fetchMovieById(widget.movieId);
        _movie = fetched;
      }
    } catch (e) {
      _error = e.toString();
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 10),
              const Text('Something went wrong!',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    final movie = _movie!;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final url = 'myapp://movie/${movie.id}';
              final text =
                  '${movie.title}\n\n${movie.overview}\n\nOpen in app: $url';

              await Share.share(text);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.posterPath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover)
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            Text(movie.overview, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
