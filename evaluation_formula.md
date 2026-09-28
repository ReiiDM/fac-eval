# Evaluation Score Calculation Formula

## Overview

The Faculty Evaluation System computes an **overall score** for each evaluation submission using a **weighted average** of category scores. The result is on a 1–5 scale.

---

## Formula

```
Overall Score = Σ (Category Average × Category Weight / 100)
```

---

## Step-by-Step Calculation

### Step 1: Category Average

For each evaluation category, compute the arithmetic mean of all rating-type question scores:

```
Category Average = Sum of all ratings in the category / Number of rating questions in the category
```

- Only questions with `question_type = 'rating'` are included.
- Comment-type questions are excluded from the numerical calculation.

### Step 2: Weighted Category Score

Multiply each category average by its assigned weight (expressed as a percentage):

```
Weighted Category Score = Category Average × (Category Weight / 100)
```

### Step 3: Overall Score

Sum all weighted category scores:

```
Overall Score = Σ Weighted Category Scores
```

The final value is **rounded to 2 decimal places** before being stored in the database.

---

## Constraints

| Rule | Description |
|------|-------------|
| Weight sum | All category weights in a form must sum to **100%** |
| Rating scale | Individual ratings are on a **1 to 5** scale |
| Result range | The overall score will always be between **1.00 and 5.00** |
| Rounding | Final score is rounded to **2 decimal places** |

---

## Example

Given 3 categories:

| Category | Weight | Average Rating |
|----------|--------|----------------|
| Teaching Effectiveness | 40% | 4.50 |
| Classroom Management | 35% | 3.80 |
| Professionalism | 25% | 4.20 |

**Calculation:**

```
Overall Score = (4.50 × 0.40) + (3.80 × 0.35) + (4.20 × 0.25)
             = 1.80 + 1.33 + 1.05
             = 4.18
```

**Result:** `4.18 / 5.00`

---

## Where It's Used

| Location | Purpose |
|----------|---------|
| `student/evaluate_form.php` | Calculates and stores the score on submission |
| `admin/result_detail.php` | Displays per-faculty overall average across all submissions |
| `faculty/results.php` | Shows faculty their own category and overall scores |
| `faculty/performance.php` | Displays career average and trend data |
| `faculty/dashboard.php` | Shows career-wide overall average |

---

## Database Storage

- **`evaluation_submissions.overall_score`** — stores the computed weighted average per submission
- **`evaluation_answers.rating_value`** — stores individual question ratings (used to recompute category averages in reports)
