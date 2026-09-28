# Granby Colleges of Science and Technology
## Faculty Evaluation System

A comprehensive web-based faculty evaluation system with QR code student registration, weighted scoring, star-based ratings, profanity filtering, and multi-role dashboards.

---

## Features

- **Multi-department support** — each admin manages their own department
- **QR code student registration** — mobile-friendly self-registration with separate name fields
- **Configurable evaluation forms** — per department, with weighted categories (up to 45 questions)
- **Star-based rating UI** — interactive 1-5 star ratings with progress tracking
- **Profanity filter** — English + Tagalog, blocks inappropriate comments
- **Regular & irregular student support** — flexible enrollment (bulk + individual)
- **Anonymous evaluations** — students evaluate faculty per subject
- **Performance trends** — faculty see score charts, strengths, and areas for improvement
- **Real-time results** — faculty view scores after period closes
- **PDF & CSV exports** — comprehensive reporting
- **Dashboard notifications** — in-app alerts for all users
- **System settings** — configurable school info, passwords, score ranges
- **Dark blue + white theme** — clean, professional UI with school logo

---

## Tech Stack

- **Backend:** Plain PHP 8.x with PDO
- **Database:** MySQL 5.7+
- **Frontend:** Bootstrap 5.3, Bootstrap Icons, Chart.js, Vanilla JS
- **Server:** XAMPP (Apache + MySQL)
- **QR Generation:** QR Server API (free, no library needed)

---

## Installation

### 1. Prerequisites

- XAMPP installed (Apache + MySQL running)
- PHP 8.0 or higher
- MySQL 5.7 or higher

### 2. Clone/Copy Project

Place the `fac-eval` folder in your `htdocs` directory:
```
C:\xampp\htdocs\fac-eval\
```

### 3. Create Database

1. Open phpMyAdmin: `http://localhost/phpmyadmin`
2. Import files in this order:
   - `database/schema.sql` — creates database + tables + superadmin account
   - `database/seed.sql` — sample departments, courses, subjects, admin account
   - `database/settings_table.sql` — system settings
   - `database/rubric.sql` — 45-question evaluation rubric (optional)
   - `database/test_evaluation.sql` — test data with faculty + student (optional)

### 4. Configure Base URL

Edit `config/app.php` and update `BASE_URL`:

```php
// For local development:
define('BASE_URL', 'http://localhost/fac-eval');

// For LAN access (mobile QR scanning):
define('BASE_URL', 'http://YOUR_IP_ADDRESS/fac-eval');
```

To find your IP: run `ipconfig` in terminal and use the IPv4 address.

### 5. Configure Database Connection

Edit `config/db.php` if your MySQL credentials differ:

```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'fac_eval');
define('DB_USER', 'root');
define('DB_PASS', '');
```

### 6. Set Permissions

Ensure these directories are writable:
```
uploads/
exports/
assets/img/
```

---

## Default Accounts

All accounts use password: `Admin@1234`

| Role | Username | Description |
|---|---|---|
| Superadmin | `superadmin` | Full system access |
| Admin | `admin_cit` | CIT department admin |
| Faculty | `FAC-001` | Prof. Maria Santos |
| Student | `2024-00001` | Juan Dela Cruz |

**⚠️ Change passwords after first login in production.**

---

## System Roles

### Superadmin
- Manages departments, academic years, semesters
- Creates admin accounts per department
- Views system-wide reports and analytics
- Configures system settings (school info, passwords, score ranges)

### Admin (per department)
- Manages faculty, students, courses, subjects, sections
- Generates QR codes for student self-registration
- Reviews and accepts/rejects student registrations
- Assigns faculty to subjects per section
- Enrolls students (regular bulk + irregular manual)
- Builds evaluation forms (categories, questions, weights)
- Creates and manages evaluation periods
- Views department results and exports reports

### Faculty
- Views dashboard with stats, active evaluation alerts, recent comments
- Views evaluation results per subject (scores + category breakdown)
- Views performance trends with charts
- Views current semester subjects and student counts

### Student
- Self-registers via QR code (mobile-friendly)
- Views enrolled subjects with faculty info
- Evaluates faculty per subject using star ratings
- Views evaluation history
- Tracks evaluation progress

---

## Key Features Detail

### QR Code Registration Flow
1. Admin generates QR code with expiry date
2. Student scans QR on phone → opens registration form
3. Student fills: Last Name, First Name, M.I., DOB, gender, contact, email, address, course, year level, type
4. Admin reviews → Accept (credentials shown on screen) or Reject (with reason)
5. Student logs in with student number + default password

### Evaluation System
- **45-question rubric** across 3 categories:
  - Instructional Delivery & Technical Competence (50%)
  - Assessment & Student Progress Monitoring (30%)
  - Professionalism & Interpersonal Skills (20%)
- Interactive star ratings (1-5) with color-coded labels
- Progress bar showing completion status
- Submit button enables only when all ratings are filled
- Profanity filter blocks inappropriate English + Tagalog comments
- One submission per student per faculty-subject per period
- Weighted score calculation: category average × weight percentage

### Score Interpretation (configurable in Settings)
| Score Range | Label |
|---|---|
| 4.50 – 5.00 | Outstanding |
| 3.50 – 4.49 | Very Satisfactory |
| 2.50 – 3.49 | Satisfactory |
| 1.50 – 2.49 | Fair |
| 1.00 – 1.49 | Poor |

---

## File Structure

```
fac-eval/
├── config/
│   ├── app.php              # App name, school name, base URL
│   └── db.php               # PDO database connection
├── includes/
│   ├── auth.php             # Session, login, role guards
│   ├── functions.php        # Utilities, settings, pagination
│   ├── profanity_filter.php # English + Tagalog profanity check
│   ├── header.php           # Layout header with navbar + sidebar
│   ├── footer.php           # Layout footer with scripts
│   ├── 403.php / 404.php    # Error pages
│   ├── nav_*.php            # Navbar links per role
│   └── sidebar_*.php        # Sidebar links per role
├── assets/
│   ├── css/style.css        # Dark blue + white theme
│   ├── js/app.js            # Global JS (alerts, confirm, sidebar)
│   └── img/                 # School logo, favicon
├── database/
│   ├── schema.sql           # Full database schema (17 tables)
│   ├── seed.sql             # Sample data
│   ├── settings_table.sql   # Settings table + defaults
│   ├── rubric.sql           # 45-question evaluation rubric
│   ├── test_evaluation.sql  # Test data for evaluation flow
│   └── fix_admin.sql        # Admin account fix
├── api/
│   ├── get_notifications.php
│   ├── mark_notification_read.php
│   └── check_profanity.php
├── superadmin/              # Superadmin pages (8 pages)
├── admin/                   # Admin pages (18 pages)
├── faculty/                 # Faculty pages (6 pages)
├── student/                 # Student pages (7 pages)
├── uploads/                 # Student photos (secured)
├── exports/                 # Generated reports (secured)
├── index.php                # Landing redirect
├── login.php                # Unified login
├── logout.php               # Session destroy
├── register.php             # QR-based student registration
├── change_password.php      # Password change (first login)
├── .htaccess                # Security rules
├── flow.md                  # System flow documentation
└── README.md                # This file
```

---

## Security Features

- PDO prepared statements (all queries parameterized)
- Password hashing (bcrypt via `password_hash()`)
- Session-based auth with role guards on every page
- XSS prevention (`htmlspecialchars()` on all output)
- CSRF protection via session-based forms
- File upload validation (MIME type check, random filenames)
- Secured directories (`.htaccess` blocks PHP execution in uploads)
- Profanity filter on student comments
- Directory listing disabled
- Sensitive files blocked (`.sql`, `.md`, `.json`)

---

## Database Tables (18)

| Table | Purpose |
|---|---|
| users | All user accounts (unified login) |
| departments | School departments |
| academic_years | Academic year periods |
| semesters | Semesters per academic year |
| courses | Degree programs per department |
| subjects | Subjects per department |
| sections | Sections per semester |
| admins | Admin profiles (linked to users) |
| faculty | Faculty profiles (linked to users) |
| students | Student profiles (linked to users) |
| faculty_subject_assignments | Faculty → subject + section mapping |
| student_subject_enrollments | Student → subject enrollment |
| registration_qr_codes | QR codes for registration |
| student_registration_requests | Pending registrations |
| evaluation_forms | Evaluation form definitions |
| evaluation_categories | Categories with weights |
| evaluation_questions | Questions per category |
| evaluation_periods | Evaluation windows |
| evaluation_submissions | Student submissions |
| evaluation_answers | Individual answers |
| notifications | In-app notifications |
| settings | System configuration |

---

## License

Proprietary — Granby Colleges of Science and Technology

---

**Built for Granby Colleges of Science and Technology**
