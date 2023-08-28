import uvicorn
from fastapi import FastAPI

app = FastAPI()

@app.get('/')
def hello():
    return {"Hello": "I'm a message from the App"}


if __name__ == '__main__':
    uvicorn.run(app=app, host='0.0.0.0', port=8000)