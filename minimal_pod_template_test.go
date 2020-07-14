// minimal_pod_template_test  file 
=== RUN   TestPodTemplateRendersContainerImage
Running command helm with args [template --set image=nginx:1.15.8 --show-only templates/pod.yaml nginx ../charts/minimal-pod]
---
# Source: minimal-pod/templates/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-minimal-pod
  labels:
    app.kubernetes.io/name: minimal-pod
    helm.sh/chart: minimal-pod-0.1.0
    app.kubernetes.io/instance: nginx
    app.kubernetes.io/managed-by: Helm
spec:
  containers:
    - name: minimal-pod
      image: "nginx:1.15.8"
      ports:
        - name: http
          containerPort: 80
          protocol: TCP
--- PASS: TestPodTemplateRendersContainerImage (0.05s)
PASS
ok      github.com/gruntwork-io/helm-chart-testing-example/test 0.086s
