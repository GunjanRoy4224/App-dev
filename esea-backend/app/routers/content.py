from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.services.content_service import get_all_content, get_content_by_id
from app.schemas.content import ContentResponse

router = APIRouter(prefix="/admin/content")

@router.get("/", response_model=list[ContentResponse])
def list_content(type: str | None = None, db: Session = Depends(get_db)):
    return get_all_content(db, type)

@router.get("/{content_id}", response_model=ContentResponse)
def content_detail(content_id: str, db: Session = Depends(get_db)):
    content = get_content_by_id(db, content_id)
    if not content:
        raise HTTPException(404, "Not found")
    return content
