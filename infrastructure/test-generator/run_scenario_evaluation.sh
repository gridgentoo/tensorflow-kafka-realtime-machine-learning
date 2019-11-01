#!/usr/bin/env bash

if ! hash kubectl 2>/dev/null; then
    echo "ERROR: You must install kubectl to use this script"
    exit 1
fi

echo "Creating the monitoring dashboard configuration"
kubectl create -n monitoring configmap devsim-dashboard --from-file=devsim.json || true
kubectl label -n monitoring configmap/devsim-dashboard grafana_dashboard=1 || true

echo "Running the scenario ad-hoc..."
exec ./kube-cli.sh run --rbac --enable-monitoring -s scenario_evaluation.xml -l car-demo -i sbaier1/device-simulator:avro