<p>Una vez obtenido un listado de referencias, se selecciona una de
ellas para recuperar el informe asociado. El informe a recuperar es un
documento estructurado, esto implica que la estructura a devolver va a
ser un bundle de tipo FHIR Document. Esta operación parte de una
referencia ya seleccionada en la operación anterior, consulta de
referencias.</p>
<p><strong>Descripción</strong>: Permite recuperar un informe
estructurado seleccionado por el profesional relacionado con el paciente
e informes seleccionados previamente.</p>
<p>En este caso se devolverá un bundle de tipo FHIR Document que
incluirá todos los recursos relacionados entre sí y que definen el
informe requerido.</p>
<p><strong>Endpoint:</strong> /Bundle/&lt;&lt;ID CA&gt;&gt;-&lt;&lt;ID
BUNDLE&gt;&gt;</p>
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
<td><strong>ID_CA</strong></td>
<td style="text-align: left;">Identificador de la CA a la que invocar
para recuperar el informe estructurado.</td>
</tr>
<tr>
<td><strong>ID_BUNDLE</strong></td>
<td style="text-align: left;">Identificador de la informe estructurado a
recuperar.</td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas correctas</strong> se
devolverá el bundle con el FHIR Document incluyendo todos los recursos
FHIR relacionados.</p>
<p>Para la comunicación de <strong>respuestas de error</strong> se hará
uso del <strong>recurso FHIR OperationOutcome</strong> <a
href="#referencias">(Referencia 7)</a> ya que proporciona la estructura
necesaria para cubrir las actuales respuestas de error.</p>
<table border="1">
<colgroup>
<col style="width: 21%" />
<col style="width: 41%" />
<col style="width: 37%" />
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
