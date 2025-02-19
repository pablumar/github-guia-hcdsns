<p>En el momento de la creación del primero informe de un ciudadano, la
Comunidad deberá enviar una notificación de registro de referencia
indicando en la misma fecha, la fecha de creación del primer documento
clínico y si contiene documentos ocultos. Solamente deberá enviar
referencias en este caso, cuando se genere el primer documento clínico
intercambiable.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un profesional sanitario atiende a un paciente en una Comunidad
Autónoma (CA) que no tiene una historia clínica registrada para dicho
paciente. Esto desencadena el envío de un registro de referencia desde
la CA donde se realizó la atención. Dicha solicitud se realiza con un
recurso <strong>DocumentReference</strong> mediante un método
<strong>POST</strong>. Se enviará el código de agente o comunidad que
identifica dónde se ubica la historia clínica del paciente.</p>
<p>Para una baja de referencia, se utilizará el mismo método, pero
indicando la operación de Baja en el parámetro correspondiente.</p>
<p><strong>Ejemplo:</strong></p>
<p>POST /DocumentReference</p>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
<ul>
<li><p><strong>Cuerpo de la Solicitud</strong>:</p></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><blockquote>
<p>{</p>
<p>"resourceType": "DocumentReference",</p>
<p>"status": "current",</p>
<p>"extension": [</p>
</blockquote>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-flag-oculto",</p>
<p>"valueString": "0"</p>
<p>},</p>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-operacion",</p>
<p>"valueString": "A"</p>
<p>}</p>
<p>],</p>
<p>"subject": {</p>
<p>"reference": "[base]/fhir/Patient/BBBBBBBBBB009933",</p>
<p>"identifier": [</p>
<p>{</p>
<p>"system": "2.16.724.4.40",</p>
<p>"value": "BBBBBBBBBB009933"</p>
<p>},</p>
<p>{</p>
<p>"system": "2.16.724.4.41",</p>
<p>"value": "XXXXXXX"</p>
<p>}</p>
<p>]</p>
<p>},</p>
<p>"date": "2005-12-24T09:43:41+11:00",</p>
<p>"custodian": {</p>
<p>"reference": "[base]/fhir/Organization/20160201",</p>
<p>"identifier": [</p>
<p>{</p>
<p>"value": "20160201"</p>
<p>}</p>
<p>],</p>
<p>“display” : “EXTREMADURA”</p>
<p>},</p>
<p>"description": "Alta Referencia HC"</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p>{</p>
<p>"resourceType": "OperationOutcome",</p>
<p>"issue": [</p>
<p>{</p>
<p>"severity": "error",</p>
<p>"code": "not-found",</p>
<p>"diagnostics": "Ciudadano no encontrado"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<blockquote>
<p><strong>Baja de Referencia</strong></p>
</blockquote>
<p>POST /DocumentReference</p>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
<ul>
<li><p><strong>Cuerpo de la Solicitud</strong>:</p></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><blockquote>
<p>{</p>
<p>"resourceType": "DocumentReference",</p>
<p>"status": "current",</p>
<p>"extension": [</p>
</blockquote>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-flag-oculto",</p>
<p>"valueString": "0"</p>
<p>},</p>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-operacion",</p>
<p>"valueString": "B"</p>
<p>}</p>
<p>],</p>
<p>"subject": {</p>
<p>"reference": "[base]/fhir/Patient/BBBBBXXXXX",</p>
<p>"identifier": [</p>
<p>{</p>
<p>"system": "2.16.724.4.40",</p>
<p>"value": "BBBBBXXXXX"</p>
<p>},</p>
<p>{</p>
<p>"system": "2.16.724.4.41",</p>
<p>"value": "XXXXXXX"</p>
<p>}</p>
<p>]</p>
<p>},</p>
<p>"date": "2005-12-24T09:43:41+11:00",</p>
<p>"custodian": {</p>
<p>"reference": "[base]/fhir/Organization/20160201",</p>
<p>"identifier": [</p>
<p>{</p>
<p>"value": "20160201"</p>
<p>}</p>
<p>],</p>
<p>“display” : “EXTREMADURA”</p>
<p>},</p>
<p>"description": "Baja Referencia HC"</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<ul>
<li><p><strong>Respuesta esperada (Baja)</strong>:</p>
<ul>
<li><p><strong>Código de Estado</strong>: 200 OK</p></li>
<li><p><strong>OperationOutcome</strong>:</p></li>
</ul></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "OperationOutcome",</p>
<p>"issue": [</p>
<p>{</p>
<p>"severity": "information",</p>
<p>"code": "informational",</p>
<p>"details": {</p>
<p>"text": "Baja de referencia de historia clínica para el paciente con
CIP SNS BBBBBXXXXX realizada correctamente."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<blockquote>
<p><strong>Explicación del Resultado:</strong></p>
</blockquote>
<ul>
<li><p><strong>Alta de Referencia</strong>: La CA envía un
<strong>DocumentReference</strong> para dar de alta una referencia de
historia clínica para el paciente <strong>BBBBBXXXXX</strong> en una
comunidad que no tiene su historia clínica registrada. En el cuerpo de
la solicitud, se incluye el código de la CA donde se encuentra la
historia clínica.</p></li>
<li><p><strong>Baja de Referencia</strong>: Si se realiza una baja, se
utiliza el mismo método anterior, POST, pero en la extensión OPERACIÓN
se indica B, baja de referencia.</p></li>
</ul>
<blockquote>
<p><strong>Error:</strong></p>
</blockquote>
<ul>
<li><p><strong>Error en Alta</strong>: Problemas de validación de datos
en la solicitud de alta.</p>
<ul>
<li><p><strong>Respuesta del Servidor</strong>:</p></li>
</ul></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "OperationOutcome",</p>
<p>"issue": [</p>
<p>{</p>
<p>"severity": "error",</p>
<p>"code": "invalid",</p>
<p>"details": {</p>
<p>"text": "El código de agente/comunidad no es válido o el recurso
DocumentReference no pudo procesarse correctamente."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<ul>
<li><p><strong>Error en Baja</strong>: Referencia no encontrada en la
baja.</p>
<ul>
<li><p><strong>Respuesta del Servidor</strong>:</p></li>
</ul></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "OperationOutcome",</p>
<p>"issue": [</p>
<p>{</p>
<p>"severity": "error",</p>
<p>"code": "not-found",</p>
<p>"details": {</p>
<p>"text": "No se encontró la referencia de historia clínica para el
paciente con ID SNS12345 en la organización CA123."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
