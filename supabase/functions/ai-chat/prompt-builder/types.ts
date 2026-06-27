export interface PromptTemplate {
  skill: string;
  version: string;
  systemPrompt: string;
  responseSchema: any;
  isFallback: boolean;
}

export interface PromptBuilderResult {
  systemInstruction: string;
  responseSchema: any;
  promptVersion: string;
  schemaVersion: string;
}

export interface BaseAIResponse {
  summary: string;
  recommended_actions: string[];
  confidence: number;
}
