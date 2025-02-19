Instance: DocumentReferenceMinimal
InstanceOf: DocumentReferenceMinimalSNS
Usage: #example
Title: "DocumentReference: Datos Mínimos"
Description: "Ejemplo de DocumentReference Datos Mínimos asociado a un ejemplo de bundle de LRR (Laboratory Result Report)"
* masterIdentifier.system = "http://example.org"
* masterIdentifier.value = "ba91c64b-f30c-4137-a484-34bbba5e8804"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.2.120.4.4"
* identifier.value = "c030702.TSTSMN63A01F205H.20220325112426.TSS1Tkju"
* status = #current
* type = $eHDSILaboratoryReportType#11502-2 "Laboratory report"
* category = $eHDSILabStudyType#18719-5 "Chemistry studies (set)"
* subject.identifier.system = "2.16.724.4.40"
* subject.identifier.value = "BBBBBBBBBB009931"
* date = "2022-03-30T11:24:26+01:00"
* description = "Informe Prueba Laboratorio"
* content[0].attachment.contentType = #application/fhir+json
* content[=].attachment.language = #cs
* content[=].attachment.url = "/bundle/20160201-XXXXXXX"
