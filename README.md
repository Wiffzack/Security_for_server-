# Security_for_server-

Nginx CORS configuration:
[HTTP Public Key Pinning (HPKP)](https://developer.mozilla.org/de/docs/Web/Security/Public_Key_Pinning)
```
openssl rsa -in your-key-file.key -outform der -pubout | openssl dgst -sha256 -binary | openssl enc -base64
openssl req -in my-signing-request.csr -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
openssl x509 -in my-certificate.crt -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```
