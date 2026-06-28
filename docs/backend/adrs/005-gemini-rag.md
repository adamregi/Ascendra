# ADR 005: AI RAG Pipeline & Forensic Logging with Gemini

## Status
Accepted

## Context
Ascendra features an AI assistant designed to answer member questions about product specifications, compliance rules, and MLM guidelines. 

To provide accurate answers, the assistant uses Retrieval-Augmented Generation (RAG) to inject relevant document chunks into prompts. In leadership and compliance environments, it is critical to audit AI interactions. If the AI returns incorrect information, developers must be able to trace exactly what context was provided, what documents were retrieved, and which model version was used.

## Decision
We decided to integrate the **Gemini API** as our primary LLM provider, utilizing pgvector for similarity searches and implementing a forensic audit logging pipeline.

1. **pgvector Storage**: Documents are chunked, converted into 768-dimensional embeddings, and stored in the `document_chunks` table with HNSW indexing for cosine similarity searches.
2. **Context Resolution**: The assistant queries similarity matches and retrieves the company's current compliance snapshots, formatting them into a system prompt.
3. **Forensic Logging (`ai_context_logs`)**: Every AI response logs the full context in the database, storing:
   - The user's query and Gemini's safety parameters.
   - Chunks retrieved, cosine similarity scores, and document IDs.
   - A SHA-256 hash of the generated prompt template (`full_prompt_hash`) to track changes in prompts.
   - The full JSON payload containing model inputs and outputs.
4. **Usage Tracking (`ai_usage_logs`)**: Logs tokens consumed, request latency, and estimated cost.
5. **Role Normalization**: Standardizes role tags across model providers (mapping Gemini's `model` tag to `assistant`).

## Consequences

### Positive Impacts
- **Traceable Responses**: If the AI returns incorrect info, developers can inspect `ai_context_logs` to see the exact context provided to the model.
- **Cost & Latency Audits**: Logs token counts and model response times to monitor API usage and identify slow queries.
- **Data Security**: Storing search embeddings in pgvector ensures that semantic searches run securely within the database tenant boundary.

### Trade-offs & Cons
- **Storage Growth**: Logging system prompts, retrieved document chunks, and context JSON payloads on every query causes database storage to grow quickly.
- **pgvector Connection Overhead**: Running similarity searches on high-dimensional vectors adds query overhead, requiring pgvector memory tuning.
- **Model Upgrades**: Changing LLM versions or prompt structures can change how similarity matches are processed, requiring us to re-index document vectors.
