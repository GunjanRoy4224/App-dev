from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.user import User
from app.routers.auth import get_current_user

router = APIRouter(tags=["User"])

@router.get("/users/me")
def read_me(current_user: User = Depends(get_current_user)):
    return current_user
