{{- define "curious-human-lib.issuer.tpl" -}}
{{- $relName := include "curious-human-lib.name" . -}}
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-{{ $relName }}
  {{- include "curious-human-lib.namespace" . | nindent 2 }}
spec:
  acme:
    email: {{ default "mike@curioushuman.com.au" .Values.issuer.email }}
    server: {{ default "https://acme-v02.api.letsencrypt.org/directory" .Values.issuer.server }}
    privateKeySecretRef:
      name: letsencrypt-{{ $relName }}-secret
    solvers:
      # Use the HTTP-01 challenge provider
      - http01:
          ingress:
            class: nginx
{{- end -}}
{{- define "curious-human-lib.issuer" -}}
{{- include "curious-human-lib.util.merge" (append . "curious-human-lib.issuer.tpl") -}}
{{- end -}}
