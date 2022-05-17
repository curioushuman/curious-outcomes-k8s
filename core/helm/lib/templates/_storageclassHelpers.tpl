{{/*
Storage class name
*/}}
{{- define "curious-human-lib.storageClassName" -}}
{{- if .Values.storageClass.create }}
{{- default (include "curious-human-lib.fullname" .) .Values.storageClass.name }}
{{- else }}
{{- default "default" .Values.storageClass.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for the storage class
*/}}
{{- define "curious-human-lib.storageClassApiVersion" -}}
{{- default "storage.k8s.io/v1" .Values.storageClass.apiVersion -}}
{{- end }}

{{/*
Provisioner
*/}}
{{- define "curious-human-lib.storageClassProvisioner" -}}
{{- default "kubernetes.io/no-provisioner" .Values.storageClass.provisioner }}
{{- end }}

{{/*
Volume expansion policy
*/}}
{{- define "curious-human-lib.storageClassVolumeExpansion" -}}
{{- default "false" .Values.storageClass.allowVolumeExpansion }}
{{- end }}

{{/*
Volume binding mode
*/}}
{{- define "curious-human-lib.storageClassVolumeBinding" -}}
{{- default "WaitForFirstConsumer" .Values.storageClass.volumeBindingMode }}
{{- end }}

{{/*
Reclaim policy
*/}}
{{- define "curious-human-lib.storageClassReclaimPolicy" -}}
{{- default "Retain" .Values.storageClass.reclaimPolicy }}
{{- end }}
