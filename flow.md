# Granby Colleges of Science and Technology
# Faculty Evaluation System — Master Flow Guide

---

## Table of Contents
1. [System Overview](#1-system-overview)
2. [Roles & Access](#2-roles--access)
3. [Full System Flow](#3-full-system-flow)
4. [Feature Flows](#4-feature-flows)
5. [Evaluation Rubric](#5-evaluation-rubric)
6. [Database Schema](#6-database-schema)
7. [Page Map](#7-page-map)
8. [Settings](#8-settings)

---

## 1. System Overview

**System:** Faculty Evaluation System
**School:** Granby Colleges of Science and Technology
**Stack:** Plain PHP 8.x, MySQL, Bootstrap 5, Chart.js
**Theme:** Dark Blue (#0D0B61) + White
**Server:** XAMPP

### Purpose
Allow students to evaluate their faculty per subject per semester using a comprehensive 45-question rubric with star-based ratings. Results are reviewed by admins and superadmin for performance monitoring.

### Key Features
- Multi-department support
- QR code self-registration for students (mobile-friendly)
- Configurable evaluation forms per department (up to 45 questions)
- Interactive star ratings (1-5) with progress tracking
- Profanity filter (English + Tagalog)
- Weighted scoring with 3 categories
- Regular and irregular student support
- PDF + CSV export
- Performance trend charts for faculty
- Dashboard-only notifications
- Configurable system settings

---

## 2. Roles & Access

| Role | Scope | Pages |
|---|---|---|
| **Superadmin** | Full system | 8 pages |
| **Admin** | Department-level | 18 pages |
| **Faculty** | Own results only | 6 pages |
| **Student** | Evaluate + view own data | 7 pages |

---

## 3. Full System Flow

```
[SETUP — Superadmin]
  1. Login as superadmin
  2. Go to Settings → configure school info, passwords, score ranges
  3. Create Academic Years (2025-2026, 2026-2027, 2027-2028)
  4. Create Semesters per academic year (1st, 2nd, Summer)
  5. Set active academic year and semester
  6. Create Departments
  7. Create Admin accounts per department

[ACADEMIC SETUP — Admin]
  8.  Login as admin
  9.  Create Courses (BSIT, BSCS, etc.)
  10. Create Subjects (IT101, IT102, etc.)
  11. Create Sections (BSIT-2A, BSIT-2B, etc.)
  12. Add Faculty members (creates user account + credentials)
  13. Assign Faculty to Subject + Section for the semester

[STUDENT REGISTRATION — Admin + Students]
  14. Admin generates QR Code (with expiry date)
  15. Admin prints/shares QR code
  16. Student scans QR on phone → opens registration form
  17. Student fills: Last Name, First Name, M.I., DOB, gender, contact,
      email, address, course, year level, student type
  18. Student submits → goes to admin's pending list
  19. Admin reviews → Accept or Reject
      ├── Accept → credentials shown on screen (student_no + default password)
      └── Reject → optional reason provided
  20. Admin hands credentials to student

[ENROLLMENT — Admin]
  21. Regular students: Bulk enroll by course + year level + section → subjects
  22. Irregular students: Individual enroll per subject

[EVALUATION SETUP — Admin]
  23. Build Evaluation Form (or use the 45-question rubric)
      ├── Add categories with weights (must sum to 100%)
      └── Add questions per category (rating or open-ended)
  24. Create Evaluation Period (title, form, semester, start/end date)
  25. Period opens → students receive dashboard notification

[EVALUATION — Student]
  26. Student logs in → sees pending evaluations on dashboard
  27. Goes to Evaluate Faculty → sees list of subjects + faculty
  28. Clicks "Evaluate Now" on a subject
  29. Star-based form loads with categories and questions
  30. Rates each question 1-5 stars (progress bar fills)
  31. Optionally adds comments (profanity filter active)
  32. Submit button enables when all ratings are filled
  33. Submits → locked (one submission per student per faculty-subject per period)
  34. Can view completion status in Evaluation History

[RESULTS — After Period Closes]
  35. Admin manually closes period OR end date auto-closes it
  36. Faculty receives notification: "Results available"
  37. Faculty views:
      ├── Dashboard: latest score, active eval alert, comments, subjects
      ├── My Results: scores per subject, category breakdown, comments
      └── Performance: trend chart, strengths, areas for improvement
  38. Admin views:
      ├── Results: ranked table of all faculty scores
      ├── Result Detail: category breakdown + comments per faculty
      └── Reports: export CSV or printable PDF
  39. Superadmin views:
      ├── System-wide reports
      ├── Department averages comparison
      └── Top 5 / Bottom 5 faculty
```

---

## 4. Feature Flows

### 4.1 QR Code Student Registration

```
Admin → QR Codes → Generate
  → System creates token: bin2hex(random_bytes(32))
  → QR encodes: http://IP_ADDRESS/fac-eval/register.php?token=<token>
  → Admin downloads/prints QR

Student scans QR on phone
  → Validates token (exists, active, not expired)
  → Shows mobile-friendly form:
      Last Name*, First Name*, M.I. (optional)
      DOB*, Gender*, Contact*, Email*, Address*
      Course*, Year Level*, Student Type*
      Photo (optional, camera capture)
  → Submits → saved as pending

Admin → Registrations → Pending tab
  → View details → Accept or Reject
  → Accept:
      Student No generated: YYYY-XXXXX
      Username = Student No
      Password = Prefix + last 4 digits (e.g., Granby@0001)
      Credentials shown in modal with Copy button
```

### 4.2 Student Enrollment

```
REGULAR (Bulk):
  Admin → Enrollment → Bulk Enroll tab
  → Select: Course + Year Level + Section + Subjects (checkboxes)
  → Click "Bulk Enroll"
  → All matching regular students enrolled in selected subjects
  → Uses INSERT IGNORE (skips duplicates)

IRREGULAR (Individual):
  Admin → Enrollment → Individual Enroll tab
  → Select: Student + Section + Subjects
  → Click "Enroll Student"
  → Student enrolled in selected subjects only
```

### 4.3 Evaluation Form Builder

```
Admin → Eval Forms → Create Form
  → Name, description, academic year, semester
  → Redirects to form editor

Form Editor:
  → Add Categories (name + weight %)
  → Weight indicator shows if total = 100%
  → Per category: Add Questions
      Type: Rating (1-5 stars) or Open-ended (text)
      Order number for display sequence
  → Edit/delete categories and questions
```

### 4.4 Student Evaluation Flow

```
Student → Evaluate Faculty
  → Sees cards for each pending evaluation:
      Subject code + name, Faculty name, Section, Deadline
  → Clicks "Evaluate Now"
  → Full-page evaluation form loads:
      - Hero header with faculty/subject info
      - Progress bar (fills as questions are answered)
      - Categories with emoji icons + weight badges
      - Star ratings (click stars, label appears)
      - Open-ended textareas with character counter
      - Profanity filter checks comments on submit
      - Submit button disabled until all ratings filled
      - Confirmation dialog before final submit
  → Score computed: weighted average of category averages
  → Submission locked (cannot re-submit)
```

### 4.5 Results & Reports

```
Faculty Dashboard:
  - Overall score, subjects, students, evaluations count
  - Active evaluation alert (if students are currently evaluating)
  - Latest score circle with rating label
  - Current semester subjects list
  - Recent anonymous comments
  - Quick links + score guide

Faculty Performance Page:
  - Line chart: score trend over semesters (Chart.js)
  - Career average, total periods, total respondents
  - Top 2 strengths (highest categories)
  - Top 2 areas for improvement (lowest categories)
  - All categories with progress bars

Admin Results:
  - Filter by closed period
  - Department average, faculty count, respondents, submissions
  - Ranked table: faculty scores per subject
  - Detail view: category breakdown + comments

Admin Reports:
  - CSV export (opens in Excel)
  - PDF export (printable HTML report)

Superadmin Reports:
  - System-wide stats
  - Department averages comparison
  - Top 5 / Bottom 5 faculty per period
```

---

## 5. Evaluation Rubric

### Category 1: Instructional Delivery & Technical Competence (50%)
1. Demonstrates mastery of the subject matter.
2. Explains complex concepts in a clear and understandable manner.
3. Organizes classroom activities effectively to maximize learning time.
4. Uses a variety of teaching strategies to engage different learning styles.
5. Integrates latest industry trends and technologies into the discussion.
6. Provides clear objectives at the start of every lesson.
7. Encourages critical thinking through questioning and problem-solving.
8. Uses instructional media (PPT, videos, software) effectively.
9. Responds to student questions with depth and clarity.
10. Relates lesson content to real-world applications.
11. Maintains a classroom atmosphere conducive to learning.
12. Demonstrates enthusiasm and passion for the subject.
13. Effectively manages student behavior and participation.
14. Adjusts the pace of the lesson according to student understanding.
15. Summarizes key points effectively at the end of the session.

### Category 2: Assessment & Student Progress Monitoring (30%)
16. Aligns quizzes and exams with the stated learning objectives.
17. Provides timely feedback on assignments and projects.
18. Uses fair and transparent grading criteria (rubrics).
19. Returns corrected papers and assessments promptly.
20. Offers constructive criticism to help students improve.
21. Conducts regular formative assessments (short quizzes/recitations).
22. Monitors individual student progress throughout the semester.
23. Provides remedial help or guidance to struggling students.
24. Encourages students to track their own academic growth.
25. Challenges students with high-level assignments and projects.
26. Varies assessment methods (written, oral, practical).
27. Clearly explains how final grades are calculated.
28. Ensures assessment tasks are free from bias.
29. Uses data from assessments to revisit difficult topics.
30. Recognizes and rewards student improvement and excellence.

### Category 3: Professionalism & Interpersonal Skills (20%)
31. Arrives at and dismisses classes punctually.
32. Shows respect and courtesy toward all students.
33. Is available for consultation during scheduled hours.
34. Maintains professional appearance and demeanor.
35. Upholds the core values of Granby Colleges of Science and Technology.
36. Communicates effectively through official school channels.
37. Shows consistency in following school policies and regulations.
38. Handles confidential student information with integrity.
39. Demonstrates approachability and openness to student concerns.
40. Promotes a culture of inclusivity and diversity in the classroom.
41. Acts as a positive role model for students.
42. Resolves classroom conflicts in a fair and professional manner.
43. Shows preparation and readiness for every class session.
44. Encourages student feedback to improve teaching methods.
45. Collaborates effectively within the academic community.

---

## 6. Database Schema (18 tables + 1 settings)

### Core
- `users` — all accounts (superadmin, admin, faculty, student)
- `departments` — school departments
- `academic_years` — year periods (2025-2026, etc.)
- `semesters` — 1st, 2nd, Summer per year
- `settings` — key-value system configuration

### Academic
- `courses` — degree programs (BSIT, BSCS, etc.)
- `subjects` — subjects per department
- `sections` — sections per semester + course

### Profiles
- `admins` — admin → department link
- `faculty` — faculty profile + employee_no
- `students` — student profile + student_no + type

### Assignments & Enrollment
- `faculty_subject_assignments` — faculty teaches subject in section
- `student_subject_enrollments` — student enrolled in subject

### Registration
- `registration_qr_codes` — QR tokens with expiry
- `student_registration_requests` — pending/accepted/rejected

### Evaluation
- `evaluation_forms` — form definitions per department
- `evaluation_categories` — categories with weights
- `evaluation_questions` — questions (rating or open-ended)
- `evaluation_periods` — evaluation windows (upcoming/open/closed)
- `evaluation_submissions` — student submissions with overall score
- `evaluation_answers` — individual question answers

### System
- `notifications` — in-app notifications per user

---

## 7. Page Map

### Public (no login required)
| Page | Purpose |
|---|---|
| `/login.php` | Unified login for all roles |
| `/register.php?token=X` | Student self-registration (mobile) |
| `/change_password.php` | First-login password change |

### Superadmin (`/superadmin/`)
| Page | Purpose |
|---|---|
| `dashboard.php` | Stats overview |
| `departments.php` | CRUD departments |
| `admins.php` | CRUD admin accounts |
| `academic_years.php` | Manage academic years |
| `semesters.php` | Manage semesters |
| `reports.php` | System-wide analytics |
| `settings.php` | School info, passwords, score ranges |
| `profile.php` | Edit own profile |
| `notifications.php` | View notifications |

### Admin (`/admin/`)
| Page | Purpose |
|---|---|
| `dashboard.php` | Department overview + quick actions |
| `faculty.php` | CRUD faculty |
| `students.php` | View/manage students + view credentials |
| `courses.php` | CRUD courses |
| `subjects.php` | CRUD subjects |
| `sections.php` | Manage sections per semester |
| `assignments.php` | Assign faculty to subjects |
| `enrollment.php` | Bulk + individual enrollment |
| `qr_codes.php` | Generate/manage QR codes |
| `registrations.php` | Accept/reject student registrations |
| `evaluation_forms.php` | Create evaluation forms |
| `evaluation_form_edit.php` | Edit categories + questions |
| `evaluation_periods.php` | Create/open/close periods |
| `results.php` | View department results |
| `result_detail.php` | Per-faculty detail view |
| `reports.php` | Export CSV + PDF |
| `profile.php` | Edit own profile |
| `notifications.php` | View notifications |

### Faculty (`/faculty/`)
| Page | Purpose |
|---|---|
| `dashboard.php` | Stats, alerts, subjects, comments, quick links |
| `my_subjects.php` | Current semester subjects + student counts |
| `results.php` | Scores per subject + category breakdown |
| `performance.php` | Trend chart, strengths, improvements |
| `profile.php` | Edit own profile |
| `notifications.php` | View notifications |

### Student (`/student/`)
| Page | Purpose |
|---|---|
| `dashboard.php` | Progress tracker, stats, periods, quick links |
| `evaluate.php` | List of pending/completed evaluations |
| `evaluate_form.php` | Star-based evaluation form |
| `my_subjects.php` | Enrolled subjects with faculty info |
| `history.php` | Past evaluation submissions log |
| `profile.php` | Edit own profile |
| `notifications.php` | View notifications |

### API (`/api/`)
| Endpoint | Purpose |
|---|---|
| `get_notifications.php` | Fetch latest notifications (JSON) |
| `mark_notification_read.php` | Mark notification as read |
| `check_profanity.php` | Real-time profanity check (JSON) |

---

## 8. Settings (Superadmin → Settings)

### School Information
- School name, address, contact, email, website
- Logo upload (replaces school_logo.jpg)

### Password Defaults
- Student password prefix (default: `Granby@` + last 4 digits)
- Faculty default password
- Admin default password
- Force password change on first login (toggle)

### Evaluation Score Ranges
| Level | Default Label | Default Min Score |
|---|---|---|
| 5 (Highest) | Outstanding | 4.50 |
| 4 | Very Satisfactory | 3.50 |
| 3 | Satisfactory | 2.50 |
| 2 | Fair | 1.50 |
| 1 (Lowest) | Poor | 1.00 |

- Max comment length (default: 1000 characters)
- Allow open-ended comments (toggle)

---

*Faculty Evaluation System — Granby Colleges of Science and Technology*
*Last updated: May 2026*
