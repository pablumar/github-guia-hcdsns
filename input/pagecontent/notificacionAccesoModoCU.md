<p>Este recurso permite notificar y confirmar el acceso a los datos
clínicos de un paciente en modo emergencia en el sistema HCDSNS por
parte de un profesional. Se utiliza un recurso <strong>Flag</strong> que
contiene los datos necesarios para registrar este modo de acceso del
profesional sanitario que previamente debe haber indicado el motivo y
aceptado las condiciones.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un profesional sanitario notifica el acceso en modo de emergencia a
la historia clínica de un paciente. La solicitud se representará
mediante un recurso <strong>Flag</strong> y la respuesta confirmatoria
se recibirá como un <strong>OperationOutcome</strong>.</p>
<ul>
<li><p><strong>Ejemplo:</strong></p></li>
</ul>
<p><strong>Solicitud (Acceso en modo emergencia)</strong>:</p>
<p>POST /Flag</p>
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
<p>"system": "http://example.org/flag-codes",</p>
<p>"code": "EMERGENCY_ACCESS",</p>
<p>"display": "Acceso en modo emergencia"</p>
<p>}</p>
<p>]</p>
<p>},</p>
<p>"subject": {</p>
<p>"reference": "Patient/SNS12345",</p>
<p>"display": "Juan Pérez"</p>
<p>},</p>
<p>"author": {</p>
<p>"reference": "Practitioner/321",</p>
<p>"display": "Dra. González"</p>
<p>}</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Respuesta esperada</strong>:</p>
<ul>
<li><p><strong>Código de Estado</strong>: 200 OK</p></li>
<li><p><strong>Cuerpo de la Respuesta</strong>:</p></li>
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
<p>"text": "La notificación de acceso en modo emergencia se ha procesado
correctamente."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
