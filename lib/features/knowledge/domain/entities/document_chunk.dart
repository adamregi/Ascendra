class DocumentChunk {
  final String id;
  final String documentId;
  final String chunkText;
  // We do not pull the embedding back down to Dart for normal usage, but we can if needed.
  // For now, let's keep it null or absent since the app rarely needs to see raw 768 floats.

  const DocumentChunk({
    required this.id,
    required this.documentId,
    required this.chunkText,
  });
}
