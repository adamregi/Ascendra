enum KnowledgeSourceType {
  document,
  product,
  faq,
  successStory;

  String toJson() {
    switch (this) {
      case KnowledgeSourceType.document:
        return 'document';
      case KnowledgeSourceType.product:
        return 'product';
      case KnowledgeSourceType.faq:
        return 'faq';
      case KnowledgeSourceType.successStory:
        return 'success_story';
    }
  }

  static KnowledgeSourceType fromString(String val) {
    switch (val) {
      case 'document':
        return KnowledgeSourceType.document;
      case 'product':
        return KnowledgeSourceType.product;
      case 'faq':
        return KnowledgeSourceType.faq;
      case 'success_story':
        return KnowledgeSourceType.successStory;
      default:
        return KnowledgeSourceType.document;
    }
  }
}
