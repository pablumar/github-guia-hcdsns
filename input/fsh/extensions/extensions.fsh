Extension: NumRefIncorrectas
Id:   num-ref-incorrectas
Title:  "Número Referencias Incorrectas"
Description: "Número de referencias que incorrectas que había en el mensaje original"
* insert ExtensionContext(BundleSNS)
* insert SetFmmandStatusRule ( 2, trial-use)
* value[x] only string

Extension: FlagOculto
Id:   patient-flag-oculto
Title:  "Flag Oculto"
Description: "Flag Oculto"
* insert ExtensionContext(DocumentReferenceRefHCSNS)
* insert SetFmmandStatusRule ( 2, trial-use)
* value[x] only string

Extension: Operacion
Id:   patient-operacion
Title:  "Operacion"
Description: "Operacion"
* insert ExtensionContext(DocumentReferenceRefHCSNS)
* insert SetFmmandStatusRule ( 2, trial-use)
* value[x] only string