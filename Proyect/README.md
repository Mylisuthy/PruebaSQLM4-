# Full Stack Project

## Bulk Data Upload

An attempt was made to implement this functionality, but the error could not be encrypted.

## Security

- All protected routes require JWT.
- Input validation and sanitization on both backend and frontend.
- RLS policies enabled in the database.
- It is recommended to use HTTPS and restrict CORS in production.

## Advanced Security

- **CORS**: Only allows requests from the configured frontend.
- **Helmet**: Adds secure HTTP headers.
- **XSS**: Payloads containing `<script>` are rejected in the backend.
- **CSRF**: It is recommended to use CSRF tokens when using cookies/sessions.
- **RLS**: Row Level Security policies are active in the database.
- **Validation and Sanitization**: All inputs are validated in both backend and frontend.

## Structure

- `/backend/apy/Masive.js`: `/bulk` endpoint for bulk uploads.
- `/frontend/src/js/csv_upload.js`: Logic for uploading and validating CSV files.

## Deployment Recommendations

- Use HTTPS in production.
- Configure secure environment variables.
- Review and adjust RLS policies according to the domain.

## Recommended Stress Tests

- **Bulk upload with corrupted data:**  
  Upload a CSV with empty fields, incorrectly formatted dates, or duplicates. The backend should reject invalid records and display the corresponding error.
- **Script injection in forms:**  
  Try submitting `<script>alert(1)</script>` in any text field. The backend should reject the payload, and the frontend should sanitize the input.
- **Bulk upload with more than 1000 records:**  
  Verify that the system handles large volumes correctly and returns an error if the allowed limit is exceeded.

## Frontend Security

- **Input sanitization:**  
  Use escape functions in forms before sending data to the backend.
- **Secure token storage:**  
  The JWT token is stored in `localStorage` and sent only via the Authorization header.
- **XSS Protection:**  
  Never insert user data directly into the DOM without sanitizing it.
- **CORS:**  
  The backend only accepts requests from the configured frontend domain.

## Quick Start

Run `npm install` in both frontend and backend.

Create a `.env` file in the backend to connect to Supabase:
```
SUPABASE_URL= the connection URL
SUPABASE_SERVICE_ROLE= Supabase service role
JWT_SECRET= the secret
```

**Name:** Juan David Gonzalez Hincapie  
**Clan:** Linus  
**Email:** juanch052048@gmail.com
