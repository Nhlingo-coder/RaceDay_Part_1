# RaceDay System – Part 1: System Planning and Database

## 1. Project Overview
RaceDay is a race-event management system designed to manage race events, venues, race categories, participant enrolments and race results.

This repository contains the planning documents and SQL database required for **Part 1 – System Planning and Database**.

## 2. System Roles

### Organiser
An Organiser can:
- Create and manage race events.
- Manage event categories.
- View participant enrolments.
- Record and update race results.

### Participant
A Participant can:
- Register and log in.
- Manage their profile.
- View available events and categories.
- Enrol in race categories.
- View their enrolments and results.

## 3. Database Design

The RaceDay SQL Server database contains six entities:

1. **Users** – stores Organisers and Participants.
2. **Venues** – stores event locations.
3. **Events** – stores race events.
4. **Categories** – stores categories belonging to events.
5. **Enrolments** – links Participants to Categories.
6. **Results** – stores race finishing results.

### Relationships

| Relationship | Cardinality | Explanation |
|---|---|---|
| Users → Events | 1 : Many | One organiser can manage many events. |
| Venues → Events | 1 : Many | One venue can host many events. |
| Events → Categories | 1 : Many | One event can have many categories. |
| Users → Enrolments | 1 : Many | One participant can have many enrolments. |
| Categories → Enrolments | 1 : Many | One category can have many enrolments. |
| Enrolments → Results | 1 : 0..1 | An enrolment can have zero or one result. |

## 4. ERD – dbdiagram.io

The ERD source is:

`docs/RaceDay_ERD.dbml`

The DBML file is prepared for **dbdiagram.io**.

To view it:
1. Open dbdiagram.io.
2. Create a new diagram.
3. Use DBML.
4. Paste the contents of `docs/RaceDay_ERD.dbml`.
5. Generate and verify the diagram.
6. Export the final ERD as PNG or PDF if required.

The repository also contains:
- `docs/RaceDay_ERD.png`
- `docs/RaceDay_ERD.pdf`

The ERD includes six entities, primary keys, foreign keys and relationship cardinalities.

## 5. API Endpoint Plan

The RESTful API plan is contained in:

- `docs/RaceDay_API_Endpoint_Plan.md`
- `docs/RaceDay_API_Endpoint_Plan.pdf`

The plan covers:
- Authentication – register and login
- User Profile
- Events
- Categories
- Event Enrolments
- Results

Every endpoint includes:
- HTTP Method
- Route
- Description
- Role Required
- Request Body
- Expected Response

## 6. SQL Database Script

The SQL Server script is:

`docs/RaceDay_Database.sql`

The script includes:
- `CREATE DATABASE RaceDay`
- Six tables
- Primary keys
- Foreign keys
- `NOT NULL` constraints
- `UNIQUE` constraints
- `DEFAULT` constraints
- `CHECK` constraints
- Sample data
- Verification queries

### Required sample data

The database contains:
- 2 Organisers
- 2 Participants
- 3 Events
- Categories for each event
- Sample enrolments
- Sample results

## 7. Running the SQL Script in SSMS

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Open `docs/RaceDay_Database.sql`.
4. Execute the script.
5. Confirm that the `RaceDay` database is created.
6. Check that the following six tables exist:

```text
Users
Venues
Events
Categories
Enrolments
Results
```

7. Check the verification queries at the bottom of the script.

## 8. GitHub Actions / CI/CD

The workflow is located at:

`.github/workflows/validate-docs.yml`

It checks that the required `/docs` folder and planning files exist.

After pushing the repository to GitHub:
1. Open the **Actions** tab.
2. Run/check the RaceDay workflow.
3. Confirm that it finishes successfully with a green status.
4. Take a screenshot of the successful build.
5. Add the screenshot to this README.

## 9. CI/CD Screenshot

**ADD YOUR ACTUAL GITHUB ACTIONS GREEN-BUILD SCREENSHOT HERE**

Example:

```markdown
![GitHub Actions Successful Build](docs/github-actions-green-build.png)
```

## 10. YouTube Video

An unlisted YouTube video is required for the submission.

The video should demonstrate:
1. The RaceDay planning documents.
2. The two system roles.
3. The ERD and relationship decisions.
4. The API endpoint plan.
5. The SQL database design.
6. The SQL script being executed in SSMS.

**YouTube Link:**

`ADD YOUR UNLISTED YOUTUBE LINK HERE`

## 11. Repository Structure

```text
RaceDay/
│
├── .github/
│   └── workflows/
│       └── validate-docs.yml
│
├── docs/
│   ├── RaceDay_ERD.dbml
│   ├── RaceDay_ERD.png
│   ├── RaceDay_ERD.pdf
│   ├── RaceDay_API_Endpoint_Plan.md
│   ├── RaceDay_API_Endpoint_Plan.pdf
│   ├── RaceDay_Database.sql
│   ├── 20_Commit_Plan.md
│   └── Submission_Checklist.md
│
└── README.md
```

## 12. Suggested 20 Meaningful Commits

```text
1. Initialise RaceDay Part 1 repository
2. Create docs folder
3. Add Users entity to ERD
4. Add Venues entity to ERD
5. Add Events entity to ERD
6. Add Categories entity to ERD
7. Add Enrolments entity to ERD
8. Add Results entity to ERD
9. Finalise ERD relationships
10. Add dbdiagram.io DBML source
11. Add authentication endpoint plan
12. Add user profile endpoint plan
13. Add event endpoint plan
14. Add category endpoint plan
15. Add enrolment endpoint plan
16. Add results endpoint plan
17. Create RaceDay SQL database schema
18. Add SQL sample data
19. Add GitHub Actions validation
20. Complete README and submission documentation
```

The commits should represent real changes and must be made using the student's own GitHub account.

## 13. Final Submission Checklist

- [ ] `/docs` folder exists.
- [ ] ERD contains at least six entities.
- [ ] ERD contains attributes, PKs and FKs.
- [ ] ERD shows relationship cardinalities.
- [ ] dbdiagram.io DBML source is included.
- [ ] ERD PNG/PDF is included.
- [ ] API endpoint plan is included.
- [ ] Authentication endpoints are included.
- [ ] User Profile endpoints are included.
- [ ] Event endpoints are included.
- [ ] Category endpoints are included.
- [ ] Enrolment endpoints are included.
- [ ] Result endpoints are included.
- [ ] SQL script is included.
- [ ] SQL script contains all six entities.
- [ ] SQL script contains PKs, FKs and required constraints.
- [ ] SQL script contains 2 Organisers.
- [ ] SQL script contains 2 Participants.
- [ ] SQL script contains 3 Events.
- [ ] SQL script contains categories for each event.
- [ ] SQL script contains sample enrolments.
- [ ] SQL script has been tested in SSMS.
- [ ] GitHub Actions workflow passes.
- [ ] Green-build screenshot is added to README.
- [ ] Unlisted YouTube video is recorded.
- [ ] YouTube link is added to README.
- [ ] At least 20 meaningful GitHub commits are completed.
- [ ] GitHub repository link is ready for ARC submission.

## 14. Conclusion

The RaceDay Part 1 planning provides the foundation for Part 2 development. The ERD defines the database structure, the API plan defines the planned RESTful endpoints, and the SQL script creates and populates the RaceDay database in SQL Server.

The ERD, API plan and SQL script should remain consistent with the final application implementation. Any deliberate changes made in Part 2 should be documented in the repository.

## 15. Youtube Link

https://youtu.be/NT5vAyYRkYc?si=npXHYWnKNjgNgfmD
