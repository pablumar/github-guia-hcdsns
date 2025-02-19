<p>Este servicio permite a una CA solicitar al HCDSNS-BE un listado de
todos los servicios de salud donde el paciente dispone de historia
clínica. La respuesta será un <strong>Bundle</strong> de recursos
<strong>Organization</strong>, donde cada organización representa un
servicio de salud donde el paciente dispone de historia clínica. En el
campo <strong>type</strong> de cada <strong>Organization</strong> se
indicará si esa CA tiene capacidad para trabajar con FHIR, aparte
también recupera el flag de informes ocultos.</p>
<p><strong>Mensaje de Entrada</strong>: HC001</p>
<p><strong>Mensaje de Salida</strong>: HC002</p>
<p><strong>Endpoint:
/</strong>Organization?_has:DocumentReference:custodian:patient=&lt;&lt;COD_SNS&gt;&gt;</p>
<p><strong>Método:</strong> GET</p>
<p><strong>Cabeceras:</strong></p>
<blockquote>
<p>Authorization: Bearer {token}</p>
<p>Content-Type: application/fhir+json</p>
</blockquote>
<p><strong>Parámetros de la operación</strong></p>
<table border="1">
<colgroup>
<col style="width: 28%" />
<col style="width: 71%" />
</colgroup>
<tbody>
<tr>
<td><strong>Cod_sns</strong></td>
<td style="text-align: left;">Código Sns del paciente del que se desea
recuperar las referencias de HC.</td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas correctas</strong> se hará
uso del <strong>recurso FHIR Bundle</strong> <a
href="#referencias">(Referencia 6)</a> que contendrá todos aquellos
recursos FHIR Organization con la información requerida.</p>
<p>Para la comunicación de <strong>respuestas de error</strong> se hará
uso del <strong>recurso FHIR OperationOutcome</strong> <a
href="#referencias">(Referencia 7)</a> ya que proporciona la estructura
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
<li><p>- ERR001 Los campos no se encuentran en la BBDD</p></li>
<li><p>- ERR002 Los campos han de estar rellenos obligatoriamente y con
un valor correcto</p></li>
<li><p>- ERR003 Error al insertar en la BBDD</p></li>
</ul></li>
</ul>
