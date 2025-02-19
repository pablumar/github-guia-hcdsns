<h2 id="descripción-del-sistema-hcdsns">Descripción del Sistema
HCDSNS</h2>
<p>El actual sistema de mensajería en HCDSNS permite la consulta e
intercambio de información clínica entre el nodo central del SNS y las
CCAA. El nuevo estándar FHIR es un sistema moderno que permite la
interoperabilidad a nivel internacional para la consulta e intercambio
de datos clínicos estructurados.</p>
<p>Dado que algunas CCAA aún no tienen capacidad para implementar FHIR,
es necesario que ambas mensajerías (FHIR y tradicional) coexistan. El
nodo central será el encargado de orquestar qué protocolo utilizar en
función de las capacidades de las CCAA involucradas en cada
consulta.</p>
<p>Esta guía también incluye los diferentes flujos contemplados en la
comunicación con servicios transfronterizos.</p>
<h2 id="arquitectura-del-sistema">Arquitectura del Sistema</h2>
<p><strong>Componentes del Sistema</strong></p>
<p>El sistema se estructura en los siguientes componentes
principales:</p>
<ol type="1">
<li><p><strong>HCDSNS_BE (Backend)</strong>: Este componente procesará
las solicitudes de las CCAA. Determinará si las CCAA solicitadas tienen
capacidad para responder con FHIR o si deben usar la mensajería
tradicional. También se encargará de aglutinar toda la información
recibida por parte de las CCAA.</p></li>
<li><p><strong>HCDSNS_CA (Cliente para Comunidades Autónomas)</strong>:
Será un cliente distribuido entre las CCAA que podrá enviar y recibir
solicitudes en formato FHIR o utilizando la mensajería tradicional.
Durante la fase de transición, el cliente deberá poder manejar ambos
tipos de mensajes.</p></li>
<li><p><strong>HCDSNS_CC (Carpeta ciudadana)</strong>: Este componente
proporciona a los ciudadanos acceso directo y seguro a su información
clínica a través de un portal en línea. Permite a los pacientes
visualizar su historia clínica resumida, descargar documentos clínicos
en formato PDF, revisar alertas y gestionar permisos de acceso a sus
datos. Además, HCDSNS_CC garantiza que el acceso a los datos esté
protegido mediante autenticación segura, alineándose con los estándares
de privacidad y seguridad establecidos.</p></li>
</ol>
<h2 id="modelo-de-coexistencia-de-mensajerías">Modelo de Coexistencia de
Mensajerías</h2>
<p><strong>Mensajería Tradicional</strong></p>
<p>La mensajería tradicional seguirá siendo utilizada en aquellos casos
en los que las CCAA no hayan completado su transición a FHIR. El
protocolo actual basado en mensajería propia continuará sirviendo para
consultas y actualizaciones de referencias de pacientes.</p>
<p>Mensajes tradicionales:</p>
<ul>
<li><p>HC001: Solicitud de referencias de historia clínica.</p></li>
<li><p>HC002: Respuesta de listado de referencias.</p></li>
<li><p>HC003: Solicitud de referencias a una comunidad.</p></li>
<li><p>HC004: Listado de referencias de un tipo de informe.</p></li>
<li><p>HC005: Creación de referencias de una comunidad.</p></li>
</ul>
<p><strong>Mensajería FHIR</strong></p>
<p>La mensajería FHIR se adoptará progresivamente, utilizando el perfil
de interoperabilidad IHE “Mobile Access to Health Documents” (MHD). Los
mensajes clave incluyen:</p>
<ul>
<li><p><strong>Find Document References [ITI-67]</strong>: Transacción
para la consulta de referencias de documentos clínicos utilizando el
recurso DocumentReference.</p></li>
</ul>
<table>
    <tr>
        <td><img src="assets/images/image4.png" style="width:4.56314in;height:1.53146in" alt="Interfaz de usuario gráfica, Texto, Aplicación, Correo electrónico Descripción generada automáticamente" /></td>
    </tr>
</table>
<ul>
<li><p><strong>Retrieve Document [ITI-68]</strong>: Transacción para la
recuperación de documentos utilizando el recurso Binary para documentos
binarios (como PDF) o DocumentReference para metadatos del
documento.</p></li>
</ul>
<table>
    <tr>
        <td><img src="assets/images/image5.png" style="width:4.04223in;height:1.60439in" alt="Interfaz de usuario gráfica, Texto, Aplicación Descripción generada automáticamente" /></td>
    </tr>
</table>
<p>El sistema FHIR se apoyará en los recursos estándar definidos en HL7
FHIR, que incluyen:</p>
<ul>
<li><p>DocumentReference: Representa referencias a documentos
clínicos.</p></li>
<li><p>Binary: Representa datos binarios como PDF, imágenes,
etc.</p></li>
<li><p>Bundle: Agrupa recursos FHIR relacionados.</p></li>
<li><p>Flag: Representa diferentes tipos de alertas.</p></li>
<li><p>Communication: Representa notificaciones a realizar.</p></li>
<li><p>OperationOutcome: Modela el retorno de información relacionada
con una operación lanzada por un agente.</p></li>
<li><p>Organization: Modela el retorno de información relacionada con la
petición por parte de una CA de las referencias de historia clínica de
un paciente.</p></li>
</ul>
<h2 id="transición-progresiva">Transición Progresiva</h2>
<p><em><strong>Control del Estado de Migración</strong></em></p>
<p>HCDSNS_BE debe mantener un registro del estado de migración de cada
CCAA para saber si puede usar FHIR o si debe seguir utilizando la
mensajería tradicional. Este registro permitirá orquestar adecuadamente
las peticiones, asegurando que las solicitudes sean procesadas
utilizando el protocolo correcto.</p>
<p>El estado de migración se deberá consultar antes de realizar
cualquier transacción. Esto asegura que, si alguna CCAA aún no ha
migrado a FHIR, la solicitud deba realizarse con la mensajería
tradicional.</p>
<p><strong>Encapsulamiento de Mensajes y Documentos</strong></p>
<p>Durante la transición, las CCAA que ya utilicen FHIR podrán
encapsular los documentos estructurados en recursos Binary en el formato
actual, y las demás CCAA continuarán utilizando sus sistemas
tradicionales hasta que completen la migración.</p>
<p>Opciones de encapsulamiento de documentos:</p>
<ul>
<li><p><strong>Encapsulamiento en Binary</strong>:</p>
<ul>
<li><p>Las CCAA que no hayan evolucionado a FHIR seguirán utilizando la
mensajería SOAP actual.</p></li>
<li><p>Las CCAA que hayan evolucionado a FHIR podrán encapsular
documentos CDA y PDF en recursos Binary.</p></li>
</ul></li>
<li><p><strong>Transición a FHIR Documents</strong>: En una segunda
fase, los documentos podrán modelarse utilizando FHIR Documents, lo que
permitirá una interoperabilidad total y acceso granular a la información
clínica.</p></li>
</ul>
<p><strong>Alcance del Proyecto</strong></p>
<p>El proyecto abarca las siguientes áreas de implementación:</p>
<ul>
<li><p><strong>Consulta de referencias de historias clínicas</strong>:
Implementación del perfil Organization en FHIR para recuperar las
referencias a CCAA donde el paciente tiene historia clínica, incluyendo
a su vez el flag que indica si cada CA ha evolucionado o no a FHIR,
facilitando el paso siguiente.</p></li>
<li><p><strong>Consulta de referencias de documentos clínicos</strong>:
Implementación del perfil DocumentReference en FHIR para representar la
indexación de documentos clínicos, si en el paso anterior se ha indicado
que la CA ha evolucionado a FHIR la mensajería a utilizar será la
mensajería FHIR, en caso contrario la mensajería a utilizar será la
mensajería actual, SOAP.</p></li>
<li><p><strong>Recuperación de documentos clínicos</strong>:
Implementación del recurso Binary para el acceso a documentos clínicos
(en formato PDF, CDA).</p></li>
<li><p><strong>Registro y actualización de referencias
clínicas</strong>: Uso del recurso DocumentReference para la
actualización del índice de referencias del HCDSNS.</p></li>
<li><p><strong>Gestión de alertas y reclamaciones</strong>: Definición
de la mensajería FHIR para la gestión de alertas y reclamaciones,
utilizando para ello el recurso Flag.</p></li>
<li><p><strong>Consulta de flags ocultos y operaciones en modo
emergencia</strong>: Implementación de la lógica necesaria para
consultas y operaciones en modo emergencia con las restricciones
necesarias de privacidad.</p></li>
</ul>
<h2 id="evaluación-de-impacto-y-esfuerzo"><strong>Evaluación de Impacto
y Esfuerzo</strong></h2>
<p><strong>Impacto en el Sistema</strong></p>
<ul>
<li><p><strong>Backend</strong>: Se requerirá que el backend soporte la
interoperabilidad entre los dos sistemas de mensajería.</p></li>
<li><p><strong>Clientes CCAA</strong>: Las CCAA deberán actualizar o
instalar nuevos componentes de cliente que permitan manejar ambos tipos
de mensajería.</p></li>
<li><p><strong>Migración Gradual</strong>: El impacto se verá mitigado
por una migración progresiva, lo que permitirá una transición sin
interrupciones.</p></li>
</ul>
<p><strong>Esfuerzo Técnico</strong></p>
<ul>
<li><p><strong>Desarrollo</strong>: La implementación de las interfaces
FHIR debe seguir las guías de HL7 FHIR y las especificaciones IHE para
la interoperabilidad de documentos.</p></li>
<li><p><strong>Pruebas</strong>: Se requiere una exhaustiva fase de
pruebas de integración para garantizar que ambos sistemas (FHIR y
tradicional) puedan coexistir sin problemas.</p></li>
</ul>
<h2 id="identificación-de-riesgos"><strong>Identificación de
Riesgos</strong></h2>
<ol type="1">
<li><p><strong>Interoperabilidad Incompleta</strong>: Durante la fase de
transición, algunas CCAA pueden no estar completamente preparadas para
usar FHIR, lo que podría ralentizar el proceso de migración.</p></li>
<li><p><strong>Pérdida de Información</strong>: Existe el riesgo de que
algunos documentos grandes no se transmitan correctamente entre
sistemas. Se deben definir políticas claras de tamaño máximo de
documentos.</p></li>
<li><p><strong>Auditoría y Seguridad</strong>: Asegurar que todas las
transacciones, tanto en el sistema FHIR como en el sistema tradicional,
sean auditadas correctamente.</p></li>
</ol>
<h2 id="relaciones-con-otros-documentos">Relaciones con otros
documentos</h2>
<table border="1">
<colgroup>
<col style="width: 56%" />
<col style="width: 43%" />
</colgroup>
<thead>
<tr>
<th rowspan="2"
style="text-align: center;"><strong>archivo</strong></th>
<th rowspan="2"
style="text-align: center;"><strong>DESCRIPCIÓN</strong></th>
</tr>
<tr>
</tr>
</thead>
<tbody>
<tr>
<td
style="text-align: left;">Guia_Implementacion_Tarjeta_Sanitaria.docx</td>
<td>Documento en el que se especifica la guía de implementación de la
tarjeta sanitaria.</td>
</tr>
<tr>
<td
style="text-align: left;">Guia_Implementacion_Servidor_Terminologico.docx</td>
<td>Documento en el que se especifica la guía de implementación del
servidor terminológico.</td>
</tr>
<tr>
<td style="text-align: left;">Objetivos_y_Análisis_HCDSNS.docx</td>
<td>Documento con la consultoría previa realizada por Minsait.</td>
</tr>
</tbody>
</table>
<h2 id="destinatarios">Destinatarios</h2>
<p>Este documento va dirigido al personal de la SGSDS.</p>
<h2 id="glosario">Glosario</h2>
<p><strong>SNS</strong>: Sistema Nacional de Salud.</p>
<p><strong>CCAA</strong>: Comunidades Autónomas.</p>
<p><strong>CA</strong>: Comunidad Autónoma.</p>
<p><strong>SI</strong>: Sistema de Información</p>
<p><strong>HCD</strong>: Historia Clínica Digital</p>
<p><strong>FHIR (Fast Healthcare Interoperability Resources)</strong>:
Estándar para la interoperabilidad de información en salud promovido por
<strong>HL7</strong>.</p>
<p><strong>HAPI FHIR</strong>: Implementación en Java del estándar
<strong>FHIR</strong>, utilizada para construir servidores y clientes
FHIR.</p>
<p><strong>DocumentReference:</strong> Representa una referencia a un
documento clínico existente, proporcionando metadatos como autor, fechas
y enlaces al contenido. Se usa para indexar documentos clínicos.</p>
<p><strong>Binary:</strong> Almacena contenido binario sin estructurar,
como imágenes o documentos en PDF, para su acceso en formato
original.</p>
<p><strong>Composition:</strong> Define la estructura y contenido de un
documento clínico, compuesto por secciones que contienen recursos
relacionados.</p>
<p><strong>Bundle:</strong> Agrupa múltiples recursos FHIR en un
contenedor, usado para transacciones, documentos o mensajes
clínicos.</p>
<p><strong>Patient:</strong> Representa la información demográfica
básica de un paciente, como nombre, fecha de nacimiento y género.</p>
<p><strong>Practitioner:</strong> Describe a un profesional de salud,
incluyendo su nombre, credenciales y la organización a la que
pertenece.</p>
<p><strong>Organization:</strong> Define una entidad como un hospital o
clínica, incluyendo su nombre, dirección y contactos.</p>
<p><strong>Communication:</strong> Registra una interacción o mensaje
entre actores del sistema de salud, documentando su contenido y
contexto.</p>
<p><strong>Flag:</strong> Indica una alerta o marca relacionada con un
paciente, señalando condiciones o advertencias importantes.</p>
<p><strong>MessageHeader:</strong> Proporciona detalles sobre un mensaje
clínico, incluyendo su propósito y los actores involucrados en la
comunicación.</p>
<p><strong>SOAP (Simple Object Access Protocol)</strong>: Protocolo de
intercambio de información en la web que se utiliza actualmente en la
mensajería del <strong>HCDSNS</strong>.</p>
<p><strong>CCAA (Comunidades Autónomas)</strong>: Las entidades
administrativas españolas responsables de la sanidad regional.
<strong>OAuth2:</strong> protocolo de autorización que permite que las
aplicaciones obtengan acceso a recursos protegidos en nombre de un
usuario sin compartir sus credenciales. Se utiliza ampliamente en la
autenticación de usuarios y la integración de servicios en línea.</p>
<p><strong>OpenNCP:</strong> conjunto de componentes que proporciona la
Comisión Europea para la interoperabilidad transfronteriza que son
independientes de las particularidades de la infraestructura
nacional.</p>
<p><strong>OSB / OSB11 / OSB12</strong>: bus de integración Oracle
Service Bus (versiones 11 / 12).</p>
<h2 id="referencias">Referencias</h2>
<p>[1] Referencia recurso DocumentReference 🡪 <a
href="https://www.hl7.org/fhir/documentreference.html">DocumentReference
- FHIR v4.0.1 (hl7.org)</a></p>
<p>[2] Referencia recurso Binary 🡪 <a
href="https://build.fhir.org/binary.html">Binary - FHIR v4.0.1
(hl7.org)</a></p>
<p>[3] Referencia recurso Bundle 🡪 <a
href="https://build.fhir.org/bundle.html">Bundle - FHIR v4.0.1
(hl7.org)</a></p>
<p>[4] Referencia recurso Flag 🡪 <a
href="https://build.fhir.org/flag.html">Flag - FHIR v4.0.1
(hl7.org)</a></p>
<p>[5] Referencia recurso Communication 🡪 <a
href="https://build.fhir.org/communication.html">Communication - FHIR
v4.0.1 (hl7.org)</a></p>
<p>[6] Referencia recurso OperationOutcome 🡪 <a
href="https://build.fhir.org/operationoutcome.html">OperationOutcome -
FHIR v4.0.1 (hl7.org)</a></p>
<p>[7] Referencia recurso Organization 🡪 <a
href="https://build.fhir.org/organization.html">Organization - FHIR
v4.0.1 (hl7.org)</a></p>
