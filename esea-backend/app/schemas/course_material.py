from pydantic import BaseModel
from typing import List, Dict, Optional
from uuid import UUID
from datetime import datetime


class MaterialItem(BaseModel):
    title: str
    link: str


class PYQItem(BaseModel):
    year: str
    link: str


class CourseMaterialBase(BaseModel):
    course_code: str
    course_title: str
    instructor: Optional[str] = None

    materials: Dict[str, List[Dict]]  
    # keys: lectures, resources, pyqs


class CourseMaterialCreate(CourseMaterialBase):
    pass


class CourseMaterialResponse(CourseMaterialBase):
    id: UUID
    created_at: datetime

    class Config:
        from_attributes = True
