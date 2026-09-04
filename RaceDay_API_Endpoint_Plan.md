# RaceDay API Endpoint Plan

## Part 1 – System Planning and Database

### Roles
- **Organiser:** creates and manages events and categories, views enrolments, and records/updates results.
- **Participant:** manages their profile, enrols in available categories, and views their enrolments and results.
- **Public:** can register/login and view public event, category and result information.

### Planned API Endpoints

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | /api/auth/register | Registers a new Organiser or Participant account. | Public | { firstName, lastName, email, password, role, phone } | 201 Created; 400 Bad Request; 409 Conflict. |
| POST | /api/auth/login | Authenticates a user and returns an access token. | Public | { email, password } | 200 OK; 401 Unauthorized. |
| GET | /api/users/me | Returns the profile of the logged-in user. | Any logged-in user | None | 200 OK; 401 Unauthorized. |
| PUT | /api/users/me | Updates the logged-in user's profile. | Any logged-in user | { firstName, lastName, phone } | 200 OK; 400 Bad Request; 401 Unauthorized. |
| GET | /api/events | Returns available RaceDay events. | Public | None | 200 OK - event list. |
| GET | /api/events/{id} | Returns one event with its venue and categories. | Public | None | 200 OK; 404 Not Found. |
| POST | /api/events | Creates a new race event. | Organiser | { venueId, eventName, description, eventDate, startTime, status } | 201 Created; 400 Bad Request; 403 Forbidden. |
| PUT | /api/events/{id} | Updates an event managed by the organiser. | Organiser | { venueId, eventName, description, eventDate, startTime, status } | 200 OK; 404 Not Found; 403 Forbidden. |
| DELETE | /api/events/{id} | Removes an event where deletion is permitted. | Organiser | None | 204 No Content; 404 Not Found; 409 Conflict. |
| GET | /api/categories | Returns race categories, optionally filtered by event. | Public | None | 200 OK - category list. |
| GET | /api/events/{eventId}/categories | Returns categories belonging to an event. | Public | None | 200 OK; 404 Not Found. |
| POST | /api/events/{eventId}/categories | Creates a category for an event. | Organiser | { categoryName, distanceKm, maxParticipants, entryFee } | 201 Created; 400 Bad Request; 403 Forbidden. |
| PUT | /api/categories/{id} | Updates a race category. | Organiser | { categoryName, distanceKm, maxParticipants, entryFee } | 200 OK; 404 Not Found; 403 Forbidden. |
| DELETE | /api/categories/{id} | Deletes a category where permitted. | Organiser | None | 204 No Content; 404 Not Found; 409 Conflict. |
| POST | /api/events/{eventId}/enrolments | Enrols the logged-in participant in a category. | Participant | { categoryId } | 201 Created; 400 Bad Request; 409 Conflict. |
| GET | /api/enrolments/me | Returns the logged-in participant's enrolments. | Participant | None | 200 OK; 401 Unauthorized. |
| GET | /api/events/{eventId}/enrolments | Returns enrolments for organiser administration. | Organiser | None | 200 OK; 403 Forbidden; 404 Not Found. |
| PUT | /api/enrolments/{id} | Updates an enrolment status where permitted. | Organiser | { status } | 200 OK; 404 Not Found; 403 Forbidden. |
| DELETE | /api/enrolments/{id} | Cancels the logged-in participant's enrolment. | Participant | None | 204 No Content; 404 Not Found; 409 Conflict. |
| POST | /api/results | Records a result for a completed enrolment. | Organiser | { enrolmentId, finishPosition, finishTime, resultStatus } | 201 Created; 400 Bad Request; 409 Conflict. |
| GET | /api/events/{eventId}/results | Returns event results ordered by finish position. | Public | None | 200 OK; 404 Not Found. |
| GET | /api/results/me | Returns results for the logged-in participant. | Participant | None | 200 OK; 401 Unauthorized. |
| PUT | /api/results/{id} | Corrects or updates a recorded result. | Organiser | { finishPosition, finishTime, resultStatus } | 200 OK; 404 Not Found; 403 Forbidden. |
| DELETE | /api/results/{id} | Removes an incorrect result. | Organiser | None | 204 No Content; 404 Not Found; 403 Forbidden. |

### Planning Rules
- All endpoints use the `/api/` prefix.
- Authentication endpoints are public.
- Protected endpoints require authentication.
- Organiser and Participant permissions are enforced using role-based authorization.
- Part 2 implementation should closely follow these routes and response codes.
