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
    "website": "https://example.com",
    "added_by": "user@example.com"
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
    "website": "https://example.com",
    "added_by": "user@example.com"
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

```json
{
    "error": "Email address already exists"
}
```

### [GET] /api/companies/:company_id?


## Description

Fetches company information from the database.
The endpoint can return details for a specific company if the `company_id` is provided. If `company_id` is not provided, it returns a list of all companies.

## Parameters
- **Optional Route Parameter:**
  - `company_id` (integer, optional): The unique identifier of the company.
    - **Validation**: Must be a positive integer greater than 0.
    - **Example**: 
      - Valid: `1`, `5`, `100`
      - Invalid: `0`, `-1`, `abc`

## Request Example
- To fetch all companies:
```
GET /api/companies
```

- To fetch company with id 2:
```
GET /api/companies/2
```
## Response (Success)

- **Status Code**: `200 ok`

```json
{
    "iv": "K3YrDTOwrJaSJ4n0H1rjJg==",
    "encryptedData": "d0RZrXdNhdQadzIz9ratZWx/m6PvBxKpgK8M9E2bgnaLu7oKHHU3JpYdOr/dKFCD1apuq6xUUTlDQBTI2CW4RhrQe7GpRU8d8TSSbKfeW7qHhLAwlJKCmOMcBTZ8jMMSqrgFoyYIZvqpDPFTD8VsE2mi8y3sUOlCkuZWS7XXHnRSJseMTp4iHhak+LO0BH91vvec2DxrEKbDM1dvY80IYXfuOzBoar+PyKfli7iJbmVCYG9MObdTVi6peJptL4O7YayrXTWQ/aEcBYim6vVLU1NKBrpnMiorG2DceKTwGAVBnmI0xMk/5ndgIutTskFD"
}
```

## Response (Error)

- **Status Code**: `400 Bad Request`

```json
{
    "errors": [
        {
            "type": "field",
            "value": "-25",
            "msg": "Company ID must be a positive integer",
            "path": "company_id",
            "location": "params"
        }
    ]
}
```

- **Status Code**: `404 Not Found`

```json
{
    "message": "email not found"
}
```