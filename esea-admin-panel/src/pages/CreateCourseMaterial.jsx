import { useNavigate } from "react-router-dom";
import { createCourseMaterial } from "../api/courseMaterialApi";
import CourseMaterialForm from "./CourseMaterialForm";

export default function CreateCourseMaterial() {
  const navigate = useNavigate();

  const submit = async (data) => {
    await createCourseMaterial(data);
    navigate("/course-material");
  };

  return (
    <>
      <h2>Create Course Material</h2>
      <CourseMaterialForm onSubmit={submit} />
    </>
  );
}
