# API Documentation Index

This directory contains API-specific documentation for MedicBD.

## Purpose
- Keep all API contracts in one place.
- Make backend and frontend integration predictable.
- Track versioned behavior without mixing UI docs.

## Suggested File Layout
- `README.md` (this file)
- `authentication.md` (JWT login flow, token usage, expiry)
- `error-format.md` (standard error response contract)
- `doctors.md` (doctor endpoints and filter contracts)
- `chambers.md` (chamber endpoints and district-first filtering)
- `schedules.md` (doctor schedule endpoints, bulk update payload)
- `versioning.md` (v1 compatibility and deprecation policy)

## Current Business Rules (v1)
- Doctor discovery uses both `specialization_id` and `district_id` in the main filter flow.
- Chamber discovery is district-first and can be refined by `category`.

## Endpoint Documentation Template
Use this template for each endpoint doc:

```md
# <Resource>

## Endpoint
- Method: `GET|POST|PATCH|DELETE`
- Path: `/api/v1/...`

## Query Params / Body
- ...

## Success Response
- Status: `200|201`
- Example:
```json
{
  "data": []
}
```

## Error Response
- Status: `4xx|5xx`
- Example:
```json
{
  "error": "message"
}
```

## Notes
- Validation rules
- Authorization requirements
- Performance considerations
```

## Next Recommended Docs to Add
1. `doctors.md`
2. `chambers.md`
3. `authentication.md`
4. `error-format.md`
