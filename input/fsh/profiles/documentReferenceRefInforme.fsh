Alias: $eHDSILaboratoryReportType = http://myhealth.eu/fhir/ncp-api/ValueSet/eHDSILaboratoryReportType
Alias: $eHDSILabStudyType = http://fhir.ehdsi.eu/mvc/eHDSILabStudyTypes

Profile: DocumentReferenceRefInfSNS
Parent: DocumentReference
Id: DocumentReference-refInf-sns
Title: "DocumentReference: Referencia Informe"
Description: "Este perfil define la referencia a un informe relacionado con el paciente"
* status = #current
* status ^short = "Estado de esta referencia"

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
* subject.display 0..1

* date 1..1
* description 1..

* custodian.identifier 1..1 
* custodian.identifier ^short = "Identificador del agente donde se encuentra el informe"

* description ^short = "Descripción de la referencia"
* content obeys docref-no-data
* content.attachment.contentType ^short = "Tipo de dato (application/fhir+json; application/pdf)"
* content.attachment.url ^short = "Identificador de acceso al informe"
* content.attachment.language ^short = "Idioma asociado al informe"