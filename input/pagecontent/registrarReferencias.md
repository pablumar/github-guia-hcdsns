<p>Este servicio permite gestionar el registro de nuevas referencias,
tanto en alta como en baja, de existencia de historia clínica de un
paciente en una CA concreta.</p>
<p><strong>Descripción</strong>: Permite registrar o eliminar una
referencia de historia clínica para un paciente. La solicitud se envía
como un recurso <strong>DocumentReference</strong> que incluye los
parámetros que se describen a continuación.</p>
<p><strong>Mensaje de Entrada</strong>: HC017</p>
<p><strong>Mensaje de Salida</strong>: HC018</p>
<p><strong>Endpoint:</strong> /DocumentReference</p>
<p><strong>Método</strong>: POST</p>
<p><strong>Cabeceras</strong>:</p>
<blockquote>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
</blockquote>
<p><strong>Parámetros de la operación</strong></p>
<table border="1">
<colgroup>
<col style="width: 27%" />
<col style="width: 39%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr>
<td><strong>Cod_sns</strong></td>
<td style="text-align: left;">Código Sns del paciente al cual pertenece
la referencia que se está introduciendo.</td>
<td style="text-align: left;">DocumentReference.subject.identifier</td>
</tr>
<tr>
<td><strong>Cip</strong></td>
<td style="text-align: left;">Cip del paciente al cual pertenece la
referencia que se está introduciendo .Texto longitud máxima 25</td>
<td style="text-align: left;">DocumentReference.subject.identifier</td>
</tr>
<tr>
<td><strong>Fecha</strong></td>
<td style="text-align: left;">Fecha de alta de la referencia.</td>
<td style="text-align: left;">DocumentReference.date</td>
</tr>
<tr>
<td><strong>Cod_servicio_salud</strong></td>
<td style="text-align: left;">Código identificador del servicio de salud
al cual pertenece la referencia del paciente. Tabla SERVICIOS_SALUD.
Numérico 0-99999</td>
<td
style="text-align: left;">DocumentReference.custodian.identifier</td>
</tr>
<tr>
<td><strong>Flag_oculto</strong></td>
<td style="text-align: left;"><p>Identifica si el alta/modificación de
la referencia contiene información de ocultación de informes(información
opcional):</p>
<p>- Si el valor es “1” -&gt;se realiza el alta/modificación de la
referencia con informes ocultos.</p>
<p>- Si el valor no viene, es vacío o es “0” -&gt; se realiza el
alta/modificación de la referencia sin informes ocultos.</p></td>
<td style="text-align: left;">DocumentReference.extension</td>
</tr>
<tr>
<td><strong>Operacion</strong></td>
<td style="text-align: left;"><p>Identifica el tipo de operación a
realizar:</p>
<p>- Si no viene, es vacio o el valor es “A” -&gt;se realiza el alta de
la referencia en el nodo central</p>
<p>- Si el valor es “B” -&gt; se da de baja la referencia en el nodo
central.</p></td>
<td style="text-align: left;">DocumentReference.extension</td>
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
<li><p>ERR-002 Error al insertar en la BBDD</p></li>
<li><p>ERR-011 Los campos han de estar rellenos obligatoriamente y con
un valor correcto</p></li>
<li><p>ERR-058 El código Sns no es correcto</p></li>
</ul></li>
</ul>