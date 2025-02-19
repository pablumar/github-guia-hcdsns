<p>Este recurso permite consultar el estado de un <strong>flag
oculto</strong> (es decir, si un documento clínico está marcado como
oculto o no) utilizando el recurso <strong>Flag</strong> de FHIR. A
continuación se describen las operaciones para solicitar y recibir el
estado del <strong>flag oculto</strong> en un documento clínico.</p>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un profesional sanitario solicita información sobre el estado de un
flag oculto en un informe de un paciente. La solicitud se representa con
un recurso <strong>Flag</strong> y la respuesta se confirma con un
<strong>OperationOutcome</strong>.</p>
<ul>
<li><p><strong>Ejemplo:</strong></p></li>
</ul>
<p><strong>Solicitud (Estado de flag oculto)</strong>:</p>
<p>GET /Flag?idInforme=&lt;&lt;IdInforme&gt;&gt;</p>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
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
<th style="text-align: left;"><p>{</p>
<p>"resourceType": "Flag",</p>
<p>"status": "active",</p>
<p>"category": [</p>
<p>{</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://terminology.hl7.org/CodeSystem/flag-category",</p>
<p>"code": "privacy",</p>
<p>"display": "Privacy"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>],</p>
<p>"code": {</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://example.org/flag-codes",</p>
<p>"code": "HIDDEN_FLAG",</p>
<p>"display": "Estado de flag oculto en informe"</p>
<p>}</p>
<p>]</p>
<p>},</p>
<p>"subject": {</p>
<p>"reference": "Patient/SNS12345",</p>
<p>"display": "Juan Pérez"</p>
<p>},</p>
<p>"author": {</p>
<p>"reference": "Practitioner/789",</p>
<p>"display": "Dr. López"</p>
<p>}</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p>En caso de no encontrar el informe la respuesta será la
siguiente:</p>
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
<p>"text": "No se ha recuperado el flag relacionado con el informe
indicado"</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
