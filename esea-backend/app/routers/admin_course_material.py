from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.course_material import (
    CourseMaterialCreate,
    CourseMaterialResponse,
)
from app.services.course_material_service import (
    create_material,
    update_material,
    delete_material,
    get_all_materials,
)
from app.dependencies import require_admin
from app.services.audit_service import log_action

router = APIRouter(prefix="/admin/course-materials", tags=["Admin Course Materials"])


@router.post("/", response_model=CourseMaterialResponse)
def create_course_material(
    payload: CourseMaterialCreate,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    material = create_material(db, payload)

    log_action(
        db=db,
        user=admin,
        action="Created course material",
        entity="course_material",
        entity_id=material.id,
    )

    return material


@router.get("/", response_model=list[CourseMaterialResponse])
def list_course_materials(
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    return get_all_materials(db)


@router.put("/{material_id}", response_model=CourseMaterialResponse)
def update_course_material(
    material_id: str,
    payload: CourseMaterialCreate,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    material = update_material(db, material_id, payload)
    if not material:
        raise HTTPException(status_code=404, detail="Material not found")

    log_action(
        db=db,
        user=admin,
        action="Updated course material",
        entity="course_material",
        entity_id=material.id,
    )

    return material


@router.delete("/{material_id}")
def delete_course_material(
    material_id: str,
    db: Session = Depends(get_db),
    admin=Depends(require_admin),
):
    success = delete_material(db, material_id)
    if not success:
        raise HTTPException(status_code=404, detail="Material not found")

    log_action(
        db=db,
        user=admin,
        action="Deleted course material",
        entity="course_material",
        entity_id=material_id,
    )

    return {"success": True}
