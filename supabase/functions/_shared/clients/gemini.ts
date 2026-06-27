import { GoogleGenerativeAI } from "npm:@google/generative-ai";

const apiKey = Deno.env.get("GEMINI_API_KEY") || Deno.env.get("GOOGLE_API_KEY");

export const genAI = apiKey ? new GoogleGenerativeAI(apiKey) : null;

export function getGeminiModel(modelName = "gemini-1.5-flash") {
  if (!genAI) {
    throw new Error("GEMINI_API_KEY or GOOGLE_API_KEY is not configured in the environment.");
  }
  return genAI.getGenerativeModel({ model: modelName });
}
