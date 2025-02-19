<p>Este servicio permite recuperar el detalle de un informe estructurado
seleccionado por el profesional situado en un servicio transfronterizo.
Para ello se utilizará la dirección contenida en el DocumentReference
seleccionado en el paso anterior que se encuentra dentro del tag
siguiente:</p>
<p>"url": "/bundle/<strong>20160201-XXXXXXX</strong>"</p>
<p>Invocando para ello el servicio que permite recuperar el bundle de
tipo FHIR Document que contiene la prueba de laboratorio indicada.</p>
<p>A continuación, se describen las principales operaciones relacionadas
con la solicitud y recuperación de documentos clínicos en el
sistema.</p>
<p>Cuando un profesional residente en otro país está atendiendo a un
paciente español, y dispone de un listado de referencias de informes de
laboratorio, selecciona una referencia específica para visualizar el
informe relacionado, el servicio transfronterizo envía una solicitud al
Backend del SNS para obtener dicho informe. HCDSNS_BE recibe esta
solicitud junto con la CCAA que custodia el informe y reenvía la
solicitud directamente a dicha CCAA. La CCAA que posee el documento
responde con un recurso <strong>Bundle</strong> que contiene el informe
en su interior con todos los recursos FHIR relacionados.</p>
<p>Este flujo garantiza que el profesional de salud en la CCAA
solicitante pueda acceder al documento completo, proporcionando un
acceso rápido y controlado a los contenidos específicos de la historia
clínica del paciente.</p>
<h4
id="openncp-solicitud-de-informe-desde-un-servicio-transfronterizo">OpenNCP:
Solicitud de Informe desde un servicio transfronterizo</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un profesional residente en un país extranjero selecciona un informe
específico que previamente se identificó en la consulta de referencias.
El servicio transfronterizo envía una solicitud al Backend del SNS para
recuperar, previa llamada a la CA correspondiente, el contenido del
informe utilizando el recurso <strong>Bundle.</strong></p>
<p><strong>Ejemplo:</strong></p>
<p>GET /Bundle/20160201-XXXXXXX</p>
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
<p>“type”: “document”,</p>
<p>…</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: El recurso <strong>Bundle</strong> no se
encuentra.</p>
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
<p>"text": "No se encontró el recurso Bundle con ID XXXXXXX para el
paciente SNS12345."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<h4
id="hcdsns-be-transmisión-de-solicitud-de-informe-por-el-backend-1">HCDSNS-BE:
Transmisión de Solicitud de Informe por el Backend</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>HCDSNS_BE recibe una solicitud de otro país para acceder al contenido
de un informe previamente identificado en la consulta de referencias.
Envía una solicitud directa al recurso <strong>Bundle</strong> en la CA
que posee el documento y retransmite la respuesta al servicio
peticionario.</p>
<p><strong>Ejemplo:</strong></p>
<p>GET /Bundle/20160201-XXXXXXX</p>
<p>Authorization: [token]</p>
<p><strong>Pasos del Proceso</strong>:</p>
<ol type="1">
<li><p>El servicio transfronterizo envía una solicitud para recuperar el
contenido del informe (ID 20160201-XXXXXXX) del paciente
BBBBBBBBBB009933 a HCDSNS_BE.</p></li>
<li><p>HCDSNS_BE identifica la CA que posee el recurso y envía la
solicitud a esa CA. Para ello, a partir del identificador recibido, lo
descompone en dos partes, la primera parte es el identificador de la
CA.</p></li>
<li><p>La CA indicada responde con el recurso <strong>bundle</strong>
que contiene los recursos FHIR relacionados.</p></li>
<li><p>HCDSNS_BE recibe dicho recurso y lo transmite de vuelta al
servicio peticionario.</p></li>
</ol>
<p><strong>Respuesta esperada</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Bundle",</p>
<p>“type”: “document”,</p>
<p>…</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<h4 id="hcdsns-ca-respuesta-de-la-ca-con-el-documento">HCDSNS-CA:
Respuesta de la CA con el documento</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Una Comunidad Autónoma (CA) recibe una solicitud del Backend para el
informe clínico específico de un paciente. La CA recupera el documento y
lo envía como un recurso <strong>Bundle</strong> incluyendo los recursos
FHIR relacionados. Este recurso es transmitido de vuelta a HCDSNS_BE,
que lo reenvía al servicio peticionario.</p>
<ul>
<li><p><strong>Ejemplo:</strong></p></li>
</ul>
<p>GET /Bundle/XXXXXXX</p>
<p>Authorization: [token]</p>
<ul>
<li><p><strong>Respuesta de la CA</strong>:</p></li>
</ul>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Bundle",</p>
<p>“type”: “document”,</p>
<p>…</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: No se encuentra el informe solicitado
para el paciente en la CA.</p>
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
<p>"text": "No se encontró el informe"</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
