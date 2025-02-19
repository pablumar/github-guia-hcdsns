<p>Este servicio permite la consulta y recuperación de referencias de
documentos clínicos asociados a la historia clínica de un paciente.
Utilizando el recurso FHIR <strong>DocumentReference</strong> para
almacenar y transmitir metadatos sobre los documentos clínicos, este
recurso permite que las Comunidades Autónomas (CCAA) accedan a las
referencias distribuidas de manera centralizada y organizada.</p>
<p>En un escenario típico, cuando una CCAA requiere las referencias de
la historia clínica de un paciente, envía una solicitud al Backend del
SNS. El Backend recibe esta solicitud y realiza una búsqueda en todas
las CCAA conectadas para identificar aquellas que poseen referencias
relevantes para el paciente solicitado. Cada CCAA con información
correspondiente responde con un <strong>Bundle</strong> de
<strong>DocumentReference</strong>, los cuales son recopilados por el
Backend. Posteriormente, el Backend consolida todos estos
<strong>Bundles</strong> en uno solo y lo envía de vuelta a la CCAA
solicitante, proporcionando al profesional de salud una vista unificada
y completa de las referencias de la historia clínica del paciente.</p>
<p><img src="media/image13.png" style="width:4.88542in;height:2.63542in"
alt="A diagram of a document Description automatically generated" /></p>
<h4
id="hcdsns-ca-solicitud-de-referencias-de-documentos-desde-la-comunidad-autónoma">HCDSNS-CA:
Solicitud de Referencias de Documentos desde la Comunidad Autónoma</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Desde una CA un profesional necesita acceder a las referencias de
documentos clínicos de un paciente, en este caso informes de laboratorio
con código LOINC: 11502-2, y envía una solicitud al HCDSNS-BE para
obtener estos <strong>DocumentReference</strong>. Luego, HCDSNS-CA se
queda en espera de recibir un <strong>Bundle</strong> con todas las
referencias de documentos clínicos del paciente.</p>
<p>Se enviará una petición por cada uno de los servicios de salud
obtenidos en el paso anterior. Si el servicio de salud destino aún no ha
evolucionado a FHIR, el mensaje se enviará utilizando la mensajería
existente SOAP, en caso contrario, se enviará mensajería FHIR.</p>
<p><strong>Ejemplo:</strong></p>
<p>GET
/DocumentReference?patient=2.16.724.4.40|BBBBBBBBBB009933&amp;type=11502-2&amp;custodian=Organization/20160201&amp;x-flag=0</p>
<p>Authorization: [token]</p>
<h4
id="hcdsns-be-consolidación-de-referencias-de-documentos-por-el-backend">HCDSNS-BE:
Consolidación de Referencias de Documentos por el Backend</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>HCDSNS_BE recibe un mensaje de la CA peticionaria y envía un mensaje
a la CA destino para recuperar los documentos clínicos de un paciente,
este mensaje incluye un parámetro específico que indica la CA destino de
donde recuperar las referencias de dichos documentos clínicos del
paciente.</p>
<p>El Backend utiliza este parámetro para enviar la petición
exclusivamente a esa comunidad autónoma y devolver las referencias
obtenidas.</p>
<p><strong>Ejemplo:</strong></p>
<p>GET
/DocumentReference?patient=2.16.724.4.40|BBBBBBBBBB009933&amp;type=11502-2&amp;custodian=Organization/20160201&amp;x-flag=0</p>
<p>Authorization: Bearer {token}</p>
<ul>
<li><p><strong>Pasos del Proceso</strong>:</p>
<ol type="1">
<li><p>La <strong>CA</strong> peticionaria envía una solicitud de
referencias de documentos del paciente BBBBBBBBBB009933 a
HCDSNS-BE.</p></li>
<li><p>HCDSNS-BE envía el correspondiente mensaje a la CA indicada en el
parámetro custodian.</p></li>
<li><p>Dicha <strong>CA</strong> responde enviando un bundle de
<strong>DocumentReference</strong> a HCDSNS-BE.</p></li>
<li><p>HCDSNS-BE recibe dicho bundle y lo envía a la <strong>CA</strong>
peticionaria.</p></li>
</ol></li>
</ul>
<h4
id="hcdsns-ca-respuesta-de-la-ca-con-un-bundle-de-referencias">HCDSNS-CA:
Respuesta de la CA con un Bundle de Referencias</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Una CA destino recibe una solicitud de referencias de historia
clínica de un paciente desde HCDSNS-BE. La CA reúne la información
disponible en su sistema, monta un bundle con las referencias de
documentos clínicos del paciente y lo envía de vuelta a HCDSNS-BE.</p>
<p><strong>Ejemplo:</strong></p>
<ul>
<li><p><strong>Solicitud de HCDSNS-BE a la CA</strong>:</p></li>
</ul>
<p>GET
/DocumentReference?patient=2.16.724.4.40|BBBBBBBBBB009933&amp;type=11502-2&amp;custodian=Organization/20160201&amp;x-flag=0</p>
<p>Authorization: [token]</p>
<p><strong>Respuesta esperada</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Bundle",</p>
<p>"type": "collection",</p>
<p>"entry": [</p>
<p>{</p>
<p>"resource": {</p>
<p>"resourceType": "DocumentReference",</p>
<p>“status”: “current”,</p>
<p>“custodian”: “Organization/20160201”,</p>
<p>"id": "1000000000007",</p>
<p>“date”: “2017-01-01T00:00:00Z”,</p>
<p>"subject": {</p>
<p>"reference": "Patient/BBBBBBBBBB009933",</p>
<p>"display": "Juan Pérez"</p>
<p>},</p>
<p>"content": [</p>
<p>{</p>
<p>"attachment": {</p>
<p>"contentType": "application/pdf",</p>
<p>"url": "/Binary/67890"</p>
<p>},</p>
<p>“format”: “PDF”</p>
<p>},</p>
<p>{</p>
<p>"attachment": {</p>
<p>"contentType": "application/cda",</p>
<p>"url": "/Binary/67891"</p>
<p>},</p>
<p>“format”: “CDA”</p>
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
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: No hay referencias para el paciente
solicitado.</p>
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
<p>"severity": "warning",</p>
<p>"code": "not-found",</p>
<p>"details": {</p>
<p>"text": "No se encontraron referencias de historia clínica para el
paciente con ID SNS12345."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: No se puede encontrar ninguna referencia
para el paciente solicitado en la CA.</p>
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
<p>"severity": "warning",</p>
<p>"code": "not-found",</p>
<p>"details": {</p>
<p>"text": "No se encontraron referencias de historia clínica para el
paciente con ID SNS12345 en esta CA."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
