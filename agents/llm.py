# agents/llm.py
import os
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()
_client = OpenAI()                       # reads OPENAI_API_KEY from .env

DEFAULT_MODEL = "gpt-4.1-mini"

def call_llm(prompt: str, system: str = "", model: str = DEFAULT_MODEL,
             max_tokens: int = 1024) -> str:
    resp = _client.chat.completions.create(
        model=model,
        max_tokens=max_tokens,
        messages=[
            {"role": "system", "content": system},
            {"role": "user", "content": prompt},
        ],
    )
    return resp.choices[0].message.content