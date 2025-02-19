<p>Una vez obtenido un listado de referencias, se selecciona una de
ellas para recuperar el informe asociado. Para ello se utilizará el
recurso FHIR <strong>Binary</strong>. Esta operación parte de una
referencia ya seleccionada en la operación anterior, consulta de
referencias.</p>
<p><strong>Descripción</strong>: Permite recuperar un informe
seleccionado por el profesional relacionado con el paciente e informes
seleccionados previamente.</p>
<p><strong>Mensaje de Entrada</strong>: HC007</p>
<p><strong>Mensaje de Salida</strong>:</p>
<ul>
<li><p>HC008 para Historia clínica Resumida</p></li>
<li><p>HC009 para Atención primaria</p></li>
<li><p>HC010 para Urgencias</p></li>
<li><p>HC011 para Alta Hospitalaria</p></li>
<li><p>HC012 para Consulta Externa</p></li>
<li><p>HC013 para Pruebas de laboratorio</p></li>
<li><p>HC014 para Pruebas de imagen</p></li>
<li><p>HC015 para Cuidados de enfermería</p></li>
<li><p>HC016 para Otras pruebas diagnosticas</p></li>
<li><p>HC038 para EU Patient Summary</p></li>
</ul>
<p><strong>Endpoint:</strong> /Binary/&lt;&lt;ID INFORME&gt;&gt;</p>
<p><strong>Método:</strong> GET</p>
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
<td><strong>ID_INFORME</strong></td>
<td style="text-align: left;">Identificador del informe a recuperar</td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas correctas</strong> se
devolverá el detalle del informe en el formato seleccionado, PDF o
CDA.</p>
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
<li><p>ERR001 Los campos no se encuentran en la BBDD</p></li>
<li><p>ERR002 Los campos han de estar rellenos obligatoriamente y con un
valor correcto</p></li>
<li><p>ERR003 Error al insertar en la BBDD</p></li>
</ul></li>
</ul>
