from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import Base, engine
from app.routers import admin_content
from app.routers import audit
from app.routers import auth
from app.routers import public_content
from app.routers import admin_slot_time
from app.routers import admin_department_course
from app.routers import student_courses
from app.routers import timetable
from app.routers import admin_exam_timetable, exam_timetable
from app.routers import sso
from app.routers import users
from app.routers import admin_course_material, course_material
from app.routers.content import router as content_router


Base.metadata.create_all(bind=engine)

app = FastAPI(title="ESEA API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
        "http://localhost:3000",
        "http://127.0.1:3000",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(admin_content, prefix="/api")
app.include_router(audit, prefix="/api")
app.include_router(auth, prefix="/api")
app.include_router(users, prefix="/api")
app.include_router(public_content, prefix="/api")
app.include_router(admin_slot_time, prefix="/api")
app.include_router(admin_department_course, prefix="/api")
app.include_router(student_courses, prefix="/api")
app.include_router(timetable, prefix="/api")
app.include_router(admin_exam_timetable, prefix="/api")
app.include_router(exam_timetable, prefix="/api")
app.include_router(sso, prefix="/api")
app.include_router(admin_course_material, prefix="/api")
app.include_router(course_material, prefix="/api")
app.include_router(content_router, prefix="/api", tags=["Content"])

@app.on_event("startup")
def print_routes():
    print("\n=== REGISTERED ROUTES ===")
    for route in app.routes:
        print(route.path)