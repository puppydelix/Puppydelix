"""Minimal ScrapeGraphAI example: extract structured data from a page with an LLM.

Usage:
    pip install -r requirements.txt
    playwright install
    cp .env.example .env  # then set OPENAI_API_KEY
    python smart_scraper_example.py
"""

import json
import os

from dotenv import load_dotenv
from scrapegraphai.graphs import SmartScraperGraph

load_dotenv()

graph_config = {
    "llm": {
        "api_key": os.environ["OPENAI_API_KEY"],
        "model": "openai/gpt-4o-mini",
    },
    "verbose": True,
    "headless": True,
}

smart_scraper_graph = SmartScraperGraph(
    prompt="List me all the titles and their links",
    source="https://example.com",
    config=graph_config,
)

if __name__ == "__main__":
    result = smart_scraper_graph.run()
    print(json.dumps(result, indent=2))
