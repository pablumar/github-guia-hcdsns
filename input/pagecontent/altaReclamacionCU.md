<p>Existe otro tipo de alerta que son las reclamaciones. En este caso
este tipo de alerta consiste en la reclamación por parte de un ciudadano
de un acceso a alguno de sus informes por personas no autorizadas, o
bien por personas u organismos de los que no se conocen los motivos para
acceder a dicho informe.</p>
<p>En este caso el alta se genera desde HCDSNS_CA hacia HCDSNS_BE, donde
se implementará la lógica necesaria para el tratamiento de dicha
reclamación o alerta.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un ciudadano necesita notificar una reclamación de acceso a su
historial clínico en el sistema HCDSNS. Esta reclamación se representará
mediante el recurso <strong>Communication,</strong> donde se relaciona
el ciudadano propietario del informe al que ha intentado acceder un
médico<strong>,</strong> y se recibirá un
<strong>OperationOutcome</strong> que confirma que la notificación se ha
procesado correctamente.</p>
<p><strong>Ejemplo:</strong></p>
<p><strong>Solicitud (Notificación de reclamación de
acceso)</strong>:</p>
<p>POST /Communication</p>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
<p><strong>Cuerpo de la Solicitud</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Communication",</p>
<p>"id": "example-communication",</p>
<p>"status": "completed",</p>
<p>"sent": "2024-02-21T10:30:00Z",</p>
<p>"sender": {</p>
<p>"reference": "Practitioner/example-practitioner",</p>
<p>"display": "Médico"</p>
<p>},</p>
<p>"subject": {</p>
<p>"reference": "Patient/example-patient",</p>
<p>"display": "Paciente Ejemplo"</p>
<p>},</p>
<p>"topic": [</p>
<p>{</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://example.com/communication-topics",</p>
<p>"code": "data-error",</p>
<p>"display": “Reclamación de acceso"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>],</p>
<p>"about": [</p>
<p>{</p>
<p>"reference": "DocumentReference/1234232"</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Respuesta esperada</strong>:</p>
<ul>
<li><p><strong>Código de Estado</strong>: 200 OK</p></li>
</ul>
<p><strong>Cuerpo de la Respuesta</strong>:</p>
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
<p>"text": "La notificación de reclamación de acceso se ha procesado
correctamente."</p>
<p>}</p>
<p>]</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Explicación del Resultado:</strong></p>
<p>El sistema responde con un <strong>OperationOutcome</strong> que
confirma que la notificación de reclamación de acceso al historial
clínico del paciente <strong>SNS12345</strong> se ha procesado
correctamente. La cabecera de la respuesta es 200 OK, lo que indica que
la solicitud fue aceptada y procesada exitosamente.</p>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: Fallo en la validación de los datos de la
notificación.</p>
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
<p>"text": "El recurso Flag no pudo ser procesado debido a un error en
la validación de los datos."</p>
<p>}</p>
<p>]</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
