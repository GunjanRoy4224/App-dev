import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../api/axios";
import { updateCourseMaterial } from "../api/courseMaterialApi";
import CourseMaterialForm from "./CourseMaterialForm";

export default function EditCourseMaterial() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [data, setData] = useState(null);

  useEffect(() => {
    api.get(`/admin/course-materials`).then((res) => {
      const found = res.data.find((x) => x.id === id);
      setData(found);
    });
  }, [id]);

  if (!data) return <div>Loading...</div>;

  const submit = async (payload) => {
    await updateCourseMaterial(id, payload);
    navigate("/course-material");
  };

  return (
    <>
      <h2>Edit Course Material</h2>
      <CourseMaterialForm initial={data} onSubmit={submit} />
    </>
  );
}
