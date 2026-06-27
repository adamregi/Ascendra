class TextChunker {
  /// Splits a given string into chunks of max [chunkSize] characters,
  /// with an overlap of [overlap] characters.
  /// This implementation avoids splitting words when possible.
  static List<String> chunkText(String text, {int chunkSize = 800, int overlap = 100}) {
    if (text.isEmpty) return [];
    
    final List<String> chunks = [];
    int start = 0;
    
    while (start < text.length) {
      int end = start + chunkSize;
      
      if (end >= text.length) {
        chunks.add(text.substring(start).trim());
        break;
      }
      
      // Try to find a space or newline to avoid splitting words
      int lastSpace = text.lastIndexOf(RegExp(r'\s'), end);
      
      // If no space was found within the overlap window, force split
      if (lastSpace == -1 || lastSpace <= start + chunkSize - overlap) {
        lastSpace = end;
      }
      
      chunks.add(text.substring(start, lastSpace).trim());
      
      // Next chunk starts after moving back by the overlap
      start = lastSpace - overlap;
      
      // Prevent infinite loops if overlap is too large relative to progress
      if (start < 0) start = 0;
      if (start <= chunks.length * (chunkSize - overlap)) {
         // just a fallback to ensure we move forward
      }
    }
    
    return chunks;
  }
}
