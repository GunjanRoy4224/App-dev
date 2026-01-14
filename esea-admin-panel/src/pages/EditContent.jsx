import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import {
  fetchAdminContentById,
  updateContent,
} from "../api/contentApi";

export default function EditContent() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [form, setForm] = useState(null);

  useEffect(() => {
    fetchAdminContentById(id)
      .then((res) => setForm(res.data))
      .catch(() => alert("Content not found"));
  }, [id]);

  if (!form) return <div>Loading...</div>;

  const handleSubmit = async () => {
    await updateContent(id, form);
    alert("Content updated");
    navigate("/content");
  };

  return (
    <div style={{ padding: 40 }}>
      <h2>Edit Content</h2>

      <select
        value={form.type}
        onChange={(e) => setForm({ ...form, type: e.target.value })}
      >
        <option value="announcement">Announcement</option>
        <option value="event">Event</option>
        <option value="internship">Internship</option>
        <option value="newsletter">Newsletter</option>
        <option value="research">Research</option>
      </select>

      <br /><br />

      <input
        value={form.title}
        onChange={(e) => setForm({ ...form, title: e.target.value })}
      />

      <br /><br />

      <textarea
        value={form.short_description || ""}
        onChange={(e) =>
          setForm({ ...form, short_description: e.target.value })
        }
      />

      <br /><br />

      <input
        value={form.file_url || ""}
        placeholder="Google Drive link"
        onChange={(e) =>
          setForm({ ...form, file_url: e.target.value })
        }
      />

      <br /><br />

      <input
        value={form.external_link || ""}
        placeholder="External link"
        onChange={(e) =>
          setForm({ ...form, external_link: e.target.value })
        }
      />

      <br /><br />

      <button onClick={handleSubmit}>Save</button>
    </div>
  );
}
