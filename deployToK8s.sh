#!/bin/bash

kubectl get pods -n dev --no-headers=true | awk '/meal-planner-fe/{print $1}' | xargs kubectl delete pod -n dev
