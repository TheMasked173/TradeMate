import os
import re
from flask import Flask, render_template, request, jsonify, redirect, url_for
import requests
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)


FINNHUB_API_KEY = os.getenv("FINNHUB_API_KEY", "d492ge9r01qshn3ka1d0d492ge9r01qshn3ka1dg")

def get_stock_quote(symbol: str):
    symbol = symbol.upper()
    url = f"https://finnhub.io/api/v1/quote?symbol={symbol}&token={FINNHUB_API_KEY}"
    try:
        resp = requests.get(url, timeout=6)
        resp.raise_for_status()
        data = resp.json()
    except Exception as e:
        return {"error": f"Network/API error: {e}"}

    # Finnhub returns keys: c (current), h (high), l (low), o (open), pc (previous close)
    if not data or data.get("c") is None:
        return {"error": f"No price data for {symbol}."}
    return {
        "symbol": symbol,
        "current": data.get("c"),
        "high": data.get("h"),
        "low": data.get("l"),
        "open": data.get("o"),
        "previous_close": data.get("pc"),
    }

def extract_ticker_from_text(text: str):
    # Find all word candidates
    candidates = re.findall(r'\b[A-Za-z]{1,5}(?:\.[A-Za-z])?\b', text)
    # Filter out common non-ticker words
    ignore = {"WHAT", "IS", "THE", "PRICE", "OF", "SHOW", "ME", "CURRENT", "A", "AN"}
    # Prefer all-uppercase words first
    for w in candidates:
        w_upper = w.upper()
        if w_upper not in ignore and (w.isupper() or len(w) <= 5):
            return w_upper
    return None

@app.route("/signup")
def signup():
    firebase_config = {
        "apiKey": os.getenv("FIREBASE_API_KEY"),
        "authDomain": os.getenv("FIREBASE_AUTH_DOMAIN"),
        "projectId": os.getenv("FIREBASE_PROJECT_ID"),
        "storageBucket": os.getenv("FIREBASE_STORAGE_BUCKET"),
        "messagingSenderId": os.getenv("FIREBASE_MESSAGING_SENDER_ID"),
        "appId": os.getenv("FIREBASE_APP_ID")
    }
    
    # 4. Send this dictionary to the HTML page
    return render_template("signup.html", firebase_config=firebase_config)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/chat", methods=["POST"])
def chat():
    data = request.get_json() or {}
    user = data.get("message", "").strip()
    if not user:
        return jsonify({"reply":"Send me a stock question like \"What's AAPL price?\""}), 200

    lower = user.lower()
    # Basic intent detection
    if any(word in lower for word in ["price", "quote", "what is", "how much", "current price", "share"]):
        ticker = extract_ticker_from_text(user)
        if not ticker:
            return jsonify({"reply":"Please include a ticker symbol like AAPL or TSLA."}), 200
        q = get_stock_quote(ticker)
        if q.get("error"):
            return jsonify({"reply": q["error"]}), 200
        reply = (f"{q['symbol']} — current: ${q['current']:.2f} | "
                 f"open ${q['open']:.2f} low ${q['low']:.2f} high ${q['high']:.2f} | "
                 f"prev close ${q['previous_close']:.2f}")
        return jsonify({"reply": reply}), 200

    # fallback: short general response
    return jsonify({"reply":"I'm TradeTeamMate — ask me for a stock price like \"What's AAPL price?\""}), 200

if __name__ == "__main__":
    # For local dev only
    app.run(debug=True, host="0.0.0.0", port=5000)
