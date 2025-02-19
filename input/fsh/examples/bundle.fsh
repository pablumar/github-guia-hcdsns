Alias: $loinc = http://loinc.org
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $sct = http://snomed.info/sct

Instance: BundleLabResultReportPOC
InstanceOf: Bundle
Title: "Bundle: Ejemplo"
Description: "Bundle: Laboratory Result Report for POC"
Usage: #example
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Bundle-lab-myhealtheu"
* identifier.system = "http://example.org"
* identifier.value = "ba91c64b-f30c-4137-a484-34bbba5e8804"
* type = #document
* timestamp = "2023-03-06T14:30:00+01:00"
* entry[0].fullUrl = "urn:uuid:4028a0b8-37fc-4491-a8e7-0f28e6fc59b4"
* entry[=].resource = 4028a0b8-37fc-4491-a8e7-0f28e6fc59b4
* entry[+].fullUrl = "urn:uuid:f5d20fe5-6d14-46de-80ea-8124f427a754"
* entry[=].resource = Inline-Diagnostic-Report-lab-report
* entry[+].fullUrl = "urn:uuid:a3d70b1b-cd31-4b38-9008-e9b29d2cb769"
* entry[=].resource = a3d70b1b-cd31-4b38-9008-e9b29d2cb769
* entry[+].fullUrl = "urn:uuid:8bd279af-125a-4318-b461-ba5629b12e7f"
* entry[=].resource = 8bd279af-125a-4318-b461-ba5629b12e7f
* entry[+].fullUrl = "urn:uuid:2e861278-2e99-4ffa-befa-049467a095b2"
* entry[=].resource = Inline-ServiceRequest-lab-report
* entry[+].fullUrl = "urn:uuid:ce122b36-f942-4cee-8c6d-b13ece8cf23c"
* entry[=].resource = ce122b36-f942-4cee-8c6d-b13ece8cf23c
* entry[+].fullUrl = "urn:uuid:3c9bd730-3ff9-40ee-9da1-4f3d5c526f13"
* entry[=].resource = 3c9bd730-3ff9-40ee-9da1-4f3d5c526f13
* entry[+].fullUrl = "urn:uuid:cc181238-0819-402f-9523-681df2c5ba08"
* entry[=].resource = cc181238-0819-402f-9523-681df2c5ba08
* entry[+].fullUrl = "urn:uuid:8b3a8660-e8a2-4ab8-9766-b9f87fc1186b"
* entry[=].resource = 8b3a8660-e8a2-4ab8-9766-b9f87fc1186b

Instance: 4028a0b8-37fc-4491-a8e7-0f28e6fc59b4
InstanceOf: Composition
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Composition-lab-myhealtheu"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:3f69e0a5-2177-4540-baab-7a5d0877428f"
* status = #final
* type = $loinc#11502-2 "Laboratory report"
* category = $loinc#18717-9 "Blood bank studies (set)"
* subject = Reference(urn:uuid:a3d70b1b-cd31-4b38-9008-e9b29d2cb769)
* date = "2023-03-09T14:30:00+01:00"
* author = Reference(urn:uuid:8b3a8660-e8a2-4ab8-9766-b9f87fc1186b) "Dr. Patrick Dempsey"
* title = "Laboratory Report - 10 March, 2023 14:30"
* confidentiality = #N
* attester.mode = #legal
* attester.time = "2020-12-27T14:30:00+01:00"
* attester.party = Reference(urn:uuid:ce122b36-f942-4cee-8c6d-b13ece8cf23c)
* custodian = Reference(urn:uuid:ce122b36-f942-4cee-8c6d-b13ece8cf23c)
* section.title = "Blood group lab result report"
* section.code = $loinc#26436-6 "Laboratory studies (set)"
* section.code.text = "Laboratory studies"
* section.entry = Reference(urn:uuid:8bd279af-125a-4318-b461-ba5629b12e7f)

Instance: Inline-Diagnostic-Report-lab-report
InstanceOf: DiagnosticReport
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/DiagnosticReport-lab-myhealtheu"
* extension.url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-DiagnosticReport.composition"
* extension.valueReference = Reference(urn:uuid:4028a0b8-37fc-4491-a8e7-0f28e6fc59b4)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:3f69e0a5-2177-4540-baab-7a5d0877428f"
* status = #final
* category = $loinc#18717-9 "Blood bank studies (set)"
* code = $loinc#11502-2 "Laboratory report"
* subject = Reference(urn:uuid:a3d70b1b-cd31-4b38-9008-e9b29d2cb769)
* effectiveDateTime = "2023-04-19T15:46:00+01:00"
* performer.display = "Dr. Patrick Dempsey"

Instance: a3d70b1b-cd31-4b38-9008-e9b29d2cb769
InstanceOf: Patient
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Patient-lab-myhealtheu"
* identifier[0].type = $v2-0203#NIIP
* identifier[=].system = "urn:oid:1.2.203.24341.1.20.2"
* identifier[=].value = "740512852"
* identifier[+].system = "urn:oid:1.2.203.24341.1.20.9.1"
* identifier[=].value = "A225961454"
* identifier[+].type = $v2-0203#PPN
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.330.203"
* identifier[=].value = "5484136"
* name.family = "Doe"
* name.given = "John"
* gender = #male
* birthDate = "2000-03-21"

Instance: 8bd279af-125a-4318-b461-ba5629b12e7f
InstanceOf: Observation
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Observation-resultslab-lab-myhealtheu"
* status = #final
* category[0] = $observation-category#laboratory
* category[+] = $loinc#18717-9 "Blood bank studies (set)"
* code = $loinc#883-9 "ABO group [Type] in Blood"
* code.text = "Blood Group"
* subject = Reference(urn:uuid:a3d70b1b-cd31-4b38-9008-e9b29d2cb769)
* effectiveDateTime = "2023-03-09T13:35:00+01:00"
* performer.display = "Dr. Patrick Dempsey"
* valueCodeableConcept = $sct#112144000 "Blood group A (finding)"
* valueCodeableConcept.text = "A"

Instance: Inline-ServiceRequest-lab-report
InstanceOf: ServiceRequest
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/ServiceRequest-lab-myhealtheu"
* identifier.system = "http://example.org"
* identifier.value = "2e861278-2e99-4ffa-befa-049467a095b2"
* status = #active
* intent = #order
* code = $loinc#883-9 "ABO group [Type] in Blood"
* subject = Reference(urn:uuid:a3d70b1b-cd31-4b38-9008-e9b29d2cb769)
* specimen = Reference(urn:uuid:3c9bd730-3ff9-40ee-9da1-4f3d5c526f13)

Instance: ce122b36-f942-4cee-8c6d-b13ece8cf23c
InstanceOf: Organization
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Organization-eu-myhealth-eu"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.1.2"
* identifier.value = "120148"
* identifier.assigner.display = "Good Organization"
* name = "Good Organization"
* telecom.system = #phone
* telecom.value = "390 666 0581"
* telecom.use = #work
* address.line = "Via Emilio Praga 39"
* address.line.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-censusTract"
* address.line.extension.valueString = "058091"
* address.city = "Roma"
* address.district = "RM"
* address.state = "120"
* address.postalCode = "00137"
* address.country = "100"

Instance: 3c9bd730-3ff9-40ee-9da1-4f3d5c526f13
InstanceOf: Specimen
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Specimen-lab-myhealtheu"
* status = #available
* type = $sct#119297000 "Blood specimen"
* type.text = "Blood specimen"

Instance: cc181238-0819-402f-9523-681df2c5ba08
InstanceOf: Practitioner
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/Practitioner-eu-myhealth-eu"
* name.text = "Dr. Patrick Dempsey"
* name.family = "Dempsey"
* name.given = "Patrick"

Instance: 8b3a8660-e8a2-4ab8-9766-b9f87fc1186b
InstanceOf: PractitionerRole
Usage: #inline
* meta.profile = "http://fhir.ehdsi.eu/laboratory/StructureDefinition/PractitionerRole-eu-myhealth-eu"
* practitioner = Reference(urn:uuid:cc181238-0819-402f-9523-681df2c5ba08) "Dr. Patrick Dempsey"
* organization = Reference(urn:uuid:ce122b36-f942-4cee-8c6d-b13ece8cf23c) "Good Organization"