# SECURITY Best Practices

    - Avoid GET for State Changes: Never use GET requests for actions that change data, as Rails does not verify tokens for GET requests.
    - Secure Cookies: Rails uses SameSite=Lax cookies by default, which provides an additional layer of browser-level protection against CSRF.
    - Prevent XSS: Cross-Site Scripting (XSS) can bypass CSRF protection by allowing an attacker to read the token from the page. Always sanitize user input