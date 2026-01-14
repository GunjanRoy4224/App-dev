# \\## 📌 Project Overview

# 

# The \\\*\\\*ESEA App\\\*\\\* is a full-stack academic management application designed to handle \\\*\\\*student timetables, courses, materials, and administration tasks\\\*\\\* in a structured and scalable way.

# 

# 

# 

# The system consists of:

# 

# \\- A \\\*\\\*Flutter mobile application\\\*\\\* for students and admins

# 

# \\- A \\\*\\\*FastAPI backend\\\*\\\* that provides secure REST APIs

# 

# \\- A \\\*\\\*PostgreSQL database\\\*\\\* for persistent data storage

# 

# 

# 

# The project follows \\\*\\\*clean frontend–backend contracts\\\*\\\*, modular design, and real-world app development practices.

# 

# 

# 

# ---

# 

# 

# 

# \\## 🚀 Features

# 

# 

# 

# \\### 👨‍🎓 Student Features

# 

# \\- Secure login using \\\*\\\*SSO (OAuth-based authentication)\\\*\\\*

# 

# \\- View \\\*\\\*personal timetable\\\*\\\*

# 

# \\- Automatic \\\*\\\*slot conflict detection\\\*\\\*

# 

# \\- View \\\*\\\*currently running courses\\\*\\\*

# 

# \\- Access \\\*\\\*course materials\\\*\\\*

# 

# \\- Profile details (name, roll number, department, year)

# 

# \\- Cached timetable for faster app loading

# 

# 

# 

# ---

# 

# 

# 

# \\### 👨‍🏫 Admin Features

# 

# \\- Admin dashboard

# 

# \\- Department and course management

# 

# \\- Timetable creation and updates

# 

# \\- Course material uploads

# 

# \\- Student data access

# 

# \\- Role-based API protection

# 

# 

# 

# ---

# 

# 

# 

# \\### ⚙️ System Features

# 

# \\- RESTful APIs using FastAPI

# 

# \\- PostgreSQL database

# 

# \\- JWT-based authentication

# 

# \\- Error handling and logging

# 

# \\- Modular and scalable architecture

# 

# \\- Clear separation of frontend and backend logic

# 

# 

# 

# ---

# 

# 

# 

# \\## 🛠️ Tech Stack

# 

# 

# 

# \\### Frontend

# 

# \\- Flutter

# 

# \\- Dart

# 

# \\- Dio (HTTP client)

# 

# \\- Material UI

# 

# 

# 

# \\### Backend

# 

# \\- Python

# 

# \\- FastAPI

# 

# \\- SQLAlchemy

# 

# \\- OAuth (SSO Integration)

# 

# 

# 

# \\### Database

# 

# \\- PostgreSQL

# 

# 

# 

# ---

# 

# 

# 

# \\## 📂 Project Structure

# 

# 

# 

# \\### Flutter Frontend

# 

# lib/

# 

# ├── constants/ # API endpoints

# 

# ├── models/ # Data models

# 

# ├── services/ # API service classes

# 

# ├── screens/ # App screens

# 

# │ └── timetable/

# 

# ├── widgets/ # Reusable UI widgets

# 

# └── main.dart

# 

# 

# 

# \\### FastAPI Backend

# 

# 

# 

# app/

# 

# ├── routers/ # API routes

# 

# ├── models/ # Database models

# 

# ├── schemas/ # Pydantic schemas

# 

# ├── services/ # Business logic

# 

# ├── database.py

# 

# └── main.py

# 

# 

# 

# 

# 

# ---

# 

# 

# 

# \\## 🔐 Authentication Flow

# 

# 1\\. User logs in using SSO

# 

# 2\\. Backend verifies OAuth token

# 

# 3\\. JWT token is issued

# 

# 4\\. Role (student/admin) is determined server-side

# 

# 5\\. Secure APIs are accessed using JWT

# 

# 

# 

# ---

# 

# 

# 

# \\## 📅 Timetable Module

# 

# \\- Timetable is fetched using `/timetable/student`

# 

# \\- Slot-based system using `slot\\\_code`

# 

# \\- Conflict detection is handled in frontend logic

# 

# \\- Running class detection based on current time

# 

# \\- API response is cached for performance

# 

# 

# 

# ---

# 

# 

# 

# \\## 🧪 Error Handling

# 

# \\- Backend returns structured JSON error responses

# 

# \\- Frontend handles:

# 

# \&nbsp; - Network errors

# 

# \&nbsp; - Empty responses

# 

# \&nbsp; - Authentication failures

# 

# \\- Loading indicators and fallback UI are implemented

# 

# 

# 

# ---

# 

# 

# 

# \\## ▶️ How to Run the Project

# 

# 

# 

# \\### ✅ Prerequisites

# 

# \\- Flutter SDK installed

# 

# \\- Python 3.10+

# 

# \\- PostgreSQL installed and running

# 

# \\- Git

# 

# 

# 

# ---

# 

# 

# 

# \\### 🖥️ Backend Setup (FastAPI)

# 

# 

# 

# 1\\. Navigate to backend directory:

# 

# ```bash

# 

# cd esea-backend

# 

# 

# 

# 2\\. Create and activate virtual environment:

# 

# 

# 

# python -m venv venv

# 

# venv\\\\Scripts\\\\activate   # Windows

# 

# \\# source venv/bin/activate  # Linux / macOS

# 

# 

# 

# 

# 

# 3\\. Install dependencies:

# 

# 

# 

# pip install -r requirements.txt

# 

# 

# 

# 

# 

# 4\\. Set environment variables (example):

# 

# 

# 

# DATABASE\\\_URL=postgresql://username:password@localhost:5432/esea\\\_db

# 

# SSO\\\_CLIENT\\\_ID=your\\\_client\\\_id

# 

# SSO\\\_AUTH\\\_URL=your\\\_sso\\\_auth\\\_url

# 

# SECRET\\\_KEY=your\\\_secret\\\_key

# 

# 

# 

# 

# 

# 5\\. Run backend server:

# 

# 

# 

# uvicorn app.main:app --reload

# 

# 

# 

# 

# 

# Backend will start at:

# 

# 

# 

# http://127.0.0.1:8000

# 

# 

# 

# \*\*### Frontend Setup (Flutter)\*\*

# 

# 

# 

# 1.Navigate to frontend directory:

# 

# 

# 

# cd esea\\\_app

# 

# 

# 

# 

# 

# 2.Install Flutter dependencies:

# 

# 

# 

# flutter pub get

# 

# 

# 

# 

# 

# 3.Ensure backend URL is correct:

# 

# 

# 

# // lib/constants/api\\\_constants.dart

# 

# static const String baseUrl = "http://127.0.0.1:8000/api";

# 

# 

# 

# 

# 

# 4.Run the app:

# 

# 

# 

# flutter run

# 

# 

# 

# 🧠 Design Decisions

# 

# 

# 

# API-driven architecture

# 

# 

# 

# Strongly typed models

# 

# 

# 

# Centralized API constants

# 

# 

# 

# Backend controls business logic

# 

# 

# 

# Frontend focuses on UI and state management

# 

# 

# 

# 🔄 Future Improvements

# 

# 

# 

# UI/UX enhancements

# 

# 

# 

# Attendance tracking

# 

# 

# 

# Push notifications

# 

# 

# 

# Offline support

# 

# 

# 

# Docker-based deployment

# 

# 

# 

# Separate development and production environments

# 

# 

# 

# 👤 Author

# 

# 

# 

# Gunjan Kumar

# 

# App Development Project

# 

# Flutter + FastAPI

# 

# 

# 

# ✅ Project Status

# 

# 

# 

# ✔ Backend completed

# 

# ✔ Admin panel completed

# 

# ✔ Frontend integrated

# 

# ✔ Core features working

# 

# 🚧 UI and advanced features in progress

# 



