# Security_for_server-

Nginx CORS configuration:


# [Content Security Policy](https://wiki.selfhtml.org/wiki/Sicherheit/Content_Security_Policy)
```
openssl dgst -sha256 -binary jquery-3.3.1.min.js | openssl base64 -A
```
Output:
```
FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=
```
In your site:
```
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="crossorigin="anonymous"></script>
```
In your Nginx config:
```
 add_header Content-Security-Policy "script-src 'self' https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/  ";
```

# [HTTP Public Key Pinning (HPKP)](https://developer.mozilla.org/de/docs/Web/Security/Public_Key_Pinning)
```
openssl rsa -in your-key-file.key -outform der -pubout | openssl dgst -sha256 -binary | openssl enc -base64
openssl req -in my-signing-request.csr -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
openssl x509 -in my-certificate.crt -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```
In your Nginx config:
```
add_header Public-Key-Pins 'pin-sha256="from_your_certificate.crt"; pin-sha256="from_your_backup.crt"; max-age=5184000; includeSubDomains';
```
If your configuration work your should be able to make check it with
```
openssl s_client -connect www.example.com:443 | openssl x509 -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```
