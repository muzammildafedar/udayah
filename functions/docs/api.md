## Endpoints

### [POST] /api/add-hr-emails

This endpoint allows you to add HR email addresses along with associated company information.

### Request Body

The request body must be in JSON format and include the following fields:

- **email_address** (string, required): The HR email address to be added. Must be a valid email format.
- **company_name** (string, required): The name of the company associated with the HR email.
- **website** (string, required): The company's website URL. Must be a valid URL.

**Example Request Body**:

```json
{
    "email_address": "hr@example.com",
    "company_name": "Example Company",
    "website": "https://example.com"
}
```

## Response (Success)

- **Status Code**: `201 Created`
- **Body**:
```json
  {
      "id": 1,
      "email_address": "hr@example.com",
      "company_name": "Example Company",
      "website": "https://example.com",
      "updatedAt": "2024-09-27T12:34:56.789Z",
      "createdAt": "2024-09-27T12:34:56.789Z"
  }
```
## Response (Error)


**Status Code**: `400 Bad Request` for validation errors

**Example Request Body**:


```json
{
    "email_address": "InvalidEmail.com",
    "company_name": "Example Company",
    "website": "https://example.com"
}
```

**Response**:
```json
{
    "errors": [
        {
            "type": "field",
            "value": "InvalidEmail.com",
            "msg": "Must be a valid email address",
            "path": "email_address",
            "location": "body"
        }
    ]
}
```
##

**Status Code**: `409 Bad Request` for duplicate emails

**Example Request Body**:

```json
{
    "error": "Email address already exists"
}
```