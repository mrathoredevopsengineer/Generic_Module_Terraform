Private key generate करना

**openssl genrsa -out private.key 2048**


CSR (Certificate Signing Request) generate करना

**openssl req -new -key private.key -out request.csr**


Self-signed certificate generate करना (365 days valid)

**openssl req -new -x509 -key private.key -out certificate.crt -days 365**


Private key और certificate को PFX में export करना

**openssl pkcs12 -export -out mycert.pfx -inkey private.key -in certificate.crt**


Private key और certificate का modulus verify करना (match होना चाहिए)

**openssl rsa -noout -modulus -in private.key | openssl md5**


**openssl x509 -noout -modulus -in certificate.crt | openssl md5**
