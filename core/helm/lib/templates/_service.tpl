{{- define "curious-human-lib.service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "curious-human-lib.fullname" . }}
  labels:
    {{- include "curious-human-lib.labels" . | nindent 4 }}
  {{- include "curious-human-lib.namespace" . | nindent 2 }}
spec:
  type: {{ .Values.service.type }}
  ports:
  {{- if .Values.ports }}
    {{- range .Values.ports }}
    - port: {{ .port }}
      targetPort: {{ .targetPort }}
      protocol: {{ .protocol }}
      name: {{ .name }}
    {{- end }}
  {{- else }}
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: {{ .Values.service.protocol }}
      name: {{ .Values.service.portName }}
  {{- end }}
  selector:
    {{- include "curious-human-lib.selectorLabels" . | nindent 4 }}
{{- end -}}
{{- define "curious-human-lib.service" -}}
{{- include "curious-human-lib.util.merge" (append . "curious-human-lib.service.tpl") -}}
{{- end -}}
