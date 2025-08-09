# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Running the Application
```bash
# Quick start (recommended)
chmod +x run.sh
./run.sh

# Manual start
cd backend && uv run uvicorn app:app --reload --port 8000
```

### Dependencies
```bash
# Install/sync dependencies
uv sync
```

### Environment Setup
Create `.env` file in root with:
```
ANTHROPIC_API_KEY=your_anthropic_api_key_here
```

### Access Points
- Web Interface: http://localhost:8000
- API Documentation: http://localhost:8000/docs

## Architecture Overview

This is a **Retrieval-Augmented Generation (RAG) system** for course materials with a FastAPI backend and vanilla HTML/JS frontend.

### Core RAG Pipeline
1. **Document Processing** (`document_processor.py`): Parses structured course files, extracts metadata, and creates sentence-based chunks with configurable overlap
2. **Vector Storage** (`vector_store.py`): ChromaDB with SentenceTransformer embeddings for semantic search
3. **AI Generation** (`ai_generator.py`): Anthropic Claude integration with tool-based search capabilities
4. **Orchestration** (`rag_system.py`): Main coordinator that processes queries through the full RAG pipeline

### Key Components

**FastAPI Backend** (`app.py`):
- `/api/query` - Main RAG query endpoint with session support
- `/api/courses` - Course analytics and statistics
- Serves frontend static files
- Auto-loads documents from `docs/` folder on startup

**Configuration** (`config.py`):
- Centralized settings via dataclass and environment variables
- Chunk size: 800 chars, overlap: 100 chars, max results: 5
- Uses `claude-sonnet-4-20250514` model

**Session Management** (`session_manager.py`):
- Maintains conversation history (max 2 exchanges)
- UUID-based session tracking

**Tool System** (`search_tools.py`):
- Course search tool for AI to query vector database
- Tool manager handles registration and execution

### Document Format
Course files expected format:
```
Course Title: [title]
Course Link: [url]
Course Instructor: [instructor]

Lesson 0: Introduction
Lesson Link: [optional_url]
[lesson content]

Lesson 1: Next Topic
[lesson content]
```

### Data Flow
1. Course documents → `DocumentProcessor` → structured chunks with lesson context
2. Chunks → `VectorStore` (ChromaDB) → semantic embeddings
3. User query → `RAGSystem` → AI with search tools → contextualized response
4. Session context preserved across conversation turns

The system adds contextual prefixes to chunks: `"Course [title] Lesson [X] content: [chunk]"` to improve retrieval relevance.
- Always use uv to run the server, never use pip
- use uv to run Python files