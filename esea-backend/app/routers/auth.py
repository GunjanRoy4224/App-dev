from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from sqlalchemy.orm import Session
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta

from app.database import get_db
from app.models.user import User
from app.config import settings
from app.schemas.auth import AdminLoginRequest

router = APIRouter(prefix="/auth", tags=["Auth"])

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/api/auth/admin/login-form"
)

# -------------------------------------------------
# JWT UTIL
# -------------------------------------------------
def create_access_token(data: dict, expires_minutes: int = 60):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=expires_minutes)
    to_encode.update({"exp": expire})
    return jwt.encode(
        to_encode,
        settings.SECRET_KEY,
        algorithm=settings.ALGORITHM,
    )

# -------------------------------------------------
# ADMIN LOGIN (JSON)
# -------------------------------------------------
@router.post("/admin/login")
def admin_login(
    payload: AdminLoginRequest,
    db: Session = Depends(get_db)
):
    user = db.query(User).filter(User.email == payload.email).first()

    if not user:
        raise HTTPException(status_code=401, detail="Admin not found")

    if user.role.strip().lower() != "admin":
        raise HTTPException(status_code=403, detail="User is not admin")

    if not pwd_context.verify(payload.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid password")

    token = create_access_token(
        {"sub": str(user.id), "role": "admin"},
        expires_minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    )

    return {
        "access_token": token,
        "role": "admin",
    }

# -------------------------------------------------
# ADMIN LOGIN (SWAGGER FORM)
# -------------------------------------------------
@router.post("/admin/login-form")
def admin_login_form(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    user = db.query(User).filter(User.email == form_data.username).first()

    if not user:
        raise HTTPException(status_code=401, detail="Admin not found")

    if user.role.strip().lower() != "admin":
        raise HTTPException(status_code=403, detail="User is not admin")

    if not pwd_context.verify(form_data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid password")

    token = create_access_token(
        {"sub": str(user.id), "role": "admin"},
        expires_minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    )

    return {
        "access_token": token,
        "token_type": "bearer",
    }

# -------------------------------------------------
# CURRENT USER DEPENDENCY
# -------------------------------------------------
def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db),
):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Invalid authentication credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        payload = jwt.decode(
            token,
            settings.SECRET_KEY,
            algorithms=[settings.ALGORITHM],
        )
        user_id = payload.get("sub")
        if user_id is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    user = db.query(User).filter(User.id == int(user_id)).first()
    if not user:
        raise credentials_exception

    return user
