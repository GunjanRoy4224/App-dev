import api from "./axios";

export const fetchCourseMaterials = () =>
  api.get("/admin/course-materials");

export const createCourseMaterial = (payload) =>
  api.post("/admin/course-materials", payload);

export const updateCourseMaterial = (id, payload) =>
  api.put(`/admin/course-materials/${id}`, payload);

export const deleteCourseMaterial = (id) =>
  api.delete(`/admin/course-materials/${id}`);
