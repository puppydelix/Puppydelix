# ScrapeGraphAI install

Minimal setup for [ScrapeGraphAI](https://github.com/ScrapeGraphAI/Scrapegraph-ai), a library that uses LLMs and graph logic to build web scraping pipelines.

## Install

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
playwright install
```

## Configure

```bash
cp .env.example .env
# then edit .env and set OPENAI_API_KEY (or swap the LLM config in smart_scraper_example.py
# for another provider ScrapeGraphAI supports, e.g. Azure, Ollama, Gemini)
```

## Run the example

```bash
python smart_scraper_example.py
```

This runs `SmartScraperGraph`, which fetches a page, renders it with Playwright, and
asks the configured LLM to extract structured data from it based on a natural-language
prompt.
