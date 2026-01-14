from sqlalchemy.orm import Session
from app.models.course_material import CourseMaterial


def create_material(db: Session, data):
    material = CourseMaterial(**data.dict())
    db.add(material)
    db.commit()
    db.refresh(material)
    return material


def get_all_materials(db: Session):
    return db.query(CourseMaterial).order_by(
        CourseMaterial.course_code.asc()
    ).all()


def get_material_by_id(db: Session, material_id):
    return db.query(CourseMaterial).filter(
        CourseMaterial.id == material_id
    ).first()


def get_material_by_course(db: Session, course_code: str):
    return db.query(CourseMaterial).filter(
        CourseMaterial.course_code == course_code
    ).first()


def update_material(db: Session, material_id, data):
    material = get_material_by_id(db, material_id)
    if not material:
        return None

    for k, v in data.dict(exclude_unset=True).items():
        setattr(material, k, v)

    db.commit()
    db.refresh(material)
    return material


def delete_material(db: Session, material_id):
    material = get_material_by_id(db, material_id)
    if not material:
        return False

    db.delete(material)
    db.commit()
    return True
