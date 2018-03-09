#!/usr/bin/fish

rm -rf server client
mkdir server client
cd client
echo ""
echo "    PROVIDE DETAILS ABOUT CLIENT"
echo ""
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem

cd ../server
echo ""
echo "    PROVIDE DETAILS ABOUT SERVER"
echo ""
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem -passout pass:aaaaaa

echo ""
echo "    PROVIDE TEMP PASS (aaaaaa)"
echo ""
openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
echo ""
echo "    PROVIDE TEMP PASS (aaaaaa)"
echo ""
keytool -importkeystore -srckeystore certificate.p12  -srcstoretype pkcs12 -destkeystore server_keystore.jks -deststoretype jks -deststorepass aaaaaa
echo ""
echo "    PROVIDE TRUST STORE PASS (aaaaaa) and then type 'yes'"
echo ""
keytool -import -file ../client/certificate.pem  -keystore server_truststore.jks

