# Aether Agent 🤖📱

Aether Agent is an intelligent mobile-to-agent pipeline that enables users to execute complex, multi-step digital workflows using natural language instructions. The project consists of a high-performance **Flutter client** that communicates asynchronously via webhooks with an autonomous **n8n orchestration backend** powered by the Groq LLM API.

---

## 🚀 Core Features

- **Asynchronous Webhook Pipeline:** Real-time data streaming from a Flutter mobile client to an n8n webhook listener architecture.
- **Autonomous Agentic Workflows:** Multi-step branching logic execution where the LLM serves as a reasoning brain to determine the utilization of internal tools (e.g., executing web scrapers, dispatching external tasks, generating emails).
- **Offline Resilience & Task Queuing:** Local client-side queue that buffers user instructions if network connectivity is severed, automatically syncing and executing tasks upon reconnection.
- **Real-Time Streaming Responses:** Smooth UI updates on the Flutter application as the backend agent streams its operational steps and final results back to the device.

---

## 🛠️ Tech Stack & Architecture

- **Frontend:** Flutter, Dart (State Management, Async Networking)
- **Backend Orchestration:** n8n (Advanced AI Orchestration Workflow Canvas)
- **Inference Engine:** Groq Cloud API (High-velocity LLM inference for real-time orchestration)
- **Integrations:** Node.js, REST APIs, Webhooks, SMTP/Email APIs

---

## 📐 System Architecture & Data Flow

1. **User Input:** User enters a natural language request (e.g., *"Look up the latest tech news on Dentlo and email a bulleted summary to my inbox"*).
2. **Client Dispatch:** Flutter captures the text, packages it into a structured JSON payload, and shoots it via an HTTP POST request to the local/hosted n8n webhook.
3. **Agent Evaluation:** The n8n Webhook node receives the payload and passes it to the AI Agent node. Groq LLM evaluates the intent and determines the required tool chain.
4. **Tool Execution:** - *Branch A:* Web lookup tool scrapes required target resources.
   - *Branch B:* Text processing/parsing nodes synthesize raw data.
   - *Branch C:* Email/Task dispatcher sends structured payloads to target destinations.
5. **Real-time Sync:** The workflow wraps the final execution state and streams the structural log/response back to the Flutter client UI.

---

## 🔧 Getting Started

### Backend (n8n Setup)
1. Install n8n locally via npm:
   ```bash
   npm i -g n8n
   n8n start
