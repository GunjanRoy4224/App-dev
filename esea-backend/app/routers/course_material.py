from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.course_material import CourseMaterialResponse
from app.services.course_material_service import (
    get_all_materials,
    get_material_by_course,
)

router = APIRouter(prefix="/course-materials", tags=["Course Materials"])


@router.get("/", response_model=list[CourseMaterialResponse])
def list_all_course_materials(db: Session = Depends(get_db)):
    return get_all_materials(db)


@router.get("/{course_code}", response_model=CourseMaterialResponse)
def get_course_material(
    course_code: str,
    db: Session = Depends(get_db),
):
    material = get_material_by_course(db, course_code)
    if not material:
        raise HTTPException(status_code=404, detail="Course material not found")
    return material
