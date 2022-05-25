
Steps:
1.  create kind cluster
```

kind create cluster  --name cluster

```
2. Run terraform
```
alias tf=terraform
tf init
tf apply
```

3. Check grafana
```
sudo kubefwd svc -c ~/.kube/config -n monitoring

```
Chek URL in browser: http://prometheus-grafana:80

4. 