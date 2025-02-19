<p>Este servicio permite solicitar y gestionar operaciones de
visibilidad sobre los datos clínicos de un paciente en el sistema
HCDSNS.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un ciudadano necesita realizar una solicitud de operación de
visibilidad sobre su historia clínica, y recibir una <table border="1">
confirmatoria del sistema. El recurso <strong>Communication,</strong>
donde se indica el ciudadano y el informe que desea marcar como
oculto<strong>,</strong> se utilizará para representar la solicitud, y
un <strong>OperationOutcome</strong> se recibirá como <table border="1">.</p>
<ul>
<li><p><strong>Ejemplo:</strong></p></li>
</ul>
<p><strong>Solicitud (Operación de visibilidad)</strong>:</p>
<p>POST /Communication</p>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
<ul>
<li><p><strong>Cuerpo de la Solicitud</strong>:</p></li>
</ul>
<table>
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
<p>"display": "Errores en los datos del informe"</p>
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
<p><strong><table border="1"> esperada</strong>:</p>
<ul>
<li><p><strong>Código de Estado</strong>: 200 OK</p></li>
<li><p><strong>Cuerpo de la <table border="1"></strong>:</p></li>
</ul>
<table>
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
<p>"text": "La solicitud de operación de visibilidad se ha procesado
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
