
from .admin_course_material import router as admin_course_material
from .course_material import router as course_material
from .admin_content import router as admin_content

from .audit import router as audit
from .auth import router as auth    
from .public_content import router as public_content
from .admin_slot_time import router as admin_slot_time
from .admin_department_course import router as admin_department_course
from .student_courses import router as student_courses
from .timetable import router as timetable
from .admin_exam_timetable import router as admin_exam_timetable
from .exam_timetable import router as exam_timetable
from .sso import router as sso
from .users import router as users