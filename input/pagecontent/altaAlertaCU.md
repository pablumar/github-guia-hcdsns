<p>Este servicio permite al ciudadano generar una alerta manual, o bien,
generar una alerta automática en caso de un error interno de la propia
mensajería, utilizando el recurso <strong>Flag</strong> de FHIR.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un ciudadano detecta una incidencia en la aplicación y quiere
notificar dicha incidencia. Esta alerta se representará mediante el
recurso <strong>Flag</strong>, que permite notificar al nodo central de
HCDSNS dicha incidencia.</p>
<p><strong>Ejemplo:</strong></p>
<p><strong>Solicitud (Alta de alerta)</strong>:</p>
<p>POST /Flag</p>
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
<p>"resourceType": "Flag",</p>
<p>"status": "active",</p>
<p>"category": [</p>
<p>{</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://terminology.hl7.org/CodeSystem/flag-category",</p>
<p>"code": "safety",</p>
<p>"display": "Safety"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>],</p>
<p>"code": {</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://example.org/alert-codes",</p>
<p>"code": "ALERT123",</p>
<p>"display": "Alerta por incidencia en la aplicación"</p>
<p>}</p>
<p>]</p>
<p>},</p>
<p>"subject": {</p>
<p>"reference": "Patient/SNS12345",</p>
<p>"display": "Juan Pérez"</p>
<p>}</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Respuesta esperada:</strong></p>
<p><strong>Código de Estado</strong>: 201 Created</p>
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
<p>"text": "Alerta creada correctamente."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Explicación del Resultado:</strong></p>
<p>El sistema responde con un recurso <strong>Flag</strong> creado
exitosamente que representa la alerta creada por el ciudadano con
identificador <strong>SNS12345</strong>. Esta alerta estará visible y
activa en el sistema.</p>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: Fallo en la validación de los datos de la
alerta.</p>
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
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
