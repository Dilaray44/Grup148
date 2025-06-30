from fastapi import FastAPI, Request
from models import Base1,Base2
from sqlalchemy.orm import Session
from fastapi.staticfiles import StaticFiles
from starlette.responses import RedirectResponse #Nokta koyarak server a biraz daha ahanda burada demek istiyoruz.
from starlette import status
from database import engine1,engine2, SessionLocal1,SessionLocal2
from typing import Annotated
from routers.auth import router as auth_router
#from routers.todo import router as todo_router
import os #Server ın statik dosyaları görmesi için bu işlemi yaparım



app = FastAPI()

script_dir = os.path.dirname(__file__)
st_abs_path = os.path.join(script_dir,"static")


app.mount("/static",StaticFiles(directory="static"),name="static") #Statik dosyaların bağlanması için bu işlemi yaparız.



@app.get("/")
def read_root(request:Request):
    return RedirectResponse(url="/auth/login-page",status_code=status.HTTP_302_FOUND)


Base1.metadata.create_all(bind=engine1)
Base2.metadata.create_all(bind=engine2)

app.include_router(auth_router)
