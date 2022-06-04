{{/*
Env vars consistent across containers
*/}}
{{- define "curious-human-lib.envK8s" -}}
- name: K8S_SERVICE_PORT
  value: "{{ .Values.service.port }}"
- name: K8S_APP_NAME
  value: "{{ include "curious-human-lib.name" . }}"
- name: K8S_RELEASE_NAME
  value: "{{ .Release.Name }}"
- name: K8S_RELEASE_NAMESPACE
  value: "{{ .Release.Namespace }}"
{{- if .Values.global.umbrellaRelease }}
- name: K8S_UMBRELLA_RELEASE_NAME
  value: "{{ .Values.global.umbrellaRelease }}"
{{- end }}
{{- $debug := default .Values.local.debug .Values.global.debug -}}
{{- if $debug }}
- name: DEBUG
  value: "true"
{{- end }}
{{- end }}

{{/*
MongoDB ENV vars
*/}}
{{- define "curious-human-lib.envMongoDb" -}}
{{- if .Values.mongodb }}
{{- if .Values.mongodb.service }}
- name: MONGODB_PORT
  {{- if .Values.mongodb.service.ports }}
  value: "{{ .Values.mongodb.service.ports.mongodb }}"
  {{- else }}
  value: "{{ .Values.mongodb.service.port }}"
  {{- end -}}
{{- end -}}
{{- if .Values.mongodb.auth }}
- name: MONGODB_DATABASE
  value: "{{ first .Values.mongodb.auth.databases }}"
{{- if .Values.mongodb.auth.enabled }}
- name: MONGODB_USERNAME
  value: "{{ first .Values.mongodb.auth.usernames }}"
- name: MONGODB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mongodb.auth.existingSecret }}
      key: mongodb-passwords
{{- end -}}
{{- end -}}
{{- end }}
{{- end }}

{{/*
Salesforce ENV vars
*/}}
{{- define "curious-human-lib.envSalesforce" -}}
{{- if .Values.salesforce }}
{{- if .Values.salesforce.enabled }}
{{- $urlPrefix := ternary "test" "login" .Values.salesforce.sandbox -}}
- name: SALESFORCE_URL_AUTH
  value: "{{ printf "https://%s.salesforce.com" $urlPrefix }}"
- name: SALESFORCE_URL_DATA
  value: "{{ .Values.salesforce.url }}"
- name: SALESFORCE_URL_DATA_VERSION
  value: "{{ .Values.salesforce.apiVersion }}"
- name: SALESFORCE_USER
  value: "{{ .Values.salesforce.username }}"
- name: SALESFORCE_CONSUMER_KEY
  valueFrom:
    secretKeyRef:
      name: co-api-salesforce
      key: consumer-key
- name: SALESFORCE_CERTIFICATE_KEY
  valueFrom:
    secretKeyRef:
      name: co-api-salesforce
      key: certificate-key
{{- end }}
{{- end }}
{{- end }}

{{/*
Container ports
*/}}
{{- define "curious-human-lib.containerPorts" -}}
{{- if .Values.ports }}
{{- range .Values.ports }}
- name: {{ .name }}
  containerPort: {{ .port }}
  protocol: {{ .protocol }}
{{- end }}
{{- else }}
- name: {{ .Values.service.portName }}
  containerPort: {{ .Values.service.port }}
  protocol: {{ .Values.service.protocol }}
{{- end }}
{{- end }}

{{/*
Container probes
*/}}
{{- define "curious-human-lib.containerProbes" -}}
{{- if .Values.livenessProbe }}
livenessProbe:
{{- toYaml .Values.livenessProbe | nindent 2 }}
{{- end }}
{{- if .Values.startupProbe }}
startupProbe:
{{- toYaml .Values.startupProbe | nindent 2 }}
{{- end }}
{{- if .Values.readinessProbe }}
readinessProbe:
{{- toYaml .Values.readinessProbe | nindent 2 }}
{{- end }}
{{- end }}
