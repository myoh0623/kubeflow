kubectl delete deployments.apps training-operator -n kubeflow
kustomize build ~/kubeflow/manifests/apps/training-operator/upstream/overlays/kubeflow | kubectl apply -f -
while true; do kubectl port-forward --address="0.0.0.0" svc/istio-ingressgateway -n istio-system 8080:80; done
