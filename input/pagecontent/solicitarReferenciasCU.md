<p><strong>Descripción del Escenario:</strong></p>
<p>Una CA, a través de HCDSNS_CA, solicita a HCDSNS_BE un listado de
referencias de HC de un paciente. HCDSNS_BE devuelve un
<strong>Bundle</strong> de recursos <strong>Organization</strong>, donde
cada organización representa una CA que custodia datos del paciente. En
el campo <strong>type</strong> de cada <strong>Organization</strong> se
indicará si esa comunidad autónoma tiene capacidad para trabajar con
FHIR. Además, también retornará el flag de informe oculto.</p>
<p><strong>Ejemplo:</strong></p>
<p>GET
/Organization?_has:DocumentReference:custodian:patient=2.16.724.4.40|BBBBBBBBBB009933</p>
<p>Authorization: Bearer {token}</p>
<p>Content-Type: application/fhir+json</p>
<p><strong>Respuesta esperada</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Bundle",</p>
<p>"type": "searchset",</p>
<p>"total": 2,</p>
<p>"entry": [</p>
<p>{</p>
<p>"resource": {</p>
<p>"resourceType": "Organization",</p>
<blockquote>
<p>"extension": [</p>
</blockquote>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-flag-oculto",</p>
<p>"valueString": "0"</p>
<p>}</p>
<p>]</p>
<p>"id": "CA123",</p>
<p>"name": "Cataluña",</p>
<p>"type": [</p>
<p>{</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://hl7.org/fhir/organization-type",</p>
<p>"code": "FHIR",</p>
<p>"display": "FHIR Capable"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>},</p>
<p>{</p>
<p>"resource": {</p>
<p>"resourceType": "Organization",</p>
<blockquote>
<p>"extension": [</p>
</blockquote>
<p>{</p>
<p>"url":
"http://hl7.org/fhir/StructureDefinition/patient-flag-oculto",</p>
<p>"valueString": "0"</p>
<p>},</p>
<p>"id": "CA456",</p>
<p>"name": "Valencia",</p>
<p>"type": [</p>
<p>{</p>
<p>"coding": [</p>
<p>{</p>
<p>"system": "http://hl7.org/fhir/organization-type",</p>
<p>"code": "Legacy",</p>
<p>"display": "Non-FHIR Capable"</p>
<p>}</p>
<p>]</p>
<p>}</p>
<p>]</p>
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
<p>El Backend del SNS devuelve un <strong>Bundle</strong> que contiene
las organizaciones custodias de la historia clínica del paciente con ID
<strong>SNS12345</strong>. Cada entrada en el <strong>Bundle</strong> es
un recurso <strong>Organization</strong> con información relevante como
el nombre de la CA y si esta tiene capacidad FHIR (indicada en el campo
<strong>type</strong>). Esto permite a la CA solicitante identificar las
comunidades donde se encuentra la historia clínica del paciente y sus
capacidades tecnológicas.</p>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: El paciente no tiene historial registrado
en ninguna organización custodia.</p>
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
<th><blockquote>
<p>{</p>
<p>"resourceType": "OperationOutcome",</p>
<p>"issue": [</p>
<p>{</p>
<p>"severity": "error",</p>
<p>"code": "not-found",</p>
<p>"details": {</p>
<p>"text": "No se encontraron organizaciones custodias para el paciente
con ID SNS12345."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Respuesta del Servidor:</strong></p>
<ul>
<li><p><strong>Código de estado</strong>:</p>
<ul>
<li><p>200 OK: Respuesta exitosa con el listado de
organizaciones.</p></li>
<li><p>404 Not Found: No se encontraron organizaciones para el paciente
solicitado.</p></li>
</ul></li>
</ul>
