<p>Actualmente existen varios tipos de alertas en HCDSNS:</p>
<ul>
<li><p>Alerta Manual: alerta generada por el propio ciudadano cuando
accede a la aplicación debida a alguna de las siguientes causas:</p>
<ul>
<li><p>Incidencia en la propia aplicación: notifica un problema de uso
en la misma.</p></li>
<li><p>Incidencia en alguna de los informes: el ciudadano detecta alguna
errata en un informe y lo notifica para su posterior
corrección.</p></li>
</ul></li>
</ul>
<blockquote>
<p>Esta alerta se genera desde HCDSNS_CA a HCDSNS_BE, donde se
implementará la lógica necesaria para el tratamiento de dicha
alerta.</p>
</blockquote>
<ul>
<li><p>Alerta Automática: alerta generada automáticamente que indica una
incidencia en la mensajería recibida en HCDSNS_BE. Dicha alerta se
notifica desde BE al módulo HCDSNS_CA, donde se implementará la lógica
necesaria para el tratamiento de dicha alerta.</p></li>
</ul>
<p>Para un correcto tratamiento de esta operación se utilizará el
recurso <strong>Flag</strong> de FHIR.</p>
<p><strong>Descripción</strong>: Notificación de una alerta causada por
alguno de los motivos antes descritos.</p>
<p><strong>Mensaje de Entrada</strong>: HC025</p>
<p><strong>Endpoint</strong>: /Flag</p>
<p><strong>Método</strong>: POST</p>
<p><strong>Cabeceras</strong>:</p>
<blockquote>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
</blockquote>
<p><strong>Parámetros de la operación</strong></p>
<table border="1">
<colgroup>
<col style="width: 30%" />
<col style="width: 69%" />
</colgroup>
<tbody>
<tr>
<td></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas correctas</strong> se hará
uso del <strong>recurso FHIR OperationOutcome</strong> <a
href="#referencias">(Referencia 6)</a> ya que proporciona la estructura
necesaria para cubrir las actuales respuestas correctas.</p>
<table border="1">
<colgroup>
<col style="width: 22%" />
<col style="width: 32%" />
<col style="width: 44%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><strong>Origen</strong></th>
<th style="text-align: center;"><strong>Recurso FHIR</strong></th>
<th style="text-align: center;"><strong>Descripcion</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Error</strong></td>
<td>"<strong>OperationOutcome</strong>”</td>
<td></td>
</tr>
<tr>
<td>Codigo</td>
<td>OperationOutcome 🡪 id</td>
<td>Código correcto.</td>
</tr>
<tr>
<td>Descripcion</td>
<td>OperationOutcome 🡪 text</td>
<td>Descripción.</td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas de error</strong> se hará
uso del <strong>recurso FHIR OperationOutcome</strong> <a
href="#referencias">(Referencia 6)</a> ya que proporciona la estructura
necesaria para cubrir las actuales respuestas de error.</p>
<table border="1">
<colgroup>
<col style="width: 21%" />
<col style="width: 43%" />
<col style="width: 34%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><strong>Origen</strong></th>
<th style="text-align: center;"><strong>Recurso FHIR</strong></th>
<th style="text-align: center;"><strong>Descripcion</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Error</strong></td>
<td>"<strong>OperationOutcome</strong>”</td>
<td>Recurso para modelar toda la información asociada al error que se ha
producido, o bien si la operación ha sido correcta, indicando tal
hecho.</td>
</tr>
<tr>
<td>Codigo_error</td>
<td>OperationOutcome.issue.code</td>
<td>Código de éxito/error.</td>
</tr>
<tr>
<td>Descripcion_error</td>
<td>OperationOutcome.issue.details</td>
<td>Descripción del éxito/error.</td>
</tr>
<tr>
<td>Nivel de error</td>
<td>OperationOutcome.issue.severity</td>
<td>Nivel de error</td>
</tr>
<tr>
<td>Diagnóstico</td>
<td>OperationOutcome.issue.diagnostics</td>
<td>Diagnóstico</td>
</tr>
</tbody>
</table>
<p>Como resultado del servicio se devolverán los siguientes datos:</p>
<ul>
<li><p>Cabeceras HTTP</p>
<ul>
<li><p>200 🡪 Operación realizada satisfactoriamente.</p></li>
<li><p>401 🡪 No se ha recibido la cabecera Authorization, o bien, dicha
cabecera no es correcta.</p></li>
<li><p>511 🡪 Problemas con el sistema</p></li>
<li><p>512 🡪 Agente no valido</p></li>
<li><p>513 🡪 Cola saturada</p></li>
<li><p>514 🡪 Sistema bloqueado</p></li>
<li><p>515 🡪 Error firma no valida</p></li>
<li><p>516 🡪 Operación no registrada</p></li>
<li><p>517 🡪 Agente bloqueado</p></li>
</ul></li>
<li><p>En el caso de que se produzca un error se enviará en el body de
la respuesta el recurso FHIR OperationOutcome correspondiente con la
información del error producido detallada. Estos errores son los
siguientes:</p>
<ul>
<li><p>ERR001 Los campos no se encuentran en la BBDD</p></li>
<li><p>ERR002 Los campos han de estar rellenos obligatoriamente y con un
valor correcto</p></li>
<li><p>ERR003 Error al insertar en la BBDD</p></li>
</ul></li>
</ul>
