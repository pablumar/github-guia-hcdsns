Alias: $eHDSILaboratoryReportType = http://myhealth.eu/fhir/ncp-api/ValueSet/eHDSILaboratoryReportType
Alias: $eHDSILabStudyType = http://fhir.ehdsi.eu/mvc/eHDSILabStudyTypes

Profile: DocumentReferenceMinimalSNS
Parent: DocumentReference
Id: DocumentReference-minimal-sns
Title: "DocumentReference: Minimal"
Description: "Este perfil define los datos mínimos devueltos por el servicio de búsqueda de referencias de informes del SNS"
* masterIdentifier 1.. 
* masterIdentifier ^short = "Identificador principal"
* identifier ^short = "Otros identificadores"
* status = #current
* status ^short = "Estado de esta referencia a un informe"
* docStatus ^short = "Estado del bundle"
* type 1..1
* type from $eHDSILaboratoryReportType (required)
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category ^short = "Categoría del informe"
* category ^definition = "Código que clasifica este informe."
* category contains studyType 0..*
* category[studyType] from $eHDSILabStudyType (required)
* category[studyType] ^short = "Agrupación de los resultados de las pruebas en dominios clínicamente significativos (por ejemplo, estudio de hematología, estudio de microbiología, etc.)"
* category[studyType] ^definition = "Servicios de laboratorio, es decir, los resultados de las pruebas realizadas, podrían caracterizarse mediante una tipología de servicios, comúnmente denominada tipos de estudio. El tipo de estudio podría verse como un atributo o mecanismo de agrupación que asigna un sentido clínico común a ciertos tipos de resultados de pruebas de laboratorio. Por ejemplo, hemoglobina, recuento de plaquetas, etc. pertenece al 'estudio de hematología'."
* category[studyType] ^comment = "En comparación con la especialidad de laboratorio, que es un atributo del laboratorio, el tipo de estudio es una categorización del servicio de laboratorio. Cabe mencionar que la clasificación de los tipos de pruebas para estudiar no está estandarizada."
* subject.identifier 1..1
* subject.identifier.system 1..1
* subject.identifier.value 1..1
* subject.identifier ^short = "Identificador CIP-SNS del paciente"

* date 1..
* description 1..
* content obeys docref-no-data
* content.attachment.contentType ^short = "Tipo de informe (application/fhir+json; application/pdf))"
* content.attachment.data ^short = "Usado únicamente para PDF"
* content.attachment.language ^short = "Idioma del informe"
* context.related only Reference(DiagnosticReport)

Invariant: docref-no-data
Description: "attachment.data shall not be present if the document is not a PDF"
* severity = #error
* expression = "attachment.where(contentType != 'application/pdf').data.empty()"