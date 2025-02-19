<p>Este servicio permite recuperar el detalle de un informe seleccionado
por el profesional. Para ello se utilizará la dirección contenida en el
DocumentReference seleccionado en el paso anterior que se encuentra
dentro del tag siguiente:</p>
<p>"url": "/Binary/67890"</p>
<p>Invocando para ello el servicio que permite recuperar el Binary que
contiene a su vez el informe en formato PDF, o bien en formato CDA
encapsulado en un formato Base64, como es el caso de EU Patient
Summary.</p>
<p>A continuación, se describen las principales operaciones relacionadas
con la solicitud y recuperación de documentos clínicos en el
sistema.</p>
<p>Cuando un profesional de una Comunidad Autónoma (CCAA) selecciona una
referencia específica para visualizar el informe relacionado, la CCAA
envía una solicitud al Backend del SNS para obtener el propio informe.
HCDSNS_BE recibe esta solicitud junto con la CCAA que custodia el
informe y reenvía la solicitud directamente a dicha CCAA. La CCAA que
posee el documento responde con un recurso <strong>Binary</strong> que
contiene el informe en el campo <strong>data</strong>.</p>
<p>Este flujo garantiza que el profesional de salud en la CCAA
solicitante pueda acceder al documento completo, proporcionando un
acceso rápido y controlado a los contenidos específicos de la historia
clínica del paciente.</p>
<table><tr><td><img src="imagen2.png"/></td></tr></table>
<h4
id="hcdsns-ca-solicitud-de-informe-desde-la-comunidad-autónoma">HCDSNS-CA:
Solicitud de Informe desde la Comunidad Autónoma</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Un profesional de una Comunidad Autónoma (CA) selecciona un informe
específico que previamente se identificó en la consulta de referencias.
La CA envía una solicitud al Backend del SNS para recuperar directamente
el contenido del informe utilizando el recurso
<strong>Binary.</strong></p>
<p><strong>Ejemplo:</strong></p>
<p><strong>Solicitud de la CA al Backend</strong>:</p>
<p>GET /Binary/67890<br />
Authorization: [token]</p>
<p><strong>Respuesta esperada</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Binary",</p>
<p>"id": "67890",</p>
<p>"contentType": "application/pdf",</p>
<p>"data": "JVBERi0xLjQKJYS1tbW1DQox..."</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Explicación del Resultado:</strong></p>
<p>La CA recibe un recurso <strong>Binary</strong> que contiene el
contenido del informe del paciente <strong>SNS12345</strong> en el campo
<strong>data</strong>, permitiendo que el profesional pueda visualizar
el documento en formato PDF.</p>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: El recurso <strong>Binary</strong> no se
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
<p>"text": "No se encontró el recurso Binary con ID 67890 para el
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
id="hcdsns-be-transmisión-de-solicitud-de-informe-por-el-backend">HCDSNS-BE:
Transmisión de Solicitud de Informe por el Backend</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>El Backend del SNS recibe una solicitud de una CA para acceder al
contenido de un informe previamente identificado en la consulta de
referencias. El Backend envía una solicitud directa al recurso
<strong>Binary</strong> en la CA que posee el documento y retransmite la
respuesta a la CA solicitante.</p>
<p><strong>Ejemplo:</strong></p>
<p><strong>Solicitud Inicial desde la CA Solicitante al
Backend</strong>:</p>
<p>GET /Binary/67890</p>
<p>Authorization: [token]</p>
<p><strong>Pasos del Proceso</strong>:</p>
<ol type="1">
<li><p>La <strong>CA solicitante</strong> envía una solicitud para
recuperar el contenido del informe (ID 67890) del paciente
<strong>SNS12345</strong> al <strong>Backend del SNS</strong>.</p></li>
<li><p>El <strong>Backend</strong> identifica la CA que posee el
<strong>Binary</strong> y envía la solicitud a esa CA.</p></li>
<li><p>La <strong>CA poseedora</strong> responde con el recurso
<strong>Binary</strong> que contiene el PDF en el campo
<strong>data</strong>.</p></li>
<li><p>El <strong>Backend</strong> recibe el <strong>Binary</strong> y
lo transmite de vuelta a la <strong>CA solicitante</strong>.</p></li>
</ol>
<p><strong>Respuesta esperada</strong>:</p>
<table border="1">
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th><p>{</p>
<p>"resourceType": "Binary",</p>
<p>"id": "67890",</p>
<p>"contentType": "application/pdf",</p>
<p>"data": "JVBERi0xLjQKJYS1tbW1DQox..."</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Explicación del Resultado:</strong></p>
<p>La <strong>CA solicitante</strong> recibe el recurso
<strong>Binary</strong> con el PDF del informe del paciente
<strong>SNS12345</strong> en el campo <strong>data</strong>, permitiendo
el acceso directo al documento.</p>
<p><strong>Error:</strong></p>
<ul>
<li><p><strong>Error</strong>: La CA poseedora no puede localizar el
<strong>Binary</strong>.</p>
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
<p>"text": "El recurso Binary con ID 67890 no se encuentra en la
CA."</p>
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
id="hcdsns-ca-respuesta-de-la-ca-con-el-informe-solicitado">HCDSNS-CA:
Respuesta de la CA con el Informe Solicitado</h4>
<p><strong>Descripción del Escenario:</strong></p>
<p>Una Comunidad Autónoma (CA) recibe una solicitud del Backend para el
informe clínico específico de un paciente. La CA recupera el documento y
lo envía como un recurso <strong>Binary</strong>, con el PDF del informe
directamente en el campo <strong>data</strong>. Este recurso
<strong>Binary</strong> es transmitido de vuelta al Backend, que lo
reenvía a la CA solicitante.</p>
<ul>
<li><p><strong>Ejemplo:</strong></p></li>
</ul>
<p><strong>Solicitud del Backend a la CA</strong>:</p>
<p>GET /Binary/67890</p>
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
<p>"resourceType": "Binary",</p>
<p>"id": "67890",</p>
<p>"contentType": "application/pdf",</p>
<p>"data": "JVBERi0xLjQKJYS1tbW1DQox..."</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<p><strong>Explicación del Resultado:</strong></p>
<p>La <strong>CA</strong> envía un recurso <strong>Binary</strong> con
el PDF del informe del paciente <strong>SNS12345</strong> codificado en
el campo <strong>data</strong>. Este recurso <strong>Binary</strong> es
enviado al <strong>Backend</strong>, que luego lo reenvía a la
<strong>CA solicitante</strong> para que el profesional de salud pueda
visualizar el documento completo.</p>
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
<p>"text": "No se encontró el informe solicitado con ID 67890 para el
paciente SNS12345 en esta CA."</p>
<p>}</p>
<p>}</p>
<p>]</p>
<p>}</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

