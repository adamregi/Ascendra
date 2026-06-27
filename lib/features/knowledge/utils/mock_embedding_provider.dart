import 'dart:math';

class MockEmbeddingProvider {
  /// Generates a deterministic 768-dimensional vector based on a simple
  /// bag-of-words hashing approach. This allows basic keyword searches to
  /// actually rank higher in the integration tests using cosine similarity.
  static List<double> generateMockEmbedding(String text) {
    final List<double> vector = List.filled(768, 0.0);
    
    // Normalize and tokenize text
    final words = text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9\s]'), '').split(RegExp(r'\s+'));
    
    for (final word in words) {
      if (word.isEmpty) continue;
      // Simple hash function for the word to map to an index 0-767
      int hash = 0;
      for (int i = 0; i < word.length; i++) {
        hash = (hash * 31 + word.codeUnitAt(i)) % 768;
      }
      vector[hash] += 1.0;
    }
    
    // Normalize the vector (L2 norm)
    double sumSq = 0;
    for (final v in vector) {
      sumSq += v * v;
    }
    
    if (sumSq == 0) {
      // If empty or no words, return uniform vector
      final fallback = 1.0 / sqrt(768);
      return List.filled(768, fallback);
    }
    
    final norm = sqrt(sumSq);
    for (int i = 0; i < 768; i++) {
      vector[i] /= norm;
    }
    
    return vector;
  }
}
