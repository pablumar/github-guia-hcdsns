Profile: PatientMinimalSNS
Parent: Patient
Id: PatientMinimalSNS
Title:    "Paciente Datos Minimos"
Description: """Este perfil define como se modela un Paciente con datos mínimos en FHIR como propósito de esta guía."""

* insert SetFmmandStatusRule ( 2, trial-use)
* id ^short = "Identificador interno del paciente y que servirá como referencia a la hora de recuperarlo por id interno del recurso"
* id 1..1
* identifier ^short = "Identificadores del Paciente" 
* active ^short = "Estado del paciente: True --> Activo, False --> Pasivo"

* name.family ^example.valueString = "Valero Iglesias"
* name.given ^example.valueString = "Borja"

* name.given ^short = "Nombre"
* name.family ^short = "Apellidos"
* name.family ^definition = """Cuando los apellidos están compuestos por más de uno, este elemento documenta el apellido compuesto completo con la concatenación de ambos. Las partes se registran en las extensiones de los apellidos del padre y de la madre."""
* name.family ^example.label = "español"
* name.family ^example.valueString = "Valero Iglesias"
* gender ^short = "male | female | other | unknown"
* gender from AdministrativeGender (required)
* birthDate 1..1 // MS according to IPS
* birthDate ^short = "Fecha de nacimiento"