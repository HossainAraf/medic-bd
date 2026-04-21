# ------------------------
# Security Best Practices
# -----------------------

## CSRF and browser safety

- Avoid GET for state changes. Never use GET requests for actions that modify data, because Rails does not verify CSRF tokens for GET requests.

- Keep secure cookies enabled. Rails uses `SameSite=Lax` cookies by default, which adds browser-level protection against CSRF.

- Prevent XSS. Cross-Site Scripting can bypass CSRF protection if an attacker can read the token from the page, so always sanitize user input.


## CORS 

Implementing a CORS policy incorrectly can bypass the browser's Same-Origin Policy (SOP), effectively opening a back door to your data.

1. Never Use Wildcard Origins ('*') in Production

2. Validate Origin Headers Dynamically (If Needed)

3. Restrict Resources by Path

4. Be Cautious with credentials: true

This setting allows the browser to send cookies, CSRF tokens, and Authorization headers.

    **Constraint: You cannot use origins '*' if credentials is set to true.**

    **Risk**: If you allow credentials for a broad set of origins, an attacker could perform actions on behalf of a logged-in user (similar to CSRF).

5. Limit Allowed Methods and Headers

6. Avoid "Reflecting" the Origin Header

A common mistake is writing logic that simply reads the Origin header from the request and sends it back in the Access-Control-Allow-Origin response.

    The Risk: This is functionally identical to using a wildcard *, as it tells the browser that whatever site is currently asking for data is allowed to have it.

    7. Use Short max_age During Development

      The max_age setting tells the browser how long to cache the "Preflight" (OPTIONS) request.

      Production: Set it to something like max_age: 600 (10 minutes) to reduce server load.

      Security: During a security breach or configuration change, a long max_age means browsers will continue to use the old (potentially insecure) policy until the cache expires.

*🛡️ Summary Checklist*

```text
-----------------------------------------------------------
Feature	        | Secure Setting
-----------------------------------------------------------
Origins         | Whitelisted domains only
Resources       | API paths only (/api/*)
Methods         |	Only what is necessary (GET, POST, etc.)
Credentials     |	false (unless using cookies for API auth)
Preflight Cache | Reasonable limit (e.g., 10 mins)
------------------------------------------------------------
```

---------------------------------------