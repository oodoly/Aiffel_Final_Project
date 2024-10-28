from fastapi import FastAPI

app = FastAPI()

@app.get("/api/data")
async def get_data():
    return {"message": "Hello from FastAPI!"}

@app.get("/api/greetings")
async def get_greetings():
    return {"message": "This is Echo from interstellar!"}
