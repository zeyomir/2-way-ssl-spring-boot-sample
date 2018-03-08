# 2-way-ssl-spring-boot-sample
Simple Spring Boot app, that shows how to set up mutual (2 way) ssl authorization between server and client.  
It's just a single endpoint that responds with 'Hello, ${your name}', and is only accessible if client provides known certificate.

## Certificates
For testing, you will be fine using provided certificates. However if you want to create your own- here is how I did it:

```bash
cd src/main/resources/ssl
mkdir server client
cd client
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
# provide some details about client

cd ../server
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem -passout pass:2_way_ssl_key_pass
# provide some details about server
openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
# it will ask you for a password, it's just a temporary stage, in my case it was '2_way_ssl_export_pass'
keytool -importkeystore -srckeystore certificate.p12  -srcstoretype pkcs12 -destkeystore server_keystore.jks -deststoretype jks -deststorepass 2_way_ssl_store_pass
# it will ask you for the password to certificate.p12, again in my case it was '2_way_ssl_export_pass'
keytool -import -file ../client/certificate.pem  -keystore server_truststore.jks
# when you run this for the first time, it will create the server_truststore.jks file and ask for a password- in my case it was '2_way_ssl_truststore_pass'
# then it will show you client certificate you are about to import and ask if you trust it, type 'yes'
```

## Testing it
We will use [Postman](https://www.getpostman.com) for issuing requests. 
1. Start the server. 
1. Start Postman.
1. Enter `https://localhost:8443/greeting?name=John` as url. Send request, it will fail.
1. Open Settings -> Certificates -> add new, enter `localhost:8443` as url, point it to `key.pem` and `certificate.pem` files from `ssl/client` directory, leave `pass` empty.
1. Issue request again, you should get the response.    
