<p>Actualmente HCDSNS proporciona servicios de consulta que permiten a
los usuarios obtener la lista de referencias de informes que componen la
historia clínica con independencia de la comunidad de registro mediante
el mensaje HC001 y su respuesta HC002. Para ello, HCDSNS_BE mantiene un
índice que referencias que le permite conocer las CCAA en las que el
paciente tiene información disponible. El usuario podrá solicitar
entonces el tipo de documento a buscar y el filtro temporal mediante el
mensaje HC003, y su respuesta HC004. En este momento, HCDSNS_BE
consultará las referencias a aquellas comunidades en las que hay
registrada información utilizando el mensaje HC003 y su respuesta
HC005.</p>
<p>En el modelo FHIR, el recurso <a
href="https://www.hl7.org/fhir/R4/documentreference.html">DocumentReference</a>
es la entidad que permite referenciar documentos electrónicos de
cualquier tipo que estén relacionados con la atención de salud de un
paciente (informes médicos, resultados de pruebas, notas clínicas,
imágenes, etc.). Mediante este recurso, se facilita la indexación y
recuperación de documentos, dado que permite buscar y recuperar
documentos basados en diferentes criterios (paciente, tipo de documento,
fechas...). DocumentReference proporciona metadatos esenciales sobre el
informe y cómo se relaciona con otros recursos FHIR, así como la gestión
de aspectos de seguridad y privacidad, asegurando que sólo las partes
autorizadas puedan acceder a los documentos.</p>
<p><strong>Descripción</strong>: Permite solicitar todas las referencias
de un informe de un tipo asociadas a un paciente específico. Indicando
el código LOINC seleccionamos únicamente el tipo al que corresponden las
referencias que se van a recuperar. Por ejemplo, 11502-2 corresponde a
pruebas de laboratorio.</p>
<p><strong>Mensaje de Entrada</strong>: HC003</p>
<p><strong>Mensaje Intermedio</strong>: HC004</p>
<p><strong>Mensaje de Salida</strong>: HC005</p>
<p><strong>Endpoint:</strong>
/DocumentReference?patient=&lt;&lt;COD_SNS&gt;&gt;&amp;type=&lt;&lt;COD_LOINC&gt;&gt;&amp;custodian=Organization/&lt;&lt;COD_SERVICIO_SALUD&gt;&gt;&amp;x-flag=&lt;&lt;FLAG_EMERGENCIA&gt;&gt;</p>
<p><strong>Método:</strong> GET</p>
<p><strong>Cabeceras</strong>:</p>
<blockquote>
<p>Authorization: [token]</p>
<p>Content-Type: application/fhir+json</p>
</blockquote>
<p><strong>Parámetros de la operación desde una CA</strong></p>
<table border="1">
<colgroup>
<col style="width: 32%" />
<col style="width: 67%" />
</colgroup>
<tbody>
<tr>
<td><strong>COD_SNS</strong></td>
<td style="text-align: left;">Código Sns del paciente del que se desea
recuperar las referencias de documentos clínicos.</td>
</tr>
<tr>
<td><strong>COD_LOINC</strong></td>
<td style="text-align: left;">Identificador del tipo de informe
relacionado con las referencias a documentos clínicos a recuperar.</td>
</tr>
<tr>
<td><strong>COD_SERVICIO_SALUD</strong></td>
<td style="text-align: left;">Código del servicio de salud del que se
solicita una referencia.Tabla SERVICIOS_SALUD. Numérico 0-99999</td>
</tr>
<tr>
<td><strong>FLAG_EMERGENCIA</strong></td>
<td style="text-align: left;"><p>Indicador si la petición es en caso de
emergencia. Si es así se pedirá que se devuelvan todas las referencias
aunque estén ocultos por el usuario. Valores:</p>
<p>0 -&gt; Petición normal</p>
<p>1 -&gt; Petición de emergencia</p></td>
</tr>
</tbody>
</table>
<p>Para la comunicación de <strong>respuestas correctas</strong> se hará
uso del <strong>recurso FHIR Bundle</strong> <a
href="#referencias">(Referencia 6)</a> que contendrá todos aquellos
recursos FHIR DocumentReference con la información requerida.</p>
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
