from sqlalchemy.orm import Session
from app.models.content import Content

def create_content(db: Session, data):
    content = Content(**data.dict())
    db.add(content)
    db.commit()          
    db.refresh(content) 
    return content


def get_all_content(db: Session, content_type=None):
    q = db.query(Content)
    if content_type:
        q = q.filter(Content.type == content_type)
    return q.order_by(Content.published_at.desc()).all()


def get_content_by_id(db: Session, content_id: str):
    return db.query(Content).filter(Content.id == content_id).first()


def update_content(db: Session, content_id: str, data):
    content = get_content_by_id(db, content_id)
    if not content:
        return None

    for key, value in data.dict(exclude_unset=True).items():
        setattr(content, key, value)

    db.commit()          # ✅ REQUIRED
    db.refresh(content)
    return content


def delete_content(db: Session, content_id: str):
    content = get_content_by_id(db, content_id)
    if not content:
        return False

    db.delete(content)
    db.commit()          # ✅ REQUIRED
    return True
