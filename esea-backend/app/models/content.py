from sqlalchemy import Column, String, Text, Date, DateTime
from sqlalchemy.sql import func
from app.database import Base
import uuid

class Content(Base):
    __tablename__ = "contents"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    type = Column(String, nullable=False)

    title = Column(String, nullable=False)
    short_description = Column(Text, nullable=False)
    full_description = Column(Text)

    image_url = Column(String)
    file_url = Column(String)
    external_link = Column(String)

    event_date = Column(Date)
    event_time = Column(String)
    deadline = Column(Date)

    published_at = Column(DateTime, server_default=func.now())
