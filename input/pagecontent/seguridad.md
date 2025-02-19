<p>Un JSON Web Token es un <em>token</em> de acceso estandarizado en
el <a href="https://tools.ietf.org/html/rfc7519">RFC 7519</a> que
permite el intercambio seguro de datos entre dos partes.
Contiene <strong>toda la información importante</strong> sobre una
entidad, lo que implica que no hace falta consultar una base de datos ni
que la sesión tenga que guardarse en el servidor (sesión sin
estado).</p>
<p>Por este motivo, los JWT son especialmente populares en los procesos
de autentificación. Con este estándar es posible cifrar mensajes cortos,
dotarlos de información sobre el remitente y demostrar si este cuenta
con los <strong>derechos de acceso requeridos</strong>. Los propios
usuarios solo entran en contacto con el <em>token</em> de manera
indirecta: por ejemplo, al introducir el nombre de usuario y la
contraseña en una interfaz. La comunicación como tal entre las
diferentes aplicaciones se lleva a cabo en el lado del cliente y del
servidor.</p>
<p>Un JWT firmado consta de tres partes, todas ellas codificadas en
Base64 y separadas por un punto:</p>
<p>HEADER.PAYLOAD.SIGNATURE</p>
<ul>
<li><p>Encabezado (HEADER): Consta <strong>generalmente de dos
valores</strong> y proporciona información importante sobre
el <em>token</em>. Contiene el tipo de <em>token</em> y el algoritmo de
la firma y/o cifrado utilizados. Este podría ser un ejemplo
de <em>header</em> de un JWT:</p></li>
</ul>
<blockquote>
<p>Siempre se recomienda introducir <em>JWT</em> como tipo, que hace
referencia al tipo de medio <em>application/jwt</em> de la <a
href="https://www.ionos.es/digitalguide/servidores/know-how/iana-que-es-y-cual-es-su-funcion/">IANA</a>.
En el ejemplo anterior, el <em>header</em> indica que HMAC-SHA256,
abreviado como <em>HS256</em>, se utiliza para firmar el <em>token</em>.
Otros <strong>métodos de cifrado típicos</strong> son RSA, con SHA-256
(<em>RS256</em>), y ECDSA, con SHA-256 (<em>ES256</em>). No se
recomienda prescindir del cifrado, aunque sí se puede
especificar <em>none</em> si los datos no requieren un nivel de
protección alto. Los posibles valores están estandarizados por
JSON-Web-Encryption según el <a
href="https://tools.ietf.org/html/rfc7516">RFC 7516</a>.</p>
<p>En el caso de los JSON Web Tokens complejos firmados o cifrados,
también existe el parámetro <em>cty </em>para <em>content type</em>, que
se rellena del mismo modo, con el valor <em>JWT</em>. En el resto de los
casos, este parámetro se omite.</p>
</blockquote>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">{<br />
"alg": "HS256",<br />
"typ": "JWT"<br />
}</th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<ul>
<li><p>Carga útil (PAYLOAD): El campo payload de JSON Web Token contiene
la información real que se transmitirá a la aplicación.</p></li>
</ul>
<blockquote>
<p>Aquí se definen algunos estándares que determinan qué datos se
transmiten y cómo. La información se proporciona como
pares <em>key/value</em> (<em>clave-valor</em>); las claves se
denominan <em><strong>claims</strong></em> en JWT. Hay tres tipos
diferentes de <em>claims</em>:</p>
</blockquote>
<ul>
<li><p>Los <strong><em>claims</em> registrados </strong>son los
que<strong> </strong>figuran en el <a
href="https://www.iana.org/assignments/jwt/jwt.xhtml">IANA JSON Web
Token Claim Register</a> y cuyo propósito se establece en un estándar.
Algunos ejemplos son el emisor del <em>token</em> (<em>iss</em>,
de <em>issuer</em>), el dominio de destino (<em>aud</em>,
de <em>audience</em>) y el tiempo de vencimiento (<em>exp</em>,
de <em>expiration time</em>). Se utilizan nombres
de <em>claim</em> cortos para abreviar el <em>token</em> lo máximo
posible.</p></li>
<li><p>Los <strong><em>claims</em> públicos</strong> pueden definirse a
voluntad, ya que no están sujetos a restricciones. Para que no se
produzcan conflictos en la semántica de las claves, es necesario
registrar los <em>claims</em> públicamente en el JSON Web Token Claim
Register de la IANA o asignarles nombres que no puedan
coincidir.</p></li>
<li><p>Los <strong><em>claims</em> privados </strong>están destinados a
los datos que intercambiamos especialmente con nuestras propias
aplicaciones. Si bien los <em>claims</em> públicos contienen información
como <em>nombre</em> o <em>correo electrónico</em>,
los <strong><em>claims</em> privados son más concretos</strong>. Por
ejemplo, suelen incluir datos como <em>identificación de
usuario</em> o <em>nombre de departamento</em>. Al nombrarlos, es
importante asegurarse de que no vayan a entrar en conflicto con
ningún <em>claim</em> registrado o público.</p></li>
</ul>
<blockquote>
<p>Todos los claims son opcionales, por lo que no es obligatorio
utilizar todos los claims registrados. En general, el payload puede
contener un número ilimitado de claims, aunque es aconsejable limitar la
información del JWT al mínimo. Cuanto más extenso sea el JWT, más
recursos necesitará para la codificación y la descodificación.</p>
<p>En nuestro caso se incluirá el claim con la aserción SAML.</p>
<p>Un payload podría estructurarse, por lo tanto, de la siguiente
manera:</p>
</blockquote>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><p>{<br />
"id": "1234567890",<br />
"name": "John Doe",<br />
"admin": true,</p>
<p>“claim”: “&lt;&lt;Aserción SAML&gt;&gt;”,</p>
<p>“exp”:1721259379</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<ul>
<li><p>Firma (SIGNATURE): La firma toma la codificación Base64Url del
encabezado y la carga útil, y luego las firma utilizando un secreto (con
HMAC) o una clave privada (con algoritmos de firma como RSA). Ejemplo
(con HMAC SHA256):</p></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">HMACSHA256(<br />
base64UrlEncode(header) + "." +<br />
base64UrlEncode(payload),<br />
secret<br />
)</th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p>Un ejemplo concreto sería el siguiente, donde se envía dentro de una
cabecera Authorization codificado en base 64.</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"Content-Type": "application/json",</p>
<p>"Authorization": "Bearer &lt;&lt;Token JWT&gt;&gt;",</p>
<p>"Custom-Field": "ONCE UPON A TIME",</p>
<p>“CountryCode”: “Codigo Pais” 🡪 Rol B</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p>Una vez decodificado el token se puede revisar el contenido:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th
style="text-align: left;">{"typ":"JWT","alg":"HS512"}.{"sub":"user","saml":"&lt;&lt;Asercion
SAML&gt;&gt;”,“exp”: 1721259379.Firma</th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p>Y un ejemplo de Aserción SAML:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>&lt;?xml version="1.0" encoding="UTF-8"?&gt;</p>
<p>&lt;saml2:Assertion
xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion"
xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"
xmlns:wsa="http://www.w3.org/2005/08/addressing"
xmlns:wsse="http://docs.oasis-
open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
ID="_616271df-b05f-4df0-87bb- 2aaaf2988158"
IssueInstant="2023-06-16T09:10:49.091Z" Version="2.0"&gt;</p>
<p>&lt;saml2:Issuer NameQualifier="urn:ehdsi:assertions:hcp"&gt;
urn:idp:EU:countryB&lt;/saml2:Issuer&gt;</p>
<p>&lt;ds:Signature
xmlns:ds="http://www.w3.org/2000/09/xmldsig#"&gt;</p>
<p>&lt;ds:SignedInfo&gt;</p>
<p>&lt;ds:CanonicalizationMethod
Algorithm="http://www.w3.org/2001/10/xml-exc- c14n#" /&gt;</p>
<p>&lt;ds:SignatureMethod
Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa- sha256" /&gt;</p>
<p>&lt;ds:Reference URI="#_616271df-b05f-4df0-87bb-2aaaf2988158"&gt;</p>
<p>&lt;ds:Transforms&gt;</p>
<p>&lt;ds:Transform
Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"
/&gt;</p>
<p>&lt;ds:Transform
Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"&gt;</p>
<p>&lt;ec:InclusiveNamespaces
xmlns:ec="http://www.w3.org/2001/10/xml-exc-c14n#" PrefixList="xsd"
/&gt;</p>
<p>&lt;/ds:Transform&gt;</p>
<p>&lt;/ds:Transforms&gt;</p>
<p>&lt;ds:DigestMethod
Algorithm="http://www.w3.org/2001/04/xmlenc#sha256" /&gt;</p>
<p>&lt;ds:DigestValue&gt;</p>
<p>qZo3cvMYDjCV9GCqdnMJuYYbgIGGEr9PIUBPAuikhmA=&lt;/ds:DigestValue&gt;</p>
<p>&lt;/ds:Reference&gt;</p>
<p>&lt;/ds:SignedInfo&gt;</p>
<p>&lt;ds:SignatureValue&gt;ZpPrGAX45ORddQzhUgC2JyCSNcoS5xNSTG0sC5zbsc/Ki1oywTZJvh+4PD1OEqMHRQ6
YTkbnKJfc</p>
<p>ZfXnGp+O/0M8ZxOJ9t0mlGslK1dVNwcnNRiu7qT6+X0C8irB3+7oeOexklZMMEKCoHUqlOg0gxBC
zdibw/OvD8vcYGuq9whBkwcOa+VJmVGLumZLcNlQuOVzj8AweS0SM43A8YmKFR66Q9Ro3lHYlOqa
y40D2iiJ6eaHygauMnilbZZgi3EgGOzhKgWlHBeuSjkhfr14wIjqcnglk9MVHhsi52djnfX4Qyre
0sAfrlSOVhWunjNbSJPowqYfeMbd8TSiZ9/IJPjc0IxgjCqlLZIvMJM/Gd2lO4s4F69+8IQjfTii
nHwMasp0om2BjrGUJ06KHR2qUwqQYxNg3N/pHQw5UDsPnGKjAJSPaMiS2MOkfQjzM/EvOBU1rHvG
rNs99udLnrpOVmwza5/jfCFXLxkQlQ+J0wXI/IKsq7MWZhlsPuvfOZXZGKWNfHXiS6E1P7aFAg/r</p>
<p>/b24M6R56l9D4R1rUNgIkw0sCDGi5AH2mZyvBJ+zcqeczRZTdOyusWk6sJnDq3hKSU9loKIljLFU
dGT29iM4xah10aMXPPyio+OjJeyod2ePC65wTpcjtX6J2SLnpI5+u4n9KyMZhIJLOscabyWGo+A=&lt;/ds:Signa
tureValue&gt;</p>
<p>&lt;ds:KeyInfo&gt;</p>
<p>&lt;ds:X509Data&gt;</p>
<p>&lt;ds:X509Certificate&gt;MIIELTCCAxWgAwIBAgIBHTANBgkqhkiG9w0BAQ0FADBRMQswCQYDVQQGEwJCRTEcMB
oGA1UECgwTRXVyb3BlYW4gQ29tbWlzc2lvbjERMA8GA1UEAwwIRUhEU0kgQ0ExETAPBgNVBAsMCERHIFNhbnRl
MB4XDTIzMDQxMTEyNTIyN1oXDTMzMDQxMTEyNTIyN1owYzELMAkGA1UEBhMCQkUxHDAaBgNVBAoME0V1cm9wZW
FuIENvbW1pc3Npb24xIjAgBgNVBAMMGUdSUDpFSEVBTFRIX05DUF9ERVZfRVVfMDExEjAQBgNVBAsMCURHIFNh</p>
<p>bnTDqTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALibbrjRSP5pELWJA/9r6gq/7pyIarG65uwkAS
vMJpg4J8VfwLMMBVkGbsOIGXuWzycPOTXYZOFNtuhVhgT/lSlLJHKFmhKRTJMfjtGSFamiPs07eLbSdsnt96tE
XvOfpZ2ritRdBBJOQp9XRl4OrqxVdszLUUpTykV+oMtZCneyWBH1JC50SZfa/Owud6DGKb10s1aPYjlyq8CasP
h+b0yuT4GjlSgoXRNdjqSqaC9b0d0GhXfDo1Ren1tBNyahLjLwIOwU9XkEyVyRniNLYpnjbK293lnEmNGPt4FH
DnM2RAucDTGusrl1Dex3s0jer0FT/P1i+t4QJorOL9GLa2YwQ0WW0i4JPnHwaDNUeV6chP1CyQ0OY5tVMNizn8
9f5kx4pc6qv0saMbgkgXudFzAwuvqD/vkr+D3LRIMNLZEyCu7uRrlzQcBqcKD559b1kf8gn7o5vMghfsrj2Q+n
dpRcHo1S1qL6hAan/C42gnuVGU8jLyvh0oC9rw/gug11dIKZbs5N/hiQe+1/ewLlief7HKHDvaPnh5iYFxYFzw
uNdIottTkoI4mWnFanAHFE4M8ge9mDCcHgBXG5Hy380CSXGs2MRd/FYKorC2Ouk6HrZLS8WJV3ooGbTHRtPIa6
HGLaquD7Lqd7Sel4S2SXlZCSDgkmVGX+9Yxr/hUQD/h/AgMBAAEwDQYJKoZIhvcNAQENBQADggEBAIdpov68VD
sb0JFBr9jgdFIzyiSnle4GaVFGRDL2WxvvB4aX50wfAjun1EPxuHN4ixgbP89/RJI2k/wrydsXJYNt/r4f20ag</p>
<p>/E/C6AhsNE/wj1TgbIm4iSyD7oyo5SLq76ABjf2flRVZOCPbsCv1wYYu1hARcixNgM/648KJGB8oSMFBhNebkO
VvU25TSAjaoKNnQJAB0ssq4HirmVWEuItPevhnDsZHS817eikqNa/m885kXRwqkZRdk372kuE7JTu28xakIZDe
LCAI0ndbIuA2qjOSIqP6pI5x15UrLgM09+1fIVMhMzatt2MiW5yPKejpXerZIdKkNVzmMAXdjEw=&lt;/ds:X509Certificate&gt;</p>
<p>&lt;/ds:X509Data&gt;</p>
<p>&lt;/ds:KeyInfo&gt;</p>
<p>&lt;/ds:Signature&gt;</p>
<p>&lt;saml2:Subject&gt;</p>
<p>&lt;saml2:NameID
Format="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"</p>
<p>&gt;house@ehdsi.eu&lt;/saml2:NameID&gt;</p>
<p>&lt;saml2:SubjectConfirmation
Method="urn:oasis:names:tc:SAML:2.0:cm:sender- vouches" /&gt;</p>
<p>&lt;/saml2:Subject&gt;</p>
<p>&lt;saml2:Conditions NotBefore="2023-06-16T09:10:49.091Z"
NotOnOrAfter="2023-06-</p>
<p>16T13:10:49.091Z"&gt;</p>
<p>&lt;saml2:AudienceRestriction&gt;</p>
<p>&lt;saml2:Audience&gt;urn:ehdsi:assertions.audience:x-border&lt;/saml2:Audience&gt;</p>
<p>&lt;/saml2:AudienceRestriction&gt;</p>
<p>&lt;/saml2:Conditions&gt;</p>
<p>&lt;saml2:AuthnStatement
AuthnInstant="2023-06-16T09:10:49.091Z"&gt;</p>
<p>&lt;saml2:AuthnContext&gt;</p>
<p>&lt;saml2:AuthnContextClassRef&gt;urn:oasis:names:tc:SAML:2.0:ac:classes:SmartcardPKI&lt;/saml2</p>
<p>:AuthnContextClassRef&gt;</p>
<p>&lt;/saml2:AuthnContext&gt;</p>
<p>&lt;/saml2:AuthnStatement&gt;</p>
<p>&lt;saml2:AttributeStatement&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="HCI Identifier"
Name="urn:ihe:iti:xca:2010:homeCommunityId"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oid:2.16.17.710.850.1000.990.1&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="NPI Identifier"
Name="urn:oasis:names:tc:xspa:1.0:subject:npi"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;European
Commission&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Subject"
Name="urn:oasis:names:tc:xspa:1.0:subject:subject-id"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;John House&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Role"
Name="urn:oasis:names:tc:xacml:2.0:subject:role"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue&gt;</p>
<p>&lt;Role xmlns="urn:hl7-org:v3" code="221"
codeSystem="2.16.840.1.113883.2.9.6.2.7" codeSystemName="ISCO"
displayName="Medical doctors" /&gt;</p>
<p>&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Organization"
Name="urn:oasis:names:tc:xspa:1.0:subject:organization"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;eHealth OpenNCP EU
Portal&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Organization ID"
Name="urn:oasis:names:tc:xspa:1.0:subject:organization-id"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:hl7ii:1.2.3.4:ABCD&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="eHealth DSI Healthcare Facility
Type" Name="urn:epsos:names:wp3.4:subject:healthcare-facility-type"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;Resident
Physician&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Purpose Of Use"
Name="urn:oasis:names:tc:xspa:1.0:subject:purposeofuse"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue&gt;</p>
<p>&lt;PurposeOfUse xmlns="urn:hl7-org:v3" code="TREATMENT"
codeSystem="3bc18518-d305-46c2-a8d6-94bd59856e9e" codeSystemName="eHDSI
XSPA PurposeOfUse" displayName="TREATMENT" /&gt;</p>
<p>&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="XSPA Locality"
Name="urn:oasis:names:tc:xspa:1.0:environment:locality"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;eHDSI EU Testing MedCare
Center&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;saml2:Attribute FriendlyName="Hl7 Permissions"
Name="urn:oasis:names:tc:xspa:1.0:subject:hl7:permission"
NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
003&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
004&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
005&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
006&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
010&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PRD-
016&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PPD-
032&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PPD-
033&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;saml2:AttributeValue
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="xsd:string"&gt;urn:oasis:names:tc:xspa:1.0:subject:hl7:permission:PPD-046&lt;/saml2:AttributeValue&gt;</p>
<p>&lt;/saml2:Attribute&gt;</p>
<p>&lt;/saml2:AttributeStatement&gt;</p>
<p>&lt;/saml2:Assertion&gt;</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
