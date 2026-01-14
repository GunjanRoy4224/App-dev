from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.content import ContentCreate, ContentResponse
from app.services.content_service import create_content, update_content, delete_content, get_content_by_id
from app.dependencies import require_admin
from app.services.audit_service import log_action

router = APIRouter(prefix="/admin/content")

@router.post("/", response_model=ContentResponse)
def create(
    payload: ContentCreate,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    content = create_content(db, payload)

    log_action(
        db=db,
        user=admin,
        action="Created new content",
        entity="content",
        entity_id=content.id,
    )

    db.commit()  # ✅ audit log commit
    return content

@router.get("/{content_id}", response_model=ContentResponse)
def get_content(
    content_id: str,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    content = get_content_by_id(db, content_id)
    if not content:
        raise HTTPException(status_code=404, detail="Content not found")
    return content


@router.put("/{content_id}", response_model=ContentResponse)
def update_existing_content(
    content_id: str,
    payload: ContentCreate,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    content = update_content(db, content_id, payload)
    if not content:
        raise HTTPException(status_code=404, detail="Content not found")

    log_action(
        db=db,
        user=admin,
        action="Updated content",
        entity="content",
        entity_id=content.id,
    )

    db.commit()
    return content


@router.delete("/{content_id}")
def remove_content(
    content_id: str,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    success = delete_content(db, content_id)
    if not success:
        raise HTTPException(status_code=404, detail="Content not found")

    log_action(
        db=db,
        user=admin,
        action="Deleted content",
        entity="content",
        entity_id=content_id,
    )

    db.commit()
    return {"success": True}
