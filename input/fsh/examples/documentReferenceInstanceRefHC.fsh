Alias: $loinc = http://loinc.org

Instance: DocumentReferenceRefHC
InstanceOf: DocumentReferenceRefHCSNS
Usage: #example
Title: "DocumentReference: Referencias HC"
Description: "Ejemplo de DocumentReference Referencias Historias Clínicas del paciente"
* masterIdentifier.system = "http://example.org"
* masterIdentifier.value = "ba91c64b-f30c-4137-a484-34bbba5e8804"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.2.120.4.4"
* identifier.value = "c030702.TSTSMN63A01F205H.20220325112426.TSS1Tkju"
* status = #current
* type = $loinc#11502-2 "Laboratory report"
* category = $loinc#18719-5 "Chemistry studies (set)"
* subject.identifier.system = "2.16.724.4.40"
* subject.identifier.value = "BBBBBBBBBB009931"
* date = "2022-03-30T11:24:26+01:00"
* description = "Informe Prueba Laboratorio"
* custodian.identifier.system = "www.example.org" 
* custodian.identifier.value = "210601"
* content[0].attachment.contentType = #application/fhir+json
* content[=].attachment.language = #es