# 2-way-ssl-spring-boot-sample
Simple Spring Boot app, that shows how to set up mutual (2 way) ssl authorization between server and client.  
It's just a single endpoint that responds with 'Hello, ${your name}', and is only accessible if client provides known certificate.

## Certificates
For testing, you will be fine using provided certificates. However if you want to create your own- you can check the script in `src/main/resources/ssl/cert.sh`.

## Testing it
We will use [Postman](https://www.getpostman.com) for issuing requests. 
1. Start the server. 
1. Start Postman.
1. Enter `https://localhost:8443/greeting?name=John` as url. Send request, it will fail.
1. Open Settings -> Certificates -> add new, enter `localhost:8443` as url, point it to `key.pem` and `certificate.pem` files from `ssl/client` directory, leave `pass` empty.
1. Issue request again, you should get the response.

