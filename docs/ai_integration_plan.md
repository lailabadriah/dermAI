# AI Integration Plan for DermAI

## Model selection

The app will use a layered AI approach rather than a single monolithic model:

1. Computer vision model for selfie analysis
   - Recommended model: a dedicated skin-analysis vision model or multimodal image model exposed through a private backend endpoint.
   - This model receives a face image and returns structured JSON with fields like skin tone, acne area, hyperpigmentation, redness, texture, pore visibility, fine lines, and confidence scores.
   - Why this choice: it is optimized for image understanding and supports a clear API contract that is independent from the Flutter client.

2. Retrieval-Augmented Generation (RAG) layer
   - Recommended stack: FastAPI + vector database + structured skincare knowledge base.
   - Use scientific references, ingredient metadata, dermatologist safety guidance, and approved product catalog information as retrievable context.
   - Why this choice: it makes recommendations traceable and avoids hallucinated advice.

3. Conversational LLM
   - Recommended model: an instruction-following LLM that runs behind a secure backend and is prompted using user profile context plus retrieved knowledge.
   - It handles ingredient explanations, routine advice, and active ingredient safety questions.
   - Why this choice: the LLM is responsible for natural language assistance, but it should not operate in isolation; it must be grounded in retrieval evidence.

## Required backend API contracts

### Vision analysis endpoint

POST /api/v1/skin-analysis

Request:
- image_url or uploaded file
- user_id
- analysis_context (camera metadata, timestamp, skin profile summary)

Response:
- status
- analysis_id
- risk_level
- overall_score
- summary
- findings: [{"area":"forehead","issue":"acne","confidence":0.82}]
- recommendations
- generated_at

### Recommendation engine endpoint

POST /api/v1/recommendations

Request:
- skin_type
- skin_concerns
- product_history
- sensitivities
- ingredient_avoidance

Response:
- product_list
- rationale
- ingredient_notes

### Chat endpoint

POST /api/v1/chat

Request:
- user_message
- user_profile
- context_window
- retrieved_docs

Response:
- answer
- citations
- follow_up_questions

## Security and architecture

- No direct API key or model access from Flutter.
- Flutter only calls backend endpoints through HTTPS.
- Firebase auth is used to manage identity and secure user-specific data.
- Cloud Firestore and Firebase Storage store non-sensitive metadata and encrypted face images.
- Private backend manages AI model credentials, prompt configuration, and access control.

## Implementation sequence

1. Define backend service contracts.
2. Create FastAPI endpoints for analysis, recommendation, and chat.
3. Connect the app to backend via a repository/service layer in Flutter.
4. Replace mock responses with production model calls only after backend validation and safety checks.

## Safety notes

- The app should present results as estimates and educational insights, not a definitive medical diagnosis.
- Skin hydration or biological measurements should only be claimed when the model is validated for that specific task.
- Ingredient safety explanations should be based on peer-reviewed evidence, formulation context, and concentration.
