from sqlalchemy import Column, Integer, String
from app.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)

    # SSO / Identity
    sso_id = Column(String, unique=True, index=True, nullable=False)
    username = Column(String, unique=True, index=True, nullable=True)
    email = Column(String, unique=True, index=True, nullable=True)

    # Personal info
    first_name = Column(String, nullable=True)
    last_name = Column(String, nullable=True)
    name = Column(String, nullable=False)

    roll_number = Column(String, index=True, nullable=True)
    department = Column(String, nullable=True)

    # Academic
    year = Column(String, nullable=True)
    join_year = Column(Integer, nullable=True)
    graduation_year = Column(Integer, nullable=True)

    # Auth
    role = Column(String, default="student")
    hashed_password = Column(String, nullable=True)
