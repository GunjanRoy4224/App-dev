import { useState } from "react";
import { createContent } from "../api/contentApi";

export default function CreateContent() {
  const [form, setForm] = useState({
    type: "announcement",
    title: "",
    short_description: "",
    file_url: "",
    external_link: "",
  });

  const handleSubmit = async () => {
    try {
      await createContent(form);
      alert("Content created");
    } catch (err) {
      alert("Error creating content");
    }
  };

  return (
    <div style={{ padding: 40 }}>
      <h2>Create Content</h2>

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
        placeholder="Title"
        value={form.title}
        onChange={(e) => setForm({ ...form, title: e.target.value })}
      />

      <br /><br />

      <textarea
        placeholder="Short description"
        value={form.short_description}
        onChange={(e) =>
          setForm({ ...form, short_description: e.target.value })
        }
      />

      <br /><br />

      <input
        placeholder="Google Drive file link"
        value={form.file_url}
        onChange={(e) => setForm({ ...form, file_url: e.target.value })}
      />

      <br /><br />

      <input
        placeholder="External link (optional)"
        value={form.external_link}
        onChange={(e) =>
          setForm({ ...form, external_link: e.target.value })
        }
      />

      <br /><br />

      <button onClick={handleSubmit}>Publish</button>
    </div>
  );
}
