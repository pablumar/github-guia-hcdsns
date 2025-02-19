Profile: DocumentReferenceRefHCSNS
Parent: DocumentReference
Id: DocumentReference-refHC-sns
Title: "DocumentReference: Referencias HC"
Description: "Este perfil define la referencia a una HC de la que dispone el paciente en una CA"
* status = #current
* status ^short = "Estado de esta referencia"
* subject.identifier 1..1
* subject.identifier.system 1..1
* subject.identifier.value 1..1
* subject.identifier ^short = "Identificador CIP-SNS del paciente"
* date 1..1
* description 1..

* extension contains
    FlagOculto named patient-flag-oculto 0..1 and
    Operacion named patient-operation 0..1

* extension[FlagOculto].valueString only string
* extension[Operacion].valueString only string

* custodian.identifier 1..1 
* custodian.identifier ^short = "Identificador del agente donde se encuentra la HC del paciente"

* description ^short = "Descripción de la referencia"
* content obeys docref-no-data
* content.attachment.contentType ^short = "Tipo de dato (application/fhir+json; application/pdf)"
* content.attachment.url ^short = "Identificador de acceso al informe"
* content.attachment.language ^short = "Idioma asociado al informe"

