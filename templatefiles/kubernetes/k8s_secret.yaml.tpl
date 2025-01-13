apiVersion: v1
kind: Secret
metadata:
  name: rsa-private-key-secret
  namespace: default
data:
  rsa_key: "${rsa_key_base64}"