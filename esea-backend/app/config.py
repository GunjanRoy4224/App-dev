from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    # App
    APP_NAME: str = "ESEA API"

    # Database
    DATABASE_URL: str

    # Security
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    # IITB SSO
    SSO_ENABLED: bool = False
    SSO_CLIENT_ID: Optional[str] = None
    SSO_CLIENT_SECRET: Optional[str] = None
    SSO_AUTH_URL: Optional[str] = None
    SSO_TOKEN_URL: Optional[str] = None
    SSO_PROFILE_URL: Optional[str] = None
    SSO_REDIRECT_URI: Optional[str] = None

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"
        extra = "ignore"


settings = Settings()
