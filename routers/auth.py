from fastapi import APIRouter, Depends, HTTPException, Request
from pydantic import BaseModel
from typing import Annotated
from sqlalchemy.orm import Session
from starlette import status
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from database import SessionLocal2
from models import User
from passlib.context import CryptContext
from jose import jwt, JWTError
from datetime import timedelta, datetime, timezone
from fastapi.templating import Jinja2Templates

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"],
)


templates = Jinja2Templates(directory="templates")

SECRET_KEY = "t8YrjJ0BLDe5qryRSMPTaJuwXhAaoZecxwWXGPwIVWBnKhI5shB0ygNDVauPRzMl4RW9w7VJ"

ALGORITHM = "HS256"

def get_db():
    db = SessionLocal2()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]

bcrypt_context = CryptContext(schemes=["bcrypt"],deprecated="auto")
outh2_bearer = OAuth2PasswordBearer(tokenUrl="/auth/token")

class CreateUserRequest(BaseModel):
    username: str
    email: str
    first_name : str
    last_name: str
    password : str
    is_active: bool = True
    phone_number: str


class Token(BaseModel):
    access_token : str
    token_type : str

def create_access_token(username: str,user_id: int,expires_delta: timedelta):
    payload = {'sub': username,'id':user_id}
    expires = datetime.now(timezone.utc) + expires_delta
    payload.update({'exp':expires})
    return jwt.encode(payload,SECRET_KEY,algorithm=ALGORITHM)

def authenticate_user(username: str,password: str,db):
    user = db.query(User).filter(User.username == username).first()
    if not user:
        return False
    if not bcrypt_context.verify(password,user.hashed_password):
        return False
    return user

async def get_current_user(token: Annotated[str,Depends(outh2_bearer)]):
    try:
        payload = jwt.decode(token,SECRET_KEY,algorithms=ALGORITHM)
        username = payload.get('sub')
        user_id = payload.get('id')
        if username is None or user_id is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail='Parola veya şifre hatalı')
        return {'username':username,'id': user_id}
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail='TOKEN geçerli değil')


@router.get("/login-page")
def render_login_page(request:Request):
    return templates.TemplateResponse("login.html",{"request":request})

@router.get("/register-page")
def render_register(request:Request):
    return templates.TemplateResponse("register.html",{"request":request})

@router.post("/", status_code=201)
async def create_user(db: Session = Depends(get_db), user: CreateUserRequest = None):
    if user is None:
        raise HTTPException(status_code=400, detail="User data missing")

    hashed_password = bcrypt_context.hash(user.password)
    db_user = User(
        username=user.username,
        email=user.email,
        first_name=user.first_name,
        last_name=user.last_name,
        hashed_password=hashed_password,
        is_active=True,  # zorunluysa buradan atayabilirsin
        phone_number=user.phone_number,
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return {"msg": "User created successfully", "user_id": db_user.id}


@router.post("/token",response_model=Token)
async def login_access_token(form_data: Annotated[OAuth2PasswordRequestForm,Depends()],db:db_dependency):
    user = authenticate_user(form_data.username,form_data.password,db)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail='Yanlış kullanıcı adı veya parola')
    token = create_access_token(user.username,user.id,timedelta(minutes=60))
    return {"access_token":token,"token_type":"bearer"}
