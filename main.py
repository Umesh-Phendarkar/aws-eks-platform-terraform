from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():

    return {
        "message": "GenAI Platform Running"
    }

@app.get("/chat")
def chat():

    return {
        "response": "Hello from GenAI API"
    }
