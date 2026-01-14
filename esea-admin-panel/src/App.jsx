import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext";

import Login from "./auth/Login";
import RequireAdmin from "./auth/RequireAdmin";
import AdminLayout from "./layouts/AdminLayout";

import Dashboard from "./pages/Dashboard";
import ContentList from "./pages/ContentList";
import CreateContent from "./pages/CreateContent";
import EditContent from "./pages/EditContent";
import UploadSlotTime from "./pages/UploadSlotTime";
import UploadDepartmentCourses from "./pages/UploadDepartmentCourses";
import UploadExamTimetable from "./pages/UploadExamTimetable";
import AuditLogs from "./pages/AuditLogs";
import ExamTimetablePreview from "./pages/ExamTimetablePreview";
import CourseMaterialList from "./pages/CourseMaterialList";
import CreateCourseMaterial from "./pages/CreateCourseMaterial";
import EditCourseMaterial from "./pages/EditCourseMaterial";

function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          {/* Public */}
          <Route path="/login" element={<Login />} />
          {/*Redirect root*/}
          <Route path="/" element={<Navigate to="/login" replace />} />
          {/* Protected Admin Layout */}
          <Route element={<AdminLayout />}>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/content" element={<ContentList />} />
            <Route path="/content/create" element={<CreateContent />} />
            <Route path="/content/edit/:id" element={<EditContent />} />
            <Route path="/upload/slot-time" element={<UploadSlotTime />} />
            <Route
              path="/upload/department-courses"
              element={<UploadDepartmentCourses />}
            />
            <Route path="/upload/exams" element={<UploadExamTimetable />} />
            <Route path="/exams/preview" element={<ExamTimetablePreview />} />
            <Route path="/course-material" element={<CourseMaterialList />} />
            <Route path="/course-material/create" element={<CreateCourseMaterial />} />
            <Route path="/course-material/edit/:id" element={<EditCourseMaterial />} />
            <Route path="/audit" element={<AuditLogs />} />
          </Route>

          {/* Fallback */}
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  );
}

export default App;
