{{/*
Expand the name of the chart.
*/}}
{{- define "curious-human-lib.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "curious-human-lib.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "curious-human-lib.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "curious-human-lib.labels" -}}
helm.sh/chart: {{ include "curious-human-lib.chart" . }}
{{ include "curious-human-lib.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "curious-human-lib.selectorLabels" -}}
app.kubernetes.io/name: {{ include "curious-human-lib.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "curious-human-lib.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "curious-human-lib.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Defined port, or default to 3000
*/}}
{{- define "curious-human-lib.servicePort" -}}
{{- if .Values.service }}
{{- default 3000 .Values.service.port }}
{{- else }}
{{- 3000 }}
{{- end }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "curious-human-lib.namespace" -}}
{{- if .Values.global.namespaceOverride }}
namespace: {{ .Values.global.namespaceOverride }}
{{- end }}
{{- end }}
